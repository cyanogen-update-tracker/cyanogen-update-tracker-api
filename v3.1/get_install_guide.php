<?php
include 'Repository/DatabaseConnector.php';

// Obtain all required request parameters.
$device_id = $_GET["device_id"];
$update_method_id = $_GET["update_method_id"];
$page_number = $_GET["page_number"];

// Set the return type to JSON.
header('Content-type: application/json');

// Check if all required query parameters are set.
if($device_id != null && $device_id != "" && $update_method_id != null && $update_method_id != "" && $page_number != null && $page_number != "") {

    // Connect to the database
    $databaseConnector = new DatabaseConnector();
    $database = $databaseConnector->connectToDb();

    // Fetch all update methods that are enabled for this device.

    $query = $database->prepare ("SELECT * FROM install_guide where device_id = :device_id AND update_method_id = :update_method_id AND page_number = :page_number AND is_custom_page = 1");
    $query->bindParam(':device_id', $device_id);
    $query->bindParam(':update_method_id', $update_method_id);
    $query->bindParam(':page_number', $page_number);
    $query->execute();

    // Return the output as JSON
    if($query->rowCount() == 0) {
        echo "{}";
    } else {
        echo (json_encode($query->fetch(PDO::FETCH_ASSOC)));
    }

    // Disconnect from the database
    $database = null;
}
else {
    // If the device ID is not supplied, throw an error message.
    http_response_code(500);
    header('Content-type: application/json');
    echo (json_encode(array("error" => "No device ID, update method ID or page number specified.")));
}
