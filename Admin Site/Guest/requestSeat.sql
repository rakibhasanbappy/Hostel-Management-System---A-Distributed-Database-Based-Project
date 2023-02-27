SET SERVEROUTPUT ON;
SET VERIFY OFF;



CREATE OR REPLACE PACKAGE requestPackage AS
	
	
	FUNCTION checkStatus(i IN NUMBER)
	RETURN NUMBER;
	
	FUNCTION availablity(h IN VARCHAR2)
	RETURN NUMBER;
	
END requestPackage;
/


CREATE OR REPLACE PACKAGE BODY requestPackage AS	
	
	FUNCTION checkStatus(i IN NUMBER)
	RETURN NUMBER
	IS
	
	y NUMBER;
	cnt NUMBER:=0;
	stdIDException EXCEPTION;
	stdIDExistException EXCEPTION;
	
	BEGIN
	
	IF i<10000 OR i>99999 THEN
		cnt:=1;
		RAISE stdIDException;
	END IF;

		
	
	FOR x in (select sid into y from student where sid = i)
		LOOP
			cnt:=1;
		END LOOP;



	IF cnt>0 THEN
		RAISE stdIDExistException;
	END IF;

	
	RETURN cnt;


	EXCEPTION
	WHEN stdIDException THEN
		DBMS_OUTPUT.PUT_LINE('Student ID must be 5 digit!');
		RETURN cnt;
	WHEN stdIDExistException THEN
		DBMS_OUTPUT.PUT_LINE('You have already enrolled in a house!');
		RETURN cnt;
		
	
	
	END checkStatus;
	
	
	
	
	FUNCTION availablity(h IN VARCHAR2)
	RETURN NUMBER
	IS 
	
	A NUMBER;
	
	
	BEGIN
		SELECT available_seat INTO A FROM house WHERE hname = h;
	
		RETURN A;
		
	END availablity;
	
	
END requestPackage;
/





DECLARE

i NUMBER:= &Student_ID;
n VARCHAR2(30):= '&Name';
c NUMBER:=&Class;
s VARCHAR2(30):='&Section';
h VARCHAR2(30):='&House_Name';
fn VARCHAR2(30):='&Father_Name';
a_s NUMBER;
chck NUMBER;

BEGIN

	chck := requestPackage.checkStatus(i);
	--DBMS_OUTPUT.PUT_LINE(chck);
	
	IF chck=0 THEN
		a_s := requestPackage.availablity(h);
		--DBMS_OUTPUT.PUT_LINE(a_s);
		
		IF a_s>0 THEN
			INSERT INTO student values(i,n,c,s,h,fn);
			INSERT INTO vaccineStatus@medical values(i,'no');
			DBMS_OUTPUT.PUT_LINE('Successfully Enrolled in '||h);
			UPDATE house SET available_seat = a_s -1 WHERE hname=h;
		ELSE
			INSERT INTO request values(i,n,c,s,h,fn);
			DBMS_OUTPUT.PUT_LINE('There is no empty seat at this moment! You are in the waitlist.');
		END IF;
		
	END IF;
	
	
	
	

		
	
END;
/

commit;