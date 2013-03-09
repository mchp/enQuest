For all the backend developers. If you run into any problem during set up, please PLEASE update this file.

Before attempting to run the code, 
- install MySQL from http://dev.mysql.com/downloads/installer/
	- if there is a problem, Google it.
- during MySQL setup, 
	- set your user name and password both to "root"
	- leave the host and port as default

Once MySQL is all set up, 
- start it using your system-specific method
	- in Ubuntu, this is "sudo service mysql start"
	- Windows and Mac, you can figure it out yourself
- create database enQuest;
	- in command prompt, type "mysql -u root -proot"
	- in mysql prompt, type "create database enQuest"
- in backend/main/, run "python manage.py syncdb" to make sure Django is talking to MySQL properly


