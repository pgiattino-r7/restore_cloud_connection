# restore_cloud_connection
A script to complete the "Restore Cloud Connection" steps

The customer may perform the following steps to run the script and complete cloud registration.
1. Download the restore_cloud_connection.sh script
wget https://raw.githubusercontent.com/pgiattino-r7/restore_cloud_connection/main/restore_cloud_connection.sh
2. Make the script executable
chmod +x restore_cloud_connection.sh
3. Run the script
./restore_cloud_connection.sh
4. Wait for your console service to restart after the script is run
5. Once console is rebooted, login to the console
6. In a new, Incognito window of Chrome, login to insight.rapid7.com
7. Paste in the following Pairing Key URL: <ENTER URL HERE>
8. Copy the pairing key that is generated to the following menu of your Security Console:
Administration > Global and Console Settings > Console > Administer > Insight Platform
9. Registration should complete in about a minute
