# Description

Maintain the process to take care of the Webserver and make sure that the application will remain alive but using the loop to take reboot one by one

## Basic Process
1.	Servers will be tagged like - tag: node_1, tag: node_2
2.	If the first server is tagged then it will take reboot and will understand that it is the first in the queue
3.	Second webserver will continuously ping the first webserver until it is up and till the service is running good.
4.	Once the first webserver is up the owner of the application will get a confirmation mail that the server is up and the service is running (Service is running means the application is running), all the details will be provided in the email.
5.	After rebooting itself it will ping continuously to the second webserver.
6.	Second webserver will reboot itself once it got the confirmation from the first webserver that everything is good.
7.	Same nature has been given to the code for the second webserver, that after reboot it will send the mail confirmation to the application user also with the service is running or not.

## Attributes

* Server Name
* Tag Name
* Webservice Name

## Email Notifications
	
	#There will be 4 types of email notification during the execution of the cookbook - deployment_control_cookbook
1. If the webservers are not tagged it will notify by sending email to the application user stating that the servers are not tagged and the cookbook will stop from execution.
2. After reboot it will send emaail on the failure or success of the reboot of the servers
3. After starting the webservice it will again snd an emil to the users.