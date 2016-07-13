<?php
include 'Repository/DatabaseConnector.php';
$device_id = $_GET["device_id"];
$databaseConnector = new DatabaseConnector();
$database = $databaseConnector->connectToDb();

$query = "SELECT id, update_method, update_method_nl FROM update_method WHERE id IN (SELECT update_method_id FROM update_data_link WHERE device_id = $device_id)";

if($device_id != null && $device_id != "") {
    $result = $database->query($query);

    // Return the output as JSON
    header('Content-type: application/json');
    echo (json_encode($result->fetchAll(PDO::FETCH_ASSOC)));

    // Disconnect from the database
    $database = null;
}
else {
    // Return the error as JSON
    http_response_code(500);
    header('Content-type: application/json');
    $error = array("error" => "No device ID specified.");
    echo (json_encode($error));

    // Disconnect from the database
    $database = null;
}
