SET SERVEROUTPUT ON;
SET VERIFY OFF;


CREATE OR REPLACE PROCEDURE showAllRequest
IS

i NUMBER;
n VARCHAR2(30);
c NUMBER;
s VARCHAR2(10);
h VARCHAR2(30);
fn VARCHAR2(30);

BEGIN

	DBMS_OUTPUT.PUT_LINE('Here are the detailed information of all request: ');
	
	for x in (select sid, sname, class, section, house, fatherName into i, n, c, s,  h, fn from request)
		LOOP
			i:=x.sid;
			n:=x.sname;
			c:=x.class;
			s:=x.section;
			h:=x.house;
			fn:=x.fatherName;
			
			DBMS_OUTPUT.PUT_LINE('Student ID: ' || i || '; Name: ' || n || '; Class: ' || c || '; Section: ' || s || '; House: ' || h || '; Fathers Name: ' || fn);		
		
		END LOOP;
		
END showAllRequest;
/





CREATE OR REPLACE PROCEDURE credentialCheck(u IN VARCHAR2, p IN VARCHAR2)
IS

name VARCHAR2(30);

BEGIN

	select ename INTO name from employee where username = u AND password = p;
	DBMS_OUTPUT.PUT_LINE('Welcome ' || name || '!');
	
	showAllRequest;
	
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