
---------------------------------------------------
-- 1. Customer Table
DROP TABLE testcustomer_157 CASCADE CONSTRAINTS;

CREATE TABLE testcustomer_157 (
    aadharno NUMBER(12) CONSTRAINT pk_testcustomer_157 PRIMARY KEY,
    mobileno NUMBER(10),
    cname VARCHAR2(50),
    email VARCHAR2(100) CONSTRAINT uq_testcustomer_157_email UNIQUE,
    dob DATE NOT NULL
);

-- Sample Customers
INSERT INTO testcustomer_157 (aadharno, mobileno, cname, email, dob)
VALUES (241074009706, 7488845731, 'Aditya Kumar', 'aditya1959@gmail.com', TO_DATE('24-JUL-1996','DD-MON-YYYY'));

INSERT INTO testcustomer_157 (aadharno, mobileno, cname, email, dob)
VALUES (241074009707, 9876543210, 'Riya Sen', 'riya.sen@gmail.com', TO_DATE('10-MAY-1998','DD-MON-YYYY'));

INSERT INTO testcustomer_157 (aadharno, mobileno, cname, email, dob)
VALUES (241074009708, 9123456789, 'Arjun Das', 'arjun.das@gmail.com', TO_DATE('05-DEC-1995','DD-MON-YYYY'));

---------------------------------------------------
-- 2. Bus Table
DROP TABLE bus CASCADE CONSTRAINTS;

CREATE TABLE bus (
    veh_reg_no NUMBER(10) CONSTRAINT pk_bus PRIMARY KEY,
    bus_name VARCHAR2(50),
    capacity NUMBER(3)
);

-- Sample Buses
INSERT INTO bus (veh_reg_no, bus_name, capacity) VALUES (1001, 'Volvo AC', 45);
INSERT INTO bus (veh_reg_no, bus_name, capacity) VALUES (1002, 'Sleeper Non-AC', 50);

---------------------------------------------------
-- 3. Reservation Table
DROP TABLE reservation157 CASCADE CONSTRAINTS;

CREATE TABLE reservation157 (
    pnr_no NUMBER(10) CONSTRAINT pk_reservation PRIMARY KEY,
    booked_date DATE NOT NULL,
    fare NUMBER(10,2),
    booked_by_aadhar NUMBER(12) CONSTRAINT fk_reservation_customer
        REFERENCES testcustomer_157(aadharno)
);

-- Sample Reservations
INSERT INTO reservation157 (pnr_no, booked_date, fare, booked_by_aadhar)
VALUES (5050505050, TO_DATE('31-JUL-2026','DD-MON-YYYY'), 7060.20, 241074009706);

INSERT INTO reservation157 (pnr_no, booked_date, fare, booked_by_aadhar)
VALUES (5050505051, TO_DATE('01-AUG-2026','DD-MON-YYYY'), 2500.00, 241074009707);

---------------------------------------------------
-- 4. Trip Table
DROP TABLE trip157 CASCADE CONSTRAINTS;

CREATE TABLE trip157 (
    trip_id VARCHAR2(10) CONSTRAINT pk_trip PRIMARY KEY,
    date_of_trip DATE NOT NULL,
    source VARCHAR2(50) NOT NULL,
    destination VARCHAR2(50) NOT NULL,
    conductedby_veh_no NUMBER(10) CONSTRAINT fk_trip_bus
        REFERENCES bus(veh_reg_no)
);

-- Sample Trips
INSERT INTO trip157 (trip_id, date_of_trip, source, destination, conductedby_veh_no)
VALUES ('T100', TO_DATE('15-AUG-2026','DD-MON-YYYY'), 'Kolkata', 'Delhi', 1001);

INSERT INTO trip157 (trip_id, date_of_trip, source, destination, conductedby_veh_no)
VALUES ('T101', TO_DATE('16-AUG-2026','DD-MON-YYYY'), 'Delhi', 'Mumbai', 1002);

---------------------------------------------------
-- 5. Seats Table
DROP TABLE seats157 CASCADE CONSTRAINTS;

CREATE TABLE seats157 (
    seat_no NUMBER(2),
    seat_price NUMBER(10,2),
    offered_by_trip_id VARCHAR2(10),
    booked_under_pnr NUMBER(10),
    CONSTRAINT fk_seat_trip FOREIGN KEY (offered_by_trip_id) REFERENCES trip157(trip_id),
    CONSTRAINT fk_seat_reservation FOREIGN KEY (booked_under_pnr) REFERENCES reservation157(pnr_no),
    CONSTRAINT pk_seat PRIMARY KEY (seat_no, offered_by_trip_id)
);

