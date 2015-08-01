<?php
include 'Repository/DatabaseConnector.php';
$databaseConnector = new DatabaseConnector();
$database = $databaseConnector->connectToDb();

$query = $database->query("SELECT id, device_name FROM device WHERE enabled = TRUE");

// Return the output as JSON
header('Content-type: application/json');
echo (json_encode($query->fetchAll(PDO::FETCH_ASSOC)));

// Disconnect from the database
$database = null;