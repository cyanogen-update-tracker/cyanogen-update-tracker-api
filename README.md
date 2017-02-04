# Cyanogen Update Tracker (API)
Cyanogen Update Tracker API for Web servers.

This is the back-end for the Cyanogen Update Tracker app. It is used for hosting:
- available devices
- available update methods
- update data
- device registrations for push notifications

##Contributing
If you'd like to contribute to this project, create a pull request with your changes. Once they're approved, they will be merged to the appropriate branch.

If you have a really great feature / improvement and like to have it in the live version of the API, which is used by the Google Play version, please [contact the main developer] (mailto:arjan.vlek.dev@gmail.com) to get it merged to the private play store repository.

There are a few rules / limitations for getting live version commits approved:
- The code must be tested in conjunction with the app on a real Cyanogen OS (or Lineage OS, if you add support for that) device, and on a computer / server which simulates the environment mentioned below
- Breaking changes must go into a new version folder (ex. `v3.2` or `v4`)
- Changes to the database structure should be pushed in a new SQL file. Database changes may never cause data to get lost. All data should always be migrated.
- These rules don't apply if you only want to contribute to your own fork or copy of the app

##How to develop?

###Prerequisites:
This API requires:
- Web server (VPS or Hosting)
- PHP 7.0 or later
- MySQL 5.5 or later

###Obtaining the code:
The code can be obtained by cloning the project:
```
git clone https://github.com/arjanvlek/cyanogen-update-tracker-api.git
```

###Setting up the database:
- Add your MySQL username and password in `Repository/DatabaseConnector.php` 
- Execute the MySQL database creation script from Git (`database.sql`):

####VPS:
- Log in using SSH and execute `mysql -u [user_name] -p[root_password] [database_name] < database.sql`

####Hosting:
- Use PHPMyAdmin and restore `database.sql`

###Database notes:
- By restoring the `database.sql` file, you'll get an empty database on your server.
- The update_data and update_data_link tables are for older versions of the app only. Use the update_data_new table for the latest version of the app
- The notifications_device and notifications_update_data columns are used to mark notifications for new devices / versions as sent. This is normally done by an admin tool, but I can't open source that tool due to security reasons.

###Deploying the API
- On your server, create a folder called `api` and place all the various folders (v2, v2.1, v3, v3.1) in there.
- Note: The v1 and the v1.1 folders are deprecated and no longer supported due to internal database changes and enforced HTTPS encryption.
- If you want a test version as well, do the same as above but this time make a folder `test` and place the `api` folder in there. You can create a separate test database.
- Your server will have the following lay-out:
    - /api/ -> API folder.
    - /test/api/ -> Test API folder, if you require it.

###Testing the API
- You should be able to navigate to `<your_domain_name>/api/v3.1/devices` and see a list of all the devices.
- If this does not work or if you are not using Apache, then navigate to `<your_domain_name>/api/v3.1/get_devices.php`.


###Version Data
- You can use the bundled version data or a version data API from Cyanogen if it exists.
- The app will automatically read the `update_data` that is specified in the database.

