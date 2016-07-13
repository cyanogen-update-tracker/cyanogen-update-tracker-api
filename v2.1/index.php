<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
<?php
    include 'Repository/DatabaseConnector.php';
    $databaseConnector = new DatabaseConnector();
    $database = $databaseConnector->connectToDb();
    $query = $database->query("SELECT status, latest_app_version FROM server_status");
    $result = $query->fetchAll(PDO::FETCH_ASSOC);
    echo "API Status: ".$result[0]["status"]." <br/>";
    echo "Latest app version: ".$result[0]["latest_app_version"]." <br/>";

?>

</body>
</html>