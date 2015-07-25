<?php

class databaseConnector {
    public function connectToDb() {
        $username = "** Add your database username here **";
        $password = "Stoomtrein1";
        $server_address = "localhost";
        $database_name = "cyanogen_update_tracker";
        $database = new PDO('mysql:host='.$server_address.';dbname='.$database_name.'',$username, $password);
        return $database;
    }


}