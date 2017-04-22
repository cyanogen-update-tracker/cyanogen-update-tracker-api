<?php
include 'Repository/DatabaseConnector.php';

// Connect to the database
$databaseConnector = new DatabaseConnector();
$database = $databaseConnector->connectToDb();

// Execute the query
$query = $database->query("SELECT id, device_name, model_number FROM device WHERE enabled = TRUE OR enabled_no_data = TRUE order by device_name");

// Return the output as JSON
header('Content-type: application/json');
echo (json_encode($query->fetchAll(PDO::FETCH_ASSOC)));

// Disconnect from the database
$database = null;
