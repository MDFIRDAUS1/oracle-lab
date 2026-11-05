# CSE3151 DBMS LAB
## DAY 3 – JOINS AND SINGLE ROW FUNCTIONS
**ROLL NO.: 156**

### Q1. Display employee and supervisor details when both joined between August and October.

```sql
SELECT
    e.fname AS emp_name,
    e.empid AS emp_id,
    e.salary AS emp_salary,
    s.fname AS sup_name,
    s.empid AS sup_id,
    s.salary AS sup_salary
FROM faculty156 e
JOIN faculty156 s
    ON e.supervisedby_emp = s.empid
WHERE EXTRACT(MONTH FROM e.doj) BETWEEN 8 AND 10
  AND EXTRACT(MONTH FROM s.doj) BETWEEN 8 AND 10;
```

### Q2. Display employee and supervisor details when employee is older than supervisor.

```sql
SELECT
    e.fname AS emp_name,
    e.empid AS emp_id,
    e.salary AS emp_salary,
    s.fname AS sup_name,
    s.empid AS sup_id,
    s.salary AS sup_salary
FROM faculty156 e
JOIN faculty156 s
    ON e.supervisedby_emp = s.empid
WHERE e.dob < s.dob;
```

### Q3. Display passenger and booking details when passenger name contains A/a exactly 1 or 2 times.

```sql
SELECT
    c.cname,
    c.aadharno,
    c.mobileno,
    r.pnr_no,
    r.cost
FROM testcustomer156 c
JOIN reservation156 r
    ON c.aadharno = r.booked_by_aadharno
WHERE LENGTH(UPPER(c.cname))
    - LENGTH(REPLACE(UPPER(c.cname), 'A', ''))
    BETWEEN 1 AND 2;
```

### Q4. Display all passengers, booking details and seat details, including passengers who never booked and seats that have not been booked.

```sql
SELECT
    c.cname,
    c.aadharno,
    c.mobileno,
    r.pnr_no,
    r.cost,
    s.seat_no,
    s.offeredby_trip_id,
    s.bookedby_pnr_no
FROM testcustomer156 c
FULL OUTER JOIN reservation156 r
    ON c.aadharno = r.booked_by_aadharno
FULL OUTER JOIN seats156 s
    ON r.pnr_no = s.bookedby_pnr_no;
```

### Q5. Display supervisor faculty details along with their corresponding supervisors. Exclude faculty who are not supervisors.

```sql
SELECT DISTINCT
    sup.empid AS supervisor_id,
    sup.fname AS supervisor_name,
    sup.salary AS supervisor_salary,
    mgr.empid AS mgr_id,
    mgr.fname AS mgr_name,
    mgr.salary AS mgr_salary
FROM faculty156 emp
JOIN faculty156 sup
    ON emp.supervisedby_emp = sup.empid
JOIN faculty156 mgr
    ON sup.supervisedby_emp = mgr.empid;
```

### Q6. Display passenger details and departure/return dates when return journey is within 24 hours and source/destination are reversed.

```sql
SELECT DISTINCT
    c.cname,
    c.aadharno,
    c.mobileno,
    t1.date_of_trip AS departure_date,
    t2.date_of_trip AS return_date
FROM testcustomer156 c
JOIN reservation156 r1
    ON c.aadharno = r1.booked_by_aadharno
JOIN seats156 s1
    ON r1.pnr_no = s1.bookedby_pnr_no
JOIN trip156 t1
    ON s1.offeredby_trip_id = t1.trip_id
JOIN reservation156 r2
    ON c.aadharno = r2.booked_by_aadharno
JOIN seats156 s2
    ON r2.pnr_no = s2.bookedby_pnr_no
JOIN trip156 t2
    ON s2.offeredby_trip_id = t2.trip_id
WHERE t2.source = t1.destination
  AND t2.destination = t1.source
  AND t2.trip_id <> t1.trip_id
  AND t2.date_of_trip > t1.date_of_trip
  AND t2.date_of_trip <= t1.date_of_trip + 1;
```

### Q7. Display trips whose tickets have not been sold and which start within the next 24 hours.

```sql
SELECT
    t.trip_id AS trip_no,
    t.conductedby_veh_reg_no AS vehicle_reg_no,
    t.date_of_trip
FROM trip156 t
WHERE t.date_of_trip > SYSDATE
  AND t.date_of_trip < SYSDATE + 1
  AND NOT EXISTS (
      SELECT 1
      FROM seats156 s
      WHERE s.offeredby_trip_id = t.trip_id
        AND s.bookedby_pnr_no IS NOT NULL
  );
```

### Final

```sql
COMMIT;
```

If any column names differ from those used in the queries, replace them with the actual column names in your tables.
