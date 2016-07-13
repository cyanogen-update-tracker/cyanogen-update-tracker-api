<?php
include 'Repository/DatabaseConnector.php';
$device_id = $_GET["device_id"];
$databaseConnector = new DatabaseConnector();
$database = $databaseConnector->connectToDb();



if($device_id != null && $device_id != "") {
    $query = $database->prepare("SELECT um.id, um.update_method, um.update_method_nl FROM update_method um JOIN device_update_method du ON um.id = du.update_method_id WHERE du.device_id = :device_id");

    $query->bindParam(':device_id', $device_id);
    $query->execute();

    // Return the output as JSON
    header('Content-type: application/json');
    echo (json_encode($query->fetchAll(PDO::FETCH_ASSOC)));

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
