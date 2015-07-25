<?php
include 'Repository/DatabaseConnector.php';
$databaseConnector = new databaseConnector();
$database = $databaseConnector->connectToDb();

$device_list = $database->query("SELECT id, device_name FROM device_type WHERE enabled = TRUE");

// Return the output as JSON
header('Content-type: application/json');
echo (json_encode($device_list->fetchAll(PDO::FETCH_ASSOC)));

// Disconnect from the database
$database = null;