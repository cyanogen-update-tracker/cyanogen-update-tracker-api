# Cyanogen Update Tracker (API)
Cyanogen Update Tracker API for Web servers.

This is the server-level API. It is used for hosting:
- available devices
- available update methods
- available update data links
- device registrations for notifications

##How to develop?

###Prerequisites:
This api requires:
- Web server (VPS or Hosting)
- PHP 5.4 or later
- MySQL 5.5 or later

###Obtaining the code:
The code can be obtained by cloning the project:
```
git clone https://github.com/arjanvlek/android-cyanogen-update-tracker-api.git
```

###Setting up the database:
- Add the MySQL username and password in `Repository/DatabaseConnector.php` 
- Execute the MySQL database creation script from Git (`database.sql`):

####VPS:
- Log in using SSH and execute `mysql -u [user_name] -p[root_password] [database_name] < import-mysql.sql`

####Hosting:
- Use PHPMyAdmin and restore `import-phpmyadmin.sql`


###Testing the API
- You should be able to navigate to `<your_domain_name>/devices` and see a list of all the devices.
- If this does not work or if you are not using Apache, then navigate to `<your_domain_name>/get_devices.php`.

###Version Data
- You can use the bundled version data or a version data API from Cyanogen if it exists.
- The app will automatically read the version data from the `update_data_link` specified in the database.
- Follow the einstructions of the [push sender project] (https://github.com/arjanvlek/android-cyanogen-update-tracker-push-sender) to update the version data in the database (for push notifications).

#Notes
- Using a Cyanogen API for version data is at your own risk. If Cyanogen sues you, I'm not responsible.

