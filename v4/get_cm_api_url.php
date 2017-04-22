<?php
include 'Repository/DatabaseConnector.php';

// Connect to the database
$databaseConnector = new DatabaseConnector();
$database = $databaseConnector->connectToDb();

// Execute the query
$query = $database->query("SELECT cm_api_url FROM server_status");

// Return the output as JSON
header('Content-type: application/json');
echo ($query->fetch(PDO::FETCH_ASSOC)['cm_api_url']);

// Disconnect from the database
$database = null;
