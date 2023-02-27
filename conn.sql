drop database link medical;

create database link medical --[[site_friend = just a name. you can give it whatever you want]]
connect to system identified by "1234" --[[password = sqlplus password]]
using '(DESCRIPTION =
       (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP) (HOST = 0.tcp.ap.ngrok.io) (PORT = 12976)))
       (CONNECT_DATA = (SID = XE))
	   )'; 
