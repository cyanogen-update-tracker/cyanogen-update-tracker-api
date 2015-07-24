<?php
$device_id = $_GET["device_id"];
$username = "** Add your database username here **";
$password = "Stoomtrein1";
$server_address = "localhost";
$database_name = "Cyanogen_Update_Tracker";
$database = new PDO('mysql:host='.$server_address.';dbname='.$database_name.'',$username, $password);
$query_all = "SELECT * FROM Tracking_update_type";
$query_limited = "SELECT * FROM Tracking_update_type WHERE id IN (SELECT tracking_update_type_id FROM Update_Information_Link WHERE tracking_device_type_id = $device_id)";
if($device_id != null && $device_id != "") {
    $update_list = $database->query($query_limited);
}
else {
    $update_list = $database->query($query_all);
}

header('Content-type: application/json');
echo (json_encode($update_list->fetchAll(PDO::FETCH_ASSOC)));
$database = null;