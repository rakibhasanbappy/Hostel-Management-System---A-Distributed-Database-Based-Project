SET SERVEROUTPUT ON;
SET VERIFY OFF;


CREATE OR REPLACE PROCEDURE showSeats
IS

i NUMBER;
n VARCHAR2(30);
s NUMBER;
a_s NUMBER;


BEGIN

	DBMS_OUTPUT.PUT_LINE('Here are the information of empty seats of all houses: ');
	
	for x in (SELECT hid, hname, total_seat, available_seat into i, n, s, a_s from house)
		LOOP
			i:=x.hid;
			n:=x.hname;
			s:=x.total_seat;
			a_s:=x.available_seat;
			
			DBMS_OUTPUT.PUT_LINE('House ID: ' || i || '; House Name: ' || n || '; Total Seat: ' || s || '; Available Seat: ' || a_s);		
		
		END LOOP;
		
END showSeats;
/



DECLARE

BEGIN
	showSeats;	
END;
/


COMMIT;