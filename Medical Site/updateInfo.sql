SET SERVEROUTPUT ON;
SET VERIFY OFF;


CREATE OR REPLACE PROCEDURE showVaccInfo(i IN NUMBER)
IS

s VARCHAR2(20);
stdIDException EXCEPTION;


BEGIN

	IF i<10000 OR i>99999 THEN
		RAISE stdIDException;
	END IF;
	
	SELECT status into s from vaccineStatus where sid = i;
	
	UPDATE vaccineStatus SET status = 'yes' WHERE sid = i;
	
			
	DBMS_OUTPUT.PUT_LINE('Vaccine Status Updated!');

	
	EXCEPTION
	WHEN stdIDException THEN
		DBMS_OUTPUT.PUT_LINE('Student ID must be 5 digit!');
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Student ID doesnt exist!');
	
		
END showVaccInfo;
/





CREATE OR REPLACE PROCEDURE credentialCheck(u IN VARCHAR2, p IN VARCHAR2, i IN NUMBER)
IS

name VARCHAR2(30);

BEGIN

	select ename INTO name from employee where username = u AND password = p;
	DBMS_OUTPUT.PUT_LINE('Welcome ' || name || '!');
	
	showVaccInfo(i);
	
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Invalid username/password!');
	

END credentialCheck;
/



DECLARE

username VARCHAR2(20) := '&username';
password VARCHAR2(20) := '&password';
id NUMBER := &Student_ID;


BEGIN
	credentialCheck(username, password, id);	
END;
/


commit;