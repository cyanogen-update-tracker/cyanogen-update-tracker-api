<?php
include 'Repository/DatabaseConnector.php';

//Get the JSON from the request body
$json = json_decode(file_get_contents('php://input'), true);

//Get required requrest parameters from the JSON body.
$registrationToken = $json["registration_token"];
$oldRegistrationToken = $json["old_registration_token"];
$deviceId = $json{"device_id"};
$updateMethodId = $json{"update_method_id"};
$appVersion = $json["app_version"];

// Set the return type to JSON.
header('Content-type: application/json');

// Check if all required query parameters are set.
if($deviceId == null || $deviceId == "") {
    http_response_code(500);
    echo(json_encode(array("error" => "No device ID specified.")));
} else if($updateMethodId == null || $updateMethodId == "") {
    http_response_code(500);
    echo(json_encode(array("error" => "No update method ID specified.")));
} else if ($registrationToken == null || $registrationToken == "" || strpos($registrationToken, "com.arjanvlek.cyngnotainfo") === TRUE) { // Sometimes a device registers with the package name. This is not valid and has to be prevented!
    http_response_code(500);
    echo(json_encode(array("error" => "No or invalid registration token specified.")));
} else {
    //Establish a database connection
    $databaseConnector = new DatabaseConnector();
    $database = $databaseConnector->connectToDb();

    //Delete any old registration from the database if an old registration token is supplied
    if ($oldRegistrationToken != null && $oldRegistrationToken != "") {
        $deleteQuery = $database->prepare("DELETE FROM device_registration WHERE registration_token = :old_registration_token");
        $deleteQuery->bindParam(':old_registration_token', $oldRegistrationToken);
        $deleteQuery->execute();
    }

    // Register the device to the database.
    $query = $database->prepare("INSERT INTO device_registration(registration_token, device_id, update_method_id, registration_date, app_version) VALUES (:registration_token, :device_id, :update_method_id, NOW(), :app_version)");
    $query->bindParam(':registration_token', $registrationToken);
    $query->bindParam(':device_id', $deviceId);
    $query->bindParam(':update_method_id', $updateMethodId);
    $query->bindParam(':app_version', $appVersion);
    $query->execute();

    // Disconnect from the database.
    $database = null;

    // Return a success message if the device is actually registered
    if ($query->rowCount() > 0) {
        echo(json_encode(array("success" => "Device with token '" . $registrationToken . "' has been registered.")));
    } else {
        echo(json_encode(array("error" => "Unable to register device with token '" . $registrationToken . "'.")));
    }
}