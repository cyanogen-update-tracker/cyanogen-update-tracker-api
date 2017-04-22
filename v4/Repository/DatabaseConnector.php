<?php

class DatabaseConnector {
    public function connectToDb() {
        $username = "root";
        $password = "Anja=Rob6250";
        $server_address = "localhost";
        $database_name = "cyanogen_update_tracker_test";
        $database = new PDO('mysql:host='.$server_address.';dbname='.$database_name.'',$username, $password);
 	$database->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $database;
    }
}
