SET SERVEROUTPUT ON;

DROP TABLE student CASCADE CONSTRAINTS;
DROP TABLE house CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE request CASCADE CONSTRAINTS;


CREATE TABLE student(sid NUMBER, sname VARCHAR2(30), class NUMBER, section VARCHAR2(10), house VARCHAR2(30), fatherName VARCHAR2(30));


CREATE TABLE house(hid NUMBER, hname VARCHAR2(30), hmaster VARCHAR2(30), htutor VARCHAR2(30), total_room NUMBER,
total_seat NUMBER, available_seat NUMBER, cook VARCHAR2(30), steward VARCHAR2(30), table_boy VARCHAR2(30), ward_boy VARCHAR2(30));


CREATE TABLE employee(eid NUMBER, ename VARCHAR2(30), designation VARCHAR2(20), username VARCHAR2(20), password VARCHAR2(20));


CREATE TABLE request(sid NUMBER, sname VARCHAR2(30), class NUMBER, section VARCHAR2(10), house VARCHAR2(30), fatherName VARCHAR2(30));




INSERT into student VALUES(10001, 'MD. Nafiur Rahman', 11, 'C', 'Nazrul Islam House', 'MD. Rahim Mia');
INSERT into student VALUES(10002, 'Arifur Rahman', 10, 'C', 'Lalol Shah House', 'MD. Khairul Bashar');
INSERT into student VALUES(10003, 'Taohid Hossain', 11, 'E', 'Lalon Shah House', 'Akber Hossain');
INSERT into student VALUES(10004, 'Farhan Tanvir', 10, 'C', 'Nazrul Islam House', 'Nazrul Islam');
INSERT into student VALUES(10005, 'Dawood Ibrahim', 11, 'D', 'Nazrul Islam House', 'Imdadul Hoque');
INSERT into student VALUES(10006, 'Tahmid Alam', 05, 'F', 'Fazlul Hoque House', 'Moin Ahmed');






INSERT INTO house VALUES(2001, 'Fazlul Hoque House', 'Md. Omar Faruk', 'Monir Hossain Gazi', 30, 100, 10, 'Asad', 'Rahim', 'Selim', 'Selim');
INSERT INTO house VALUES(2002, 'Nazrul Islam House', 'Anowar Hossain', 'Azimul Hoque', 32, 110, 20, 'Nazrul', 'Shahid', 'Aslam', 'Karim');
INSERT INTO house VALUES(2003, 'Lalon Shah House', 'Prashanta Chakrobarty', 'Sultan Uddin', 25, 80, 01, 'Mia', 'Khairul', 'Akber', 'Kollol');




INSERT INTO employee VALUES(3001, 'Monir Hossain Gazi', 'House Tutor', 'a', '1');
INSERT INTO employee VALUES(3002, 'Md. Omar Faruk', 'House Master', 'b', '2');




DECLARE


BEGIN
	DBMS_OUTPUT.PUT_LINE('Tables Created Successfully!');
	
END;
/

commit;


