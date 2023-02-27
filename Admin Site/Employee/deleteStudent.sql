SET SERVEROUTPUT ON;
SET VERIFY OFF;


CREATE OR REPLACE TRIGGER deleteStdnt
AFTER DELETE 
ON student
DECLARE
	i NUMBER;
	n VARCHAR2(30);
	c NUMBER;
	s VARCHAR2(10);
	h VARCHAR2(30);
	fn VARCHAR2(30);
	cnt NUMBER:=0;
	A NUMBER;
BEGIN

	for x in (select sid, sname, class, section, house, fatherName into i, n, c, s, h, fn from request)
		LOOP
			cnt:=cnt+1;
			i:=x.sid;
			n:=x.sname;
			c:=x.class;
			s:=x.section;
			h:=x.house;
			fn:=x.fatherName;
		
		END LOOP;
		
	IF cnt>0 THEN
		SELECT house,sid INTO h,i FROM request WHERE ROWNUM = 1;
		--DBMS_OUTPUT.PUT_LINE(h);
		--DBMS_OUTPUT.PUT_LINE(i);
		SELECT available_seat INTO A FROM house WHERE hname = h;
		--DBMS_OUTPUT.PUT_LINE(A);
		
		IF A>0 THEN
			select sid, sname, class, section, house, fatherName into i, n, c, s, h, fn from request where sid = i;
			INSERT INTO student VALUES(i,n,c,s,h,fn);
			INSERT INTO vaccineStatus@medical values(i,'no');
			UPDATE house SET available_seat = A-1 WHERE hname=h;
			DELETE from request WHERE sid = i;
		END IF;
		
	END IF;
	
	
	
	DBMS_OUTPUT.PUT_LINE('1 ROW DELETED FROM STUDENT TABLE');
	
END;
/


CREATE OR REPLACE PROCEDURE deleteStudent(i IN NUMBER)
IS

h VARCHAR2(30);
A NUMBER;
stdIDException EXCEPTION;

BEGIN
	
	
	IF i<10000 OR i>99999 THEN
		RAISE stdIDException;
	END IF;
	
	
	SELECT house INTO h from student WHERE sid = i;
	
	SELECT available_seat INTO A FROM house WHERE hname = h;
	
	UPDATE house SET available_seat = A +1 WHERE hname=h;
	
	DELETE FROM student WHERE sid = i;
	
	DELETE FROM vaccineStatus@medical WHERE sid = i;
	
	

	EXCEPTION
	WHEN stdIDException THEN
		DBMS_OUTPUT.PUT_LINE('Student ID must be 5 digit!');
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Student ID doesnt exist!');

	
END deleteStudent;
/



CREATE OR REPLACE PROCEDURE credentialCheck(u IN VARCHAR2, p IN VARCHAR2, i IN NUMBER)
IS

name VARCHAR2(30);


BEGIN

	select ename INTO name from employee where username = u AND password = p;
	DBMS_OUTPUT.PUT_LINE('Welcome ' || name || '!');
	
	deleteStudent(i);
	

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Invalid username/password!');

END credentialCheck;
/



DECLARE

username VARCHAR2(20) := '&username';
password VARCHAR2(20) := '&password';
i NUMBER := &Student_ID;



BEGIN
	credentialCheck(username, password, i);
	
END;
/


COMMIT;

