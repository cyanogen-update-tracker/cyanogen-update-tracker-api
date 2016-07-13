<?php
include 'Repository/DatabaseConnector.php';
$device_id = $_GET["device_id"];
$update_method_id = $_GET["update_method_id"];
$databaseConnector = new DatabaseConnector();
$database = $databaseConnector->connectToDb();
if($device_id != null && $update_method_id != null && $device_id != "" && $update_method_id != "") {
    $query = $database->query("SELECT * FROM update_data WHERE device_id = $device_id AND update_method_id = $update_method_id");

    $result = $query->fetchAll(PDO::FETCH_OBJ)[0];
    // Return the output as JSON
    header('Content-type: application/json');
    if($result) {
        echo(json_encode($result));
    } else {
        echo json_encode(array("errors" => "no update information available"));
    }

    // Disconnect from the database
    $database = null;
}
else {
    header('Content-type: application/json');
    $error = array("error" => "No device ID and / or update method ID supplied.");
    echo(json_encode($error));
}
