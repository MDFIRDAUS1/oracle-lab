```sql
create table testcustomer156( 
    aadharno number(12), 
    mobileno number(10), 
    cname varchar(50), 
    email varchar(100), 
    dob date 
); 

--select * from tab; 
describe testcustomer156; 
 
insert into testcustomer156 
values( 
    123456789012, 
    1234567890, 
    'rahim', 
    'Rahim@gmail.com', 
    '26-june-02' 
);  

--delete from testcustomer156; 

select * from testcustomer156; 


create table reservation156( 
    PNR_NO number(10), 
    date_of_booking date, 
    cost number(10,3) 
); 
 
desc reservation156; 
 
insert into reservation156 
values(12345,'30-JUL-2026',100); 
 
--select * from reservation156; 


create table bus156( 
    veg_reg_no number(10) constraint cons_pkey_regno_bus primary key, 
    model varchar2(100), 
    date_of_reg date 
); 
 
insert into bus156 
values(56789,'BMW','30-JUL-2026'); 
 
--select * from bus156; 


alter table testcustomer156 
add constraint cons_pkey_aadhaar_user primary key(aadharno); 
    
alter table reservation156 
add constraint cons_pkay_pnr_res primary key(PNR_NO); 
    
--delete from reservation156; 
-- to delete data of table 
 
select table_name,constraint_name,constraint_type,search_condition 
from user_constraints; 
 
select table_name, constraint_name,column_name 
from user_cons_columns; 


alter table reservation156 
add booked_by_aadhar number(12); 
 
alter table reservation156 
add constraint cons_fkey_bookedaadhar foreign key(booked_by_aadhar) 
references testcustomer156(aadharno); 


insert into testcustomer156 
values( 
    123456781111, 
    1234567111, 
    'Rishabh sinha', 
    'Rishabh.kumarsinha2@gmail.com', 
    '10-SEP-05' 
); 

select * from testcustomer156; 
 
 
insert into testcustomer156 
values( 
    123456782222, 
    1234567222, 
    'vinit singh', 
    'vinit@gmail.com', 
    '14-SEP-05' 
); 
 
insert into reservation156 
values(123456,'31-JUL-2026',200,123456782222); 

insert into reservation156 
values(123666,'29-JUL-2026',200,123456789012); 
    

create table trip156( 
    trip_id varchar(100) constraint cons_pkey_trip2id primary key, 
    date_of_trip date constraint cons_nnull_datetrip2 not null, 
    source varchar(50) constraint cons_nnull_src not null, 
    destination varchar(50) constraint cons_nnull_dest not null, 
    conductedby_veh_no number(10), 
    constraint cons_fkey_conductedbyvehno foreign key(conductedby_veh_no) 
    references bus156(veg_reg_no) 
); 

desc trip156; 
  

create table seats156( 
    seat_no number(2), 
    seat_price number(10,2), 
    offeredby_trip_id varchar(10) constraint cons_fkey_trip_id 
    references trip156(trip_id), 
    bookedunder_pnr number(10), 
    constraint cons_fkey_pnr foreign key(bookedunder_pnr) 
    references reservation156(PNR_NO), 
    constraint cons_pkey_seatno_tripid primary key(seat_no ,offeredby_trip_id) 
); 
 
alter table reservation156 
modify booked_by_aadhar constraint cons_null_bookedaadhar not null; 

--SELECT * 
--FROM reservation156 
--WHERE booked_by_aadhar IS NULL; 

SELECT * from reservation156; 

--delete from reservation156 where pnr_no = 12345; 

insert into reservation156 
values(12345,'30-JUL-2026',100,123456781111); 
     

ALTER TABLE bus156 
ADD conductedby_vehno NUMBER(10); 
 
update bus156 
set conductedby_vehno = 234 
where veg_reg_no = 56789; 

alter table bus156 
modify conductedby_vehno number(10) 
constraint cons_null_conductedby_veh_no not null; 

select * from bus156; 
 
 
INSERT INTO bus156 
VALUES (56777, 'TATA', '15-JAN-2025', 56777); 
 
INSERT INTO bus156 
VALUES (56666, 'ASHOK LEYLAND', '20-FEB-2025', 56666); 
 
 
insert all 
into trip156 values('t01','20-AUG-2026','howrah','kalimpong',56789) 
into trip156 values('t02','21-AUG-2026','howrah','sikkim',56666) 
into trip156 values('t03','22-AUG-2026','howrah','assam',56777) 
select * from dual; 
 
 
insert all 
into seats156 values(23,200.24,'t01',123456) 
into seats156 values(24,250.99,'t02',123666) 
into seats156 values(25,150.50,'t03',12345) 
select * from dual; 
 
 
select * from tab; 
select * from trip156; 
select * from testcustomer156; 
select * from seats156; 
select * from reservation156; 
select * from bus156; 

desc trip156; 
desc testcustomer156; 
desc seats156; 
desc reservation156; 
 
 
select lt.table_name, rt.column_name, lt.constraint_name, 
       lt.constraint_type, lt.search_condition 
from user_constraints lt, user_cons_columns rt 
where lt.constraint_name = rt.constraint_name 
and to_char(last_change,'DD-MON-YYYY') >= '21-AUG-2026' 
order by lt.table_name; 
 
 
desc testcustomer156; 
select * from testcustomer156; 

desc reservation156; 


select AADHARNO,CNAME 
from testcustomer156 
where DOB>'10-june-2002'; 


select * 
from testcustomer156 
join reservation156 
on aadharno=booked_by_aadhar; 


select * 
from testcustomer156 
full outer join reservation156 
on aadharno=booked_by_aadhar; 


select AADHARNO,CNAME,PNR_NO,0.9*COST "Discounted Cost" 
from testcustomer156 
join reservation156 
on aadharno=booked_by_aadhar 
where CNAME like 'R%' 
order by cost ; 


select * 
from testcustomer156 
where upper(CNAME) like 'V%'; 


select AADHARNO,CNAME,PNR_NO 
from testcustomer156 
where to_char(dob,'MONTH,DD,YYYY') 
like 'SEPTEMBER%'; 


-- nvl(COST-CASHBACK,COST) or COST-nvl(CASHBACK,0) 
 
select AADHARNO,CNAME,PNR_NO,
       nvl(COST-CASHBACK,COST) "Effective price" 
from testcustomer156 
join reservation156 
on aadharno=booked_by_aadhar; 


alter table reservation156 
add cashback number(4); 


select * from reservation156; 


update reservation156 
set cashback = cost*0.05 
where PNR_NO =123456; 


insert into testcustomer156 
values( 
    123456786767, 
    1234567676, 
    'vishal pathak', 
    'vishal.pathak3@gmail.com', 
    '14-02-05'
); 


insert into testcustomer156 
values( 
    123455556767, 
    1233337676, 
    'Vishal pathak', 
    'Vishal.pathak3@gmail.com', 
    '14-10-05'
); 


select table_name, column_name, constraint_name, 
       constraint_type, search_condition 
from user_constraints natural join user_cons_columns ; 


commit;
```



//testcustomer missing


ALTER TABLE testcustomer156
ADD address VARCHAR2(50);

INSERT INTO testcustomer156
VALUES(
    123456786767,
    1234567676,
    'vishal pathak',
    'vishal.pathak3@gmail.com',
    '14-02-05',
    'patna'
);

INSERT INTO testcustomer156
VALUES(
    123455556767,
    1233337676,
    'Vishal pathak',
    'Vishal.pathak3@gmail.com',
    '14-10-05',
    'patna'
);

SELECT * FROM testcustomer156;

