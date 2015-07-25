<?php
include "DatabaseConnector.php";
$databaseConnector = new databaseConnector();
$database = $databaseConnector->connectToDb();
// TODO add filtering with update method and device type
$device_list = $database->query("SELECT * FROM update_data_link");

// Return the output as JSON
header('Content-type: application/json');
echo (json_encode($device_list->fetchAll(PDO::FETCH_ASSOC)));

// Disconnect from the database
$database = null;