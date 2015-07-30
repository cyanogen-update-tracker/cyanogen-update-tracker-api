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
$deviceTypeId = $json{"device_id"};
$updateMethodId = $json{"update_method_id"};
$appVersion = $json["app_version"];

//Check if supplied data is valid
if($deviceTypeId == null || $deviceTypeId == "") {
    $error = array(
        "error" => "Invalid tracking device specified."
    );
    $database = null;
    header('Content-type: application/json');
    http_response_code(500);
    echo(json_encode($error));
}

if($updateMethodId == "") {
    $error = array(
        "error" => "Invalid tracking update type specified."
    );
    $database = null;
    header('Content-type: application/json');
    http_response_code(500);
    echo(json_encode($error));
}

//Delete old registration from the database

try {
    $result2 = $database->query("DELETE FROM device_registration where registration_token = '$oldRegistrationToken'");
}
catch (Exception $error) {
    $error_list = array(
        "error"=>$error->getMessage()
    );
    $database = null;
    header('Content-type: application/json');
    http_response_code(500);
    echo(json_encode($error_list));
}

try {
    $result = $database->query("INSERT INTO device_registration(registration_token, device_type_id, update_method_id, registration_date, app_version) VALUES ('$registrationToken', '$deviceTypeId', '$updateMethodId', NOW(), '$appVersion')");
}
catch (Exception $error) {
    $error_list = array(
        "error"=> $error->getMessage()
    );
    $database = null;
    header('Content-type: application/json');
    http_response_code(500);
    echo(json_encode($error_list));
}
$database = null;
if($deviceTypeId != "0") {
    $success = array(
        "success"=> "Device with id '".$registrationToken."' has been registered."
    );
    header('Content-type: application/json');
    echo(json_encode($success));
}