-- Sample Seat Bookings
INSERT INTO seats157 (seat_no, seat_price, offered_by_trip_id, booked_under_pnr)
VALUES (12, 1500.00, 'T100', 5050505050);

INSERT INTO seats157 (seat_no, seat_price, offered_by_trip_id, booked_under_pnr)
VALUES (15, 2000.00, 'T101', 5050505051);

---------------------------------------------------
COMMIT;

select *
from testcustomer_157 full outer join reservation157
on aadharno=booked_by_aadhar;

select *
from testcustomer_157 right outer join reservation157
on aadharno=booked_by_aadhar;

select *
from testcustomer_157 left outer join reservation157
on aadharno=booked_by_aadhar;

select aadharno,cname,pnr_no,0.9*fare "discountedprice"
from testcustomer_157 join reservation157
on booked_by_aadhar=aadharno
order by fare desc;

select table_name,constraint_name,column_name,constraint_type,search_condition
from user_constraints natural join user_cons_columns;

select aadharno,cname,pnr_no,0.9*fare "discountedprice"
from testcustomer_157 join reservation157
on booked_by_aadhar=aadharno
where upper(cname) like 'AB%'
order by fare desc;

update testcustomer_157
set cname='new_name'
where cname='old_name';

select aadharno,cname,pnr_no,to_char(dob,'month,DD,YYYY') "dateofbirth"
from testcustomer_157 join reservation157
on booked_by_aadhar=aadharno
where to_char(dob,'MM,DD,YYYY')
like '07%';

alter table reservation157
add cashback number(10,2);
update reservation157
set cashback=fare*0.5
where pnr_no=5050505050;

select aadharno,cname,pnr_no,nul(fare-cashback,fare) "effective-price"
from testcustomer_157 join reservation157
on booked_by_aadhar=aadharno;

Convert into 156 

// NOW IN 156



---------------------------------------------------
-- 1. Customer Table
DROP TABLE testcustomer_156 CASCADE CONSTRAINTS;

CREATE TABLE testcustomer_156 (
    aadharno NUMBER(12) CONSTRAINT pk_testcustomer_156 PRIMARY KEY,
    mobileno NUMBER(10),
    cname VARCHAR2(50),
    email VARCHAR2(100) CONSTRAINT uq_testcustomer_156_email UNIQUE,
    dob DATE NOT NULL
);

-- Sample Customers
INSERT INTO testcustomer_156 (aadharno, mobileno, cname, email, dob)
VALUES (241074009706, 7488845731, 'MD FIRDAUS ALAM', 'firdausa054@gmail.com',
        TO_DATE('08-DEC-1996','DD-MON-YYYY'));

INSERT INTO testcustomer_156 (aadharno, mobileno, cname, email, dob)
VALUES (241074009707, 9876543210, 'Riya Sen', 'riya.sen@gmail.com',
        TO_DATE('10-MAY-1998','DD-MON-YYYY'));

INSERT INTO testcustomer_156 (aadharno, mobileno, cname, email, dob)
VALUES (241074009708, 9123456789, 'Arjun Das', 'arjun.das@gmail.com',
        TO_DATE('05-DEC-1995','DD-MON-YYYY'));


---------------------------------------------------
-- 2. Bus Table
DROP TABLE bus CASCADE CONSTRAINTS;

CREATE TABLE bus (
    veh_reg_no NUMBER(10) CONSTRAINT pk_bus PRIMARY KEY,
    bus_name VARCHAR2(50),
    capacity NUMBER(3)
);

-- Sample Buses
INSERT INTO bus (veh_reg_no, bus_name, capacity)
VALUES (1001, 'Volvo AC', 45);

INSERT INTO bus (veh_reg_no, bus_name, capacity)
VALUES (1002, 'Sleeper Non-AC', 50);


---------------------------------------------------
-- 3. Reservation Table
DROP TABLE reservation156 CASCADE CONSTRAINTS;

CREATE TABLE reservation156 (
    pnr_no NUMBER(10) CONSTRAINT pk_reservation PRIMARY KEY,
    booked_date DATE NOT NULL,
    fare NUMBER(10,2),
    booked_by_aadhar NUMBER(12)
        CONSTRAINT fk_reservation_customer
        REFERENCES testcustomer_156(aadharno)
);

-- Sample Reservations
INSERT INTO reservation156
(pnr_no, booked_date, fare, booked_by_aadhar)
VALUES
(5050505050, TO_DATE('31-JUL-2026','DD-MON-YYYY'),
 7060.20, 241074009706);

