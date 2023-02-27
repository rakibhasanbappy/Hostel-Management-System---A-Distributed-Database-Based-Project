SET SERVEROUTPUT ON;
SET VERIFY OFF;


CREATE OR REPLACE TRIGGER insertStudent
AFTER INSERT 
ON student
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('1 ROW INSERTED IN STUDENT TABLE');
END;
/


CREATE OR REPLACE PROCEDURE addStudent(i IN NUMBER, n IN VARCHAR2, c IN NUMBER, s IN VARCHAR2, h IN VARCHAR2, fn IN VARCHAR2)
IS

y NUMBER;
A NUMBER;
cnt NUMBER:=0;
stdIDException EXCEPTION;
stdIDExistException EXCEPTION;

BEGIN
	
	
	IF i<10000 OR i>99999 THEN
		RAISE stdIDException;
	END IF;

		
	
	FOR x in (select sid into y from student where sid = i)
		LOOP
			cnt:=1;
		END LOOP;



	IF cnt>0 THEN
		RAISE stdIDExistException;
	END IF;
	
	
	SELECT available_seat INTO A FROM house WHERE hname = h;
		
	IF A>0 THEN
		INSERT INTO student values(i,n,c,s,h,fn);
		INSERT INTO vaccineStatus@medical values(i,'no');
		UPDATE house SET available_seat = A-1 WHERE hname=h;
	ELSE
		INSERT INTO request values(i,n,c,s,h,fn);
		DBMS_OUTPUT.PUT_LINE('There is no empty seat at this moment! This student is in the waitlist.');
	END IF;
	

	EXCEPTION
	WHEN stdIDException THEN
		DBMS_OUTPUT.PUT_LINE('Student ID must be 5 digit!');
	WHEN stdIDExistException THEN
		DBMS_OUTPUT.PUT_LINE('Student ID already exist!');

	
END addStudent;
/



CREATE OR REPLACE PROCEDURE credentialCheck(u IN VARCHAR2, p IN VARCHAR2, i IN NUMBER, n IN VARCHAR2, c IN NUMBER, s IN VARCHAR2, h IN VARCHAR2, fn IN VARCHAR2)
IS

name VARCHAR2(30);


BEGIN

	select ename INTO name from employee where username = u AND password = p;
	DBMS_OUTPUT.PUT_LINE('Welcome ' || name || '!');
	
	
	addStudent(i, n, c, s, h, fn);

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Invalid username/password!');

END credentialCheck;
/



DECLARE

username VARCHAR2(20) := '&username';
password VARCHAR2(20) := '&password';
i NUMBER := &Student_ID;
n VARCHAR2(30) := '&Name';
c NUMBER := &Class;
s VARCHAR2(10) := '&Section';
h VARCHAR2(30) := '&House_Name';
fn VARCHAR2(30) := '&Fathers_Name';


BEGIN
	credentialCheck(username, password, i, n, c, s, h, fn);
	
END;
/

COMMIT;