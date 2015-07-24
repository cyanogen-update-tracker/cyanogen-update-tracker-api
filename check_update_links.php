<?php
$username = "** Add your database username here **";
$password = "Stoomtrein1";
$server_address = "localhost";
$database_name = "Cyanogen_Update_Tracker";
$database = new PDO('mysql:host='.$server_address.';dbname='.$database_name.'',$username, $password);
$device_list = $database->query("SELECT * FROM Update_Information_Link");

header('Content-type: application/json');
echo (json_encode($device_list->fetchAll(PDO::FETCH_ASSOC)));
$database = null;