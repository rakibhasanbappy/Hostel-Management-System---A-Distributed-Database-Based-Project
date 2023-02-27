SET SERVEROUTPUT ON;
SET VERIFY OFF;


CREATE OR REPLACE PROCEDURE showHouse
IS

i NUMBER;
n VARCHAR2(30);
m VARCHAR2(30);
t VARCHAR2(30);
r NUMBER;
s NUMBER;
a_s NUMBER;
c VARCHAR2(30);
st VARCHAR2(30);
tb VARCHAR2(30);
wb VARCHAR2(30);

BEGIN

	DBMS_OUTPUT.PUT_LINE('Here are the detailed information of all houses: ');
	
	for x in (SELECT hid, hname, hmaster, htutor, total_room, total_seat, available_seat, cook, steward, table_boy, ward_boy into i, n, m, t, r, s, a_s, c, st, tb, wb from house)
		LOOP
			i:=x.hid;
			n:=x.hname;
			m:=x.hmaster;
			t:=x.htutor;
			r:=x.total_room;
			s:=x.total_seat;
			a_s:=x.available_seat;
			c:=x.cook;
			st:=x.steward;
			tb:=x.table_boy;
			wb:=x.ward_boy;
			
			DBMS_OUTPUT.PUT_LINE('House ID: ' || i || '; House Name: ' || n || '; House Master: ' || m || '; House Tutor: ' || t || '; Total Room: ' || r || '; Total Seat: ' || s || '; Available Seat: ' || a_s || '; Cook: ' || c || '; Steward: ' || st || '; Table Boy: ' || tb || '; Ward Boy: ' || wb);		
		
		END LOOP;
		
END showHouse;
/



DECLARE

BEGIN
	showHouse;
END;
/


COMMIT;