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
    $result = $query->fetch(PDO::FETCH_ASSOC);

    echo "API Status: ".$result["status"]." <br/>";
    echo "Latest app version: ".$result["latest_app_version"]." <br/>";
?>

</body>
</html>