INSERT INTO reservation156
(pnr_no, booked_date, fare, booked_by_aadhar)
VALUES
(5050505051, TO_DATE('01-AUG-2026','DD-MON-YYYY'),
 2500.00, 241074009707);


---------------------------------------------------
-- 4. Trip Table
DROP TABLE trip156 CASCADE CONSTRAINTS;

CREATE TABLE trip156 (
    trip_id VARCHAR2(10) CONSTRAINT pk_trip PRIMARY KEY,
    date_of_trip DATE NOT NULL,
    source VARCHAR2(50) NOT NULL,
    destination VARCHAR2(50) NOT NULL,
    conductedby_veh_no NUMBER(10)
        CONSTRAINT fk_trip_bus
        REFERENCES bus(veh_reg_no)
);

-- Sample Trips
INSERT INTO trip156
(trip_id, date_of_trip, source, destination, conductedby_veh_no)
VALUES
('T100', TO_DATE('15-AUG-2026','DD-MON-YYYY'),
 'Kolkata', 'Delhi', 1001);

INSERT INTO trip156
(trip_id, date_of_trip, source, destination, conductedby_veh_no)
VALUES
('T101', TO_DATE('16-AUG-2026','DD-MON-YYYY'),
 'Delhi', 'Mumbai', 1002);


---------------------------------------------------
-- 5. Seats Table
DROP TABLE seats156 CASCADE CONSTRAINTS;

CREATE TABLE seats156 (
    seat_no NUMBER(2),
    seat_price NUMBER(10,2),
    offered_by_trip_id VARCHAR2(10),
    booked_under_pnr NUMBER(10),

    CONSTRAINT fk_seat_trip
        FOREIGN KEY (offered_by_trip_id)
        REFERENCES trip156(trip_id),

    CONSTRAINT fk_seat_reservation
        FOREIGN KEY (booked_under_pnr)
        REFERENCES reservation156(pnr_no),

    CONSTRAINT pk_seat
        PRIMARY KEY (seat_no, offered_by_trip_id)
);

-- Sample Seat Bookings
INSERT INTO seats156
(seat_no, seat_price, offered_by_trip_id, booked_under_pnr)
VALUES
(12, 1500.00, 'T100', 5050505050);

INSERT INTO seats156
(seat_no, seat_price, offered_by_trip_id, booked_under_pnr)
VALUES
(15, 2000.00, 'T101', 5050505051);


---------------------------------------------------
COMMIT;


-- FULL OUTER JOIN
SELECT *
FROM testcustomer_156
FULL OUTER JOIN reservation156
ON aadharno = booked_by_aadhar;


-- RIGHT OUTER JOIN
SELECT *
FROM testcustomer_156
RIGHT OUTER JOIN reservation156
ON aadharno = booked_by_aadhar;


-- LEFT OUTER JOIN
SELECT *
FROM testcustomer_156
LEFT OUTER JOIN reservation156
ON aadharno = booked_by_aadhar;


-- DISCOUNTED PRICE
SELECT aadharno, cname, pnr_no,
       0.9 * fare AS "discountedprice"
FROM testcustomer_156
JOIN reservation156
ON booked_by_aadhar = aadharno
ORDER BY fare DESC;


-- DISPLAY CONSTRAINTS
SELECT table_name, constraint_name, column_name,
       constraint_type, search_condition
FROM user_constraints
NATURAL JOIN user_cons_columns;


-- CUSTOMER NAME STARTING WITH AB
SELECT aadharno, cname, pnr_no,
       0.9 * fare AS "discountedprice"
FROM testcustomer_156
JOIN reservation156
ON booked_by_aadhar = aadharno
WHERE UPPER(cname) LIKE 'AB%'
ORDER BY fare DESC;


-- UPDATE CUSTOMER NAME
UPDATE testcustomer_156
SET cname = 'new_name'
WHERE cname = 'old_name';


-- DISPLAY DOB
SELECT aadharno, cname, pnr_no,
       TO_CHAR(dob,'MONTH,DD,YYYY') AS "dateofbirth"
FROM testcustomer_156
JOIN reservation156
ON booked_by_aadhar = aadharno
WHERE TO_CHAR(dob,'MM,DD,YYYY') LIKE '07%';


-- ADD CASHBACK COLUMN
ALTER TABLE reservation156
ADD cashback NUMBER(10,2);


-- UPDATE CASHBACK
UPDATE reservation156
SET cashback = fare * 0.5
WHERE pnr_no = 5050505050;


-- EFFECTIVE PRICE
SELECT aadharno, cname, pnr_no,
       NVL(fare - cashback, fare) AS "effective-price"
FROM testcustomer_156
JOIN reservation156
ON booked_by_aadhar = aadharno;