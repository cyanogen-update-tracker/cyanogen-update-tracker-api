<?php
include 'Repository/DatabaseConnector.php';
$databaseConnector = new DatabaseConnector();
$database = $databaseConnector->connectToDb();

$query = $database->query("SELECT id, device_name, model FROM device WHERE enabled = TRUE OR enabled_no_data = TRUE");

// Return the output as JSON
header('Content-type: application/json');
echo (json_encode($query->fetchAll(PDO::FETCH_ASSOC)));

// Disconnect from the database
$database = null;