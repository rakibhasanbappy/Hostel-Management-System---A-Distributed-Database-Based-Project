SET SERVEROUTPUT ON;
SET VERIFY OFF;


CREATE OR REPLACE PROCEDURE showVaccInfo
IS

i NUMBER;
s VARCHAR2(20);

BEGIN

	DBMS_OUTPUT.PUT_LINE('Here are the vaccine information of all students: ');
	
	for x in (select sid, status into i, s from vaccineStatus)
		LOOP
			i:=x.sid;
			s:=x.status;
			
			DBMS_OUTPUT.PUT_LINE('Student ID: ' || i || '; Status: ' || s);		
		
		END LOOP;
		
END showVaccInfo;
/





CREATE OR REPLACE PROCEDURE credentialCheck(u IN VARCHAR2, p IN VARCHAR2)
IS

name VARCHAR2(30);

BEGIN

	select ename INTO name from employee where username = u AND password = p;
	DBMS_OUTPUT.PUT_LINE('Welcome ' || name || '!');
	
	showVaccInfo;
	
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Invalid username/password!');
	

END credentialCheck;
/



DECLARE

username VARCHAR2(20) := '&username';
password VARCHAR2(20) := '&password';


BEGIN
	credentialCheck(username, password);	
END;
/


commit;