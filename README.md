# restore_cloud_connection
A script to complete the "Restore Cloud Connection" steps

The customer can perform the following steps to run the script and complete cloud registration.
1. Download the restore_cloud_connection.sh script<br/>
`wget https://raw.githubusercontent.com/pgiattino-r7/restore_cloud_connection/main/restore_cloud_connection.sh`
2. Make the script executable<br/>
`chmod +x restore_cloud_connection.sh`
3. Run the script<br/>
`./restore_cloud_connection.sh`
4. Wait for your console service to restart after the script is run
5. Once console is rebooted, login to the console
6. In a new, Incognito window of Chrome, login to insight.rapid7.com
7. Retrieve your pairing key from this page
8. Copy the pairing key into the following menu of your Security Console:
Administration > Global and Console Settings > Console > Administer > Insight Platform
9. Registration should complete in about a minute
