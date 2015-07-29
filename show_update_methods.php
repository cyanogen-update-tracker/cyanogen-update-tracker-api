<?php
include 'Repository/DatabaseConnector.php';
$device_id = $_GET["device_id"];
$databaseConnector = new DatabaseConnector();
$database = $databaseConnector->connectToDb();

$query_all = "SELECT * FROM update_method";
$query_limited = "SELECT * FROM update_method WHERE id IN (SELECT update_method_id FROM update_data_link WHERE device_type_id = $device_id)";

if($device_id != null && $device_id != "") {
    $update_list = $database->query($query_limited);
}
else {
    $update_list = $database->query($query_all);
}

// Return the output as JSON
header('Content-type: application/json');
echo (json_encode($update_list->fetchAll(PDO::FETCH_ASSOC)));

// Disconnect from the database
$database = null;