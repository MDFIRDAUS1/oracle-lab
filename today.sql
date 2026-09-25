Sure. Below are all 7 answers in English, in Oracle SQL format, ready to write in your practical copy.
1. Faculty employees and their supervisors who joined between August and October
SELECT f.fname AS employee_name,
       f.empid AS employee_id,
       f.salary AS employee_salary,
       s.fname AS supervisor_name,
       s.empid AS supervisor_id,
       s.salary AS supervisor_salary
FROM faculty156 f
JOIN faculty156 s
ON f.supervisedby_emp = s.empid
WHERE EXTRACT(MONTH FROM f.joining_date) BETWEEN 8 AND 10
  AND EXTRACT(MONTH FROM s.joining_date) BETWEEN 8 AND 10;
Note: If your joining-date column has a different name, replace joining_date with the actual column name.
2. Faculty employees who are older than their supervisors
SELECT f.fname AS employee_name,
       f.empid AS employee_id,
       f.salary AS employee_salary,
       s.fname AS supervisor_name,
       s.empid AS supervisor_id,
       s.salary AS supervisor_salary
FROM faculty156 f
JOIN faculty156 s
ON f.supervisedby_emp = s.empid
WHERE f.dob < s.dob;
Here, an earlier DOB means the employee is older than the supervisor.
3. Passengers whose name contains A/a 1 to 2 times
SELECT c.cname,
       c.aadharno,
       c.mobileno,
       r.pnr_no,
       r.fare
FROM testcustomer_156 c
JOIN reservation156 r
ON c.aadharno = r.booked_by_aadhar
WHERE REGEXP_COUNT(LOWER(c.cname), 'a') BETWEEN 1 AND 2;
This displays passengers whose name contains A or a, with the total occurrence between 1 and 2.
4. Passengers, ticket details, seat details, idle passengers and unsold seats
SELECT c.cname,
       c.aadharno,
       c.mobileno,
       r.pnr_no,
       r.fare,
       s.seat_no,
       s.offered_by_trip_id AS trip_id
FROM testcustomer_156 c
LEFT JOIN reservation156 r
ON c.aadharno = r.booked_by_aadhar
LEFT JOIN seats156 s
ON r.pnr_no = s.booked_under_pnr

UNION

SELECT NULL AS cname,
       NULL AS aadharno,
       NULL AS mobileno,
       NULL AS pnr_no,
       NULL AS fare,
       s.seat_no,
       s.offered_by_trip_id AS trip_id
FROM seats156 s
WHERE s.booked_under_pnr IS NULL;
LEFT JOIN includes passengers who have never bought a ticket.
booked_under_pnr IS NULL identifies unsold seats.
5. Supervisors and their corresponding supervisors
SELECT DISTINCT
       f.empid AS supervisor_id,
       f.fname AS supervisor_name,
       f.salary AS supervisor_salary,
       s.empid AS senior_supervisor_id,
       s.fname AS senior_supervisor_name,
       s.salary AS senior_supervisor_salary
FROM faculty156 f
JOIN faculty156 e
ON e.supervisedby_emp = f.empid
LEFT JOIN faculty156 s
ON f.supervisedby_emp = s.empid;
DISTINCT is used to avoid duplicate supervisor records.
6. Passenger departure and return dates within 24 hours
Assuming reservation156 contains trip_id:
SELECT DISTINCT
       c.cname,
       c.aadharno,
       c.mobileno,
       t1.date_of_trip AS departure_date,
       t2.date_of_trip AS return_date
FROM testcustomer_156 c
JOIN reservation156 r1
ON c.aadharno = r1.booked_by_aadhar
JOIN trip156 t1
ON r1.trip_id = t1.trip_id
JOIN reservation156 r2
ON c.aadharno = r2.booked_by_aadhar
JOIN trip156 t2
ON r2.trip_id = t2.trip_id
WHERE t1.source = t2.destination
  AND t1.destination = t2.source
  AND t2.date_of_trip > t1.date_of_trip
  AND t2.date_of_trip - t1.date_of_trip <= 1;
The query checks that the return journey is between the same source and destination in the opposite direction and occurs within 24 hours.
7. Trips with no tickets sold and less than 24 hours remaining
SELECT t.trip_id AS trip_no,
       t.conductedby_veh_no AS veh_reg_no,
       t.date_of_trip
FROM trip156 t
LEFT JOIN seats156 s
ON t.trip_id = s.offered_by_trip_id
WHERE s.booked_under_pnr IS NULL
  AND t.date_of_trip > SYSDATE
  AND t.date_of_trip <= SYSDATE + 1;
Here:
SYSDATE = current date and time.
SYSDATE + 1 = 24 hours from the current date/time.
booked_under_pnr IS NULL = no ticket has been sold/booked.
Important: Q1, Q2 and Q6 depend on columns such as joining_date, dob, and trip_id. If your actual table uses different column names, those names must be replaced accordingly.