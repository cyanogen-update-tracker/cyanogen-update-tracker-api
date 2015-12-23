<?php
include 'Repository/DatabaseConnector.php';
$device_id = $_GET["device_id"];
$update_method_id = $_GET["update_method_id"];
$databaseConnector = new DatabaseConnector();
$database = $databaseConnector->connectToDb();
if($device_id != null && $update_method_id != null && $device_id != "" && $update_method_id != "") {
    $query = $database->query("SELECT * FROM update_data WHERE device_id = $device_id AND update_method_id = $update_method_id");

// Return the output as JSON
    header('Content-type: application/json');
    echo(json_encode($query->fetchAll(PDO::FETCH_OBJ)[0]));

// Disconnect from the database
    $database = null;
}
else {
    header('Content-type: application/json');
    $error = array("error" => "No device ID and / or update method ID supplied.");
    echo(json_encode($error));
}