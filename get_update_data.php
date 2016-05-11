<?php
include 'Repository/DatabaseConnector.php';

// Obtain all required request parameters.
$device_id = $_GET["device_id"];
$update_method_id = $_GET["update_method_id"];
$incremental_parent = $_GET["incremental_parent"];

// Set the return type to JSON.
header('Content-type: application/json');

// Check if all required query parameters are set.
if($device_id != null && $update_method_id != null && $device_id != "" && $update_method_id != "") {

    // Connect to the database
    $databaseConnector = new DatabaseConnector();
    $database = $databaseConnector->connectToDb();

    // Test if the update method uses the new Incremental (parent) system or not.
    $updateMethodQuery = $database->prepare("SELECT * FROM update_method WHERE id = :update_method_id");
    $updateMethodQuery->bindParam(':update_method_id', $update_method_id);
    $updateMethodQuery->execute();

    $updateMethod = $updateMethodQuery->fetch(PDO::FETCH_ASSOC);

    // For incremental updates, search for new versions using the provided base version (incremental_parent)
    if ($updateMethod['requires_incremental_parent'] == true) {
        $query = $database->prepare("SELECT * FROM update_data_new WHERE device_id = :device_id AND update_method_id = :update_method_id AND incremental_parent = :incremental_parent");
        $query->bindParam(':device_id', $device_id);
        $query->bindParam(':update_method_id', $update_method_id);
        $query->bindParam(':incremental_parent', $incremental_parent);
        $query->execute();
    }
    // For full updates, search for new versions using the "is_latest_version" boolean from the database
    else {
        $query = $database->prepare("SELECT * FROM update_data_new WHERE device_id = :device_id AND update_method_id = :update_method_id AND is_latest_version = 1 ORDER BY id DESC LIMIT 1");
        $query->bindParam(':device_id', $device_id);
        $query->bindParam(':update_method_id', $update_method_id);
        $query->execute();
    }

    // If there are no results, the system is up to date or no update information has been found. Else, return the result.
    if($query->rowCount() == 0) {
        echo json_encode(array("information" => "unable to find a more recent build"));
    } else {
        echo(json_encode($query->fetch(PDO::FETCH_ASSOC)));
    }

    // Disconnect from the database
    $database = null;
}
// If the device or update method IDs are not supplied, throw an error message.
else {
    echo(json_encode(array("error" => "No device ID and / or update method ID supplied.")));
}
