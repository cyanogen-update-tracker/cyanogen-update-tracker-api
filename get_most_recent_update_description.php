<?php
include 'Repository/DatabaseConnector.php';

// Obtain all required request parameters.
$device_id = $_GET["device_id"];
$update_method_id = $_GET["update_method_id"];

header('Content-type: application/json');

if($device_id != null && $update_method_id != null && $device_id != "" && $update_method_id != "") {

    // Connect to the database
    $databaseConnector = new DatabaseConnector();
    $database = $databaseConnector->connectToDb();

    $query = $database->prepare("SELECT description FROM update_data_new WHERE device_id = :device_id AND update_method_id = :update_method_id AND is_latest_version = 1 ORDER BY id DESC LIMIT 1");
    $query->bindParam(':device_id', $device_id);
    $query->bindParam(':update_method_id', $update_method_id);
    $query->execute();

    if($query->rowCount() == 0) {
        echo json_encode(array("error" => "unable to find update description"));
    } else {
        echo(json_encode($query->fetch(PDO::FETCH_ASSOC)));
    }

    // Disconnect from the database
    $database = null;
}
else {
    echo(json_encode(array("error" => "No device ID and / or update method ID supplied.")));
}
