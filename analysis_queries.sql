-- file #1: data import and cleaning 
-- all of this code is my own original work

-- created medical student database
create database medical_student_db; 
use medical_student_db; 

-- created table within database to import data into 
-- set all datatypes are set to varchar to make import quick & smooth
create table medical_students (
student_id varchar(20), 
age varchar(20), 
gender varchar(20), 
height varchar(20), 
weight varchar(20), 
blood_type varchar(20),
bmi varchar(20), 
temperature varchar(20),
heart_rate varchar(20), 
blood_pressure varchar(20), 
cholesterol varchar(20), 
diabetes varchar(20), 
smoking varchar(20)
);

-- checked where in my file explorer mysql is getting its import data  
SHOW VARIABLES LIKE 'secure_file_priv';

-- loaded data into medical student table
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/medical_students_dataset.csv'
into table medical_students
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;

-- attempted to modify datatypes to match the values in each column
alter table medical_students
  modify column student_id int,
  modify column age float,
  modify column height float,
  modify column weight float,
  modify column bmi float,
  modify column temperature float,
  modify column heart_rate float,
  modify column blood_pressure float,
  modify column cholesterol float;
  
-- had issues with modifying columns because of the missing data
-- replaced empty strings with null values
update medical_students
set 
  student_id = nullif(student_id, ''),
  age = nullif(age, ''),
  height = nullif(height, ''),
  weight = nullif(weight, ''),
  bmi = nullif(bmi, ''),
  temperature = nullif(temperature, ''),
  heart_rate = nullif(heart_rate, ''),
  blood_pressure = nullif(blood_pressure, ''),
  cholesterol = nullif(cholesterol, '');

-- successfully altered datatypes 
alter table medical_students
  modify column student_id int,
  modify column age float,
  modify column height float,
  modify column weight float,
  modify column bmi float,
  modify column temperature float,
  modify column heart_rate float,
  modify column blood_pressure float,
  modify column cholesterol float;

-- checked data types
describe medical_students;

-- removed duplicates
create table medical_students_clean AS
select distinct *
from medical_students;

drop table medical_students;
rename table medical_students_clean TO medical_students;

-- replace empty strings with null values in colums with string value types
update medical_students
set 
  gender = nullif(gender, ''),
  diabetes = nullif(diabetes, ''),
  smoking = nullif(smoking, ''),
  blood_type = nullif(blood_type, '');

-- remove rows with important data missing (id, age, and gender are critical data points)
delete from medical_students
where student_id IS NULL OR age IS NULL OR gender IS NULL;

-- checked first 10 row output
select * from medical_students 
limit 10;

-- step #2: analyzing medical student health & risk factor 
-- based on 172,356 complete records; 20,000 rows excluded due to missing values (10%) and 7,644 duplicates removed prior to analysis.

-- 1. health risk by gender (bmi, cholesterol, heart rate)
select
gender, 
count(*) as student_count, 
avg(bmi), 
avg(cholesterol), 
avg(heart_rate)
from medical_students
group by gender; 

-- 2. diabetes prevalence by age group
select 
age,
count(*) as student_count, 
round((sum(case when diabetes = 'Yes' THEN 1 ELSE 0 END) / count(*)) * 100, 2) as percent_diabetic,
round((sum(case when diabetes = 'No' THEN 1 ELSE 0 END) / count(*)) * 100, 2) as percent_non_diabetic
from medical_students
where age is not null 
group by age
order by age asc;

-- 3. smoking & cardiovascular risk
select 
smoking,
count(*) as student_count, 
avg(heart_rate) as avg_heart_rate,
avg(blood_pressure) as avg_blood_pressure, 
avg(cholesterol) as avg_cholesterol
from medical_students
where smoking is not null 
group by smoking
order by smoking asc;

-- 4. identifying high-risk students (measured by: bmi > 30, cholesterol > 200, and/or blood pressure > 140)
select 
count(*) as total_student_count, 
sum(case
	when (bmi is not null and bmi > 30) 
    or (cholesterol is not null and cholesterol > 200) 
    or (blood_pressure is not null and blood_pressure > 140)
	then 1 else 0 end) 
as high_risk_students,
round(sum(case
	when (bmi is not null and bmi > 30) 
    or (cholesterol is not null and cholesterol > 200) 
    or (blood_pressure is not null and blood_pressure > 140)
	then 1 else 0 end) /
(select count(*) 
	from medical_students 
	where bmi is not null 
	or cholesterol is not null 
	or blood_pressure is not null) * 100, 2)
as percent_high_risk
from medical_students;

-- 5. blood type distribution
select
count(*) as student_count, 
blood_type
from medical_students
where blood_type is not null
group by blood_type
order by blood_type asc;

-- 6. average health metrics by diabetes status
select 
count(*) as student_count, 
diabetes, 
round(avg(bmi), 2) as avg_bmi, 
round(avg(cholesterol), 2) as avg_cholesterol, 
round(avg(blood_pressure), 2) as avg_blood_pressure
from medical_students
where diabetes is not null
group by diabetes;
 