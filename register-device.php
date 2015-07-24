<?php
//Establish a database connection
include 'databaseConnector.php';
$databaseConnector = new databaseConnector();
$database = $databaseConnector->connectToDb();

//Get JSON from request
$json = json_decode(file_get_contents('php://input'), true);

//Get variables from JSON
$id = $json["device_id"];
$oldId = $json["old_device_id"];
$device_name = $json{"tracking_device_type"};
$update_name = $json{"tracking_update_type"};
//Get IDs from supplied device names
$device_id = "0";
$update_id = "0";
$result1 = $database->query("SELECT * FROM Tracking_device_type WHERE device_type = '".$device_name."' AND enabled = TRUE");
while ($row = mysqli_fetch_assoc($result1)) {
    $device_id = $row['id'];
}
$result2 = $database->query("SELECT * FROM Tracking_update_type WHERE update_type = '".$update_name."'");
while ($row2 = mysqli_fetch_assoc($result2)) {
    $update_id = $row2["id"];
}

//Check if supplied data is valid
if($device_id == "0") {
    $error = array(
        "error" => "Invalid tracking device specified."
    );
    $database->close();
    header('Content-type: application/json');
    http_response_code(500);
    echo(json_encode($error));
}

if($update_id == "0") {
    $error = array(
        "error" => "Invalid tracking update type specified."
    );
    $database->close();
    header('Content-type: application/json');
    http_response_code(500);
    echo(json_encode($error));
}

//Delete old registration from the database

try {
    $result2 = $database->query("DELETE FROM Device_registration where device_id = '$oldId'");
}
catch (Exception $error) {
    $error_list = array(
        "error"=>$error->getMessage()
    );
    $database->close();
    header('Content-type: application/json');
    http_response_code(500);
    echo(json_encode($error_list));
}

try {
    $result = $database->query("INSERT INTO Device_registration(device_id, tracking_device_type_id, tracking_update_type_id, datetime) VALUES ('$id', '$device_id', '$update_id', NOW())");
}
catch (Exception $error) {
    $error_list = array(
        "error"=> $error->getMessage()
    );
    $database->close();
    header('Content-type: application/json');
    http_response_code(500);
    echo(json_encode($error_list));
}
$database->close();
$success = array(
    "success"=> "Device with id '".$id."' has been registered."
);
header('Content-type: application/json');
echo(json_encode($success));

