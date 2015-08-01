<?php
//Establish a database connection
include 'Repository/DatabaseConnector.php';
$databaseConnector = new DatabaseConnector();
$database = $databaseConnector->connectToDb();

//Get JSON from request
$json = json_decode(file_get_contents('php://input'), true);

//Get variables from JSON
$registrationToken = $json["registration_token"];
$oldRegistrationToken = $json["old_registration_token"];
$deviceId = $json{"device_id"};
$updateMethodId = $json{"update_method_id"};
$appVersion = $json["app_version"];

//Check if supplied data is valid
if($deviceId == null || $deviceId == "") {
    $error = array(
        "error" => "Invalid device ID specified."
    );
    $database = null;
    header('Content-type: application/json');
    http_response_code(500);
    echo(json_encode($error));
}

if($updateMethodId == null || $updateMethodId == "") {
    $error = array(
        "error" => "Invalid update method ID specified."
    );
    $database = null;
    header('Content-type: application/json');
    http_response_code(500);
    echo(json_encode($error));
}

//Delete old registration from the database if it is supplied
if($oldRegistrationToken != null && $oldRegistrationToken != "") {
    $deleteResult = $database->query("DELETE FROM device_registration where registration_token = '$oldRegistrationToken'");
    $deleteResult->execute();
}

// register the device to the database.
$result = $database->query("INSERT INTO device_registration(registration_token, device_id, update_method_id, registration_date, app_version) VALUES ('$registrationToken', '$deviceId', '$updateMethodId', NOW(), '$appVersion')");
$result->execute();

// Disconnect from the database.
$database = null;
if($deviceId != null && $deviceId != "" && $result->rowCount() > 0) {
    $success = array(
        "success"=> "Device with token '".$registrationToken."' has been registered."
    );
    header('Content-type: application/json');
    echo(json_encode($success));
}