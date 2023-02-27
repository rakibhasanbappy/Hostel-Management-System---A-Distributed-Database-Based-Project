DROP TABLE vaccineStatus CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;



CREATE TABLE vaccineStatus(sid NUMBER, status VARCHAR2(20));
CREATE TABLE employee(eid NUMBER, ename VARCHAR2(30), designation VARCHAR2(20), username VARCHAR2(20), password VARCHAR2(20));



INSERT INTO vaccineStatus VALUES (10001, 'yes');
INSERT INTO vaccineStatus VALUES (10002, 'yes');
INSERT INTO vaccineStatus VALUES (10003, 'no');
INSERT INTO vaccineStatus VALUES (10004, 'no');
INSERT INTO vaccineStatus VALUES (10005, 'no');
INSERT INTO vaccineStatus VALUES (10006, 'yes');



INSERT INTO employee VALUES (3005, 'Dr. Bacchu', 'Doctor', 'c', '3');


commit;