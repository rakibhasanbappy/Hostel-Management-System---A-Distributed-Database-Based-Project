SET SERVEROUTPUT ON;
SET VERIFY OFF;


CREATE OR REPLACE PROCEDURE showVaccInfo
IS

i NUMBER;
n VARCHAR2(30);
c NUMBER;
s VARCHAR2(10);
h VARCHAR2(30);
fn VARCHAR2(30);
sts VARCHAR2(20);

BEGIN

	DBMS_OUTPUT.PUT_LINE('Here are the vaccine information of all students: ');
	

	
	for x in (SELECT sid, sname, class, section, house, fatherName, status into i, n, c, s, h, fn, sts from student NATURAL JOIN vaccineStatus@medical)
		LOOP
			i:=x.sid;
			n:=x.sname;
			c:=x.class;
			s:=x.section;
			h:=x.house;
			fn:=x.fatherName;
			sts:=x.status;
			
			DBMS_OUTPUT.PUT_LINE('Student ID: ' || i || '; Name: ' || n || '; Class: ' || c || '; Section: ' || s || '; House: ' || h || '; Fathers Name: ' || fn || ';Status: ' || sts);		
		
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