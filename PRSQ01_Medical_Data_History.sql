-- ============================================================
-- PROJECT  : PRSQ-01 Medical Data History
-- NAME     : NETTEM ASWINI NAIDU
-- TEAM ID  : PTID-CDA-OCT-26-11122
-- COURSE   : CDA
-- MEMBERS  : Individual Project
-- DB NAME  : project_medical_data_history
-- ============================================================

USE project_medical_data_history;

-- -------------------------------------------------------
-- Q1. Show first name, last name, and gender of patients
--     whose gender is 'M'
-- -------------------------------------------------------
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';


-- -------------------------------------------------------
-- Q2. Show first name and last name of patients who do
--     not have allergies.
-- -------------------------------------------------------
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;


-- -------------------------------------------------------
-- Q3. Show first name of patients that start with 'C'
-- -------------------------------------------------------
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';


-- -------------------------------------------------------
-- Q4. Show first name and last name of patients with
--     weight within the range of 100 to 120 (inclusive)
-- -------------------------------------------------------
SELECT first_name, last_name, weight
FROM patients
WHERE weight BETWEEN 100 AND 120;


-- -------------------------------------------------------
-- Q5. Update the patients table: if allergies is NULL
--     replace it with 'NKA'
-- -------------------------------------------------------
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

-- Alternative (for read-only access, shows the same result without changing data):
SELECT first_name, last_name,
IFNULL(allergies, 'NKA') AS allergies
FROM patients;


-- -------------------------------------------------------
-- Q6. Show first name and last name concatenated into
--     one column as full name
-- -------------------------------------------------------
SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;


-- -------------------------------------------------------
-- Q7. Show first name, last name, and the full province
--     name of each patient
-- -------------------------------------------------------
SELECT p.first_name, p.last_name, pr.province_name
FROM patients p
JOIN province_names pr ON p.province_id = pr.province_id;


-- -------------------------------------------------------
-- Q8. Show how many patients have a birth_date with
--     2010 as the birth year
-- -------------------------------------------------------
SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;


-- -------------------------------------------------------
-- Q9. Show first_name, last_name, and height of the
--     patient with the greatest height
-- -------------------------------------------------------
SELECT first_name, last_name, height
FROM patients
WHERE height = (SELECT MAX(height) FROM patients);


-- -------------------------------------------------------
-- Q10. Show all columns for patients who have one of
--      the following patient_ids: 1, 45, 534, 879, 1000
-- -------------------------------------------------------
SELECT * FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);


-- -------------------------------------------------------
-- Q11. Show the total number of admissions
-- -------------------------------------------------------
SELECT COUNT(*) AS total_admissions
FROM admissions;


-- -------------------------------------------------------
-- Q12. Show all columns from admissions where the patient
--      was admitted and discharged on the same day
-- -------------------------------------------------------
SELECT * FROM admissions
WHERE admission_date = discharge_date;


-- -------------------------------------------------------
-- Q13. Show the total number of admissions for
--      patient_id 579
-- -------------------------------------------------------
SELECT COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id = 579;


-- -------------------------------------------------------
-- Q14. Show unique cities in province_id 'NS'
-- -------------------------------------------------------
SELECT DISTINCT city FROM patients
WHERE province_id = 'NS';


-- -------------------------------------------------------
-- Q15. Show first_name, last_name and birth_date of
--      patients with height > 160 and weight > 70
-- -------------------------------------------------------
SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160 AND weight > 70;


-- -------------------------------------------------------
-- Q16. Show unique birth years from patients ordered
--      ascending
-- -------------------------------------------------------
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year ASC;


-- -------------------------------------------------------
-- Q17. Show unique first names that occur only once
--      in the patients table
-- -------------------------------------------------------
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;


-- -------------------------------------------------------
-- Q18. Show patient_id and first_name where first_name
--      starts and ends with 's' and is at least 6 chars
-- -------------------------------------------------------
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%s'
  AND CHAR_LENGTH(first_name) >= 6;

-- -------------------------------------------------------
-- Q19. Show patient_id, first_name, last_name from
--      patients whose diagnosis is 'Dementia'
-- -------------------------------------------------------
SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';


-- -------------------------------------------------------
-- Q20. Display every patient's first_name ordered by
--      length of name then alphabetically
-- -------------------------------------------------------
SELECT first_name
FROM patients
ORDER BY CHAR_LENGTH(first_name) ASC, first_name ASC;

-- -------------------------------------------------------
-- Q21 & Q22. Show total male and total female patients
--            in the same row
-- -------------------------------------------------------
SELECT
  SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_count,
  SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_count
FROM patients;


-- -------------------------------------------------------
-- Q23. Show patient_id, diagnosis from admissions where
--      patients were admitted multiple times for the
--      same diagnosis
-- -------------------------------------------------------
SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;


-- -------------------------------------------------------
-- Q24. Show city and total number of patients per city,
--      ordered from most to least, then city ascending
-- -------------------------------------------------------
SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;


-- -------------------------------------------------------
-- Q25. Show first name, last name and role of every
--      person that is either a patient or doctor
-- -------------------------------------------------------
SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;


-- -------------------------------------------------------
-- Q26. Show all allergies ordered by popularity,
--      removing NULL values
-- -------------------------------------------------------
SELECT allergies, COUNT(*) AS total_patients
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_patients DESC;


-- ------------------------------------------------------
-- Q27. Show first_name, last_name, and birth_date of
--      patients born in the 1970s, sorted by birth_date
-- -------------------------------------------------------
SELECT first_name, last_name, birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;


-- -------------------------------------------------------
-- Q28. Display full name as LASTNAME,firstname
--      (last in UPPER, first in lower), ordered by
--      first_name descending
-- -------------------------------------------------------
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;


-- -------------------------------------------------------
-- Q29. Show province_id(s) where the sum of patient
--      heights is >= 7000
-- -------------------------------------------------------
SELECT province_id, SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;


-- -------------------------------------------------------
-- Q30. Show the difference between the largest and
--      smallest weight for patients with last name 'Maroni'
-- -------------------------------------------------------
SELECT MAX(weight) - MIN(weight) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';


-- -------------------------------------------------------
-- Q31. Show all days of the month (1-31) and how many
--      admissions occurred on that day, sorted by most
--      admissions to least
-- -------------------------------------------------------
SELECT DAY(admission_date) AS day_of_month,
       COUNT(*) AS total_admissions
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY total_admissions DESC;


-- -------------------------------------------------------
-- Q32. Show patients grouped into weight groups
--      (e.g. 100-109 = group 100), ordered descending
-- -------------------------------------------------------
SELECT
  FLOOR(weight / 10) * 10 AS weight_group,
  COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;


-- -------------------------------------------------------
-- Q33. Show patient_id, weight, height, isObese
--      (BMI = weight(kg) / (height(m))^2 >= 30 = obese)
-- -------------------------------------------------------
SELECT
  patient_id,
  weight,
  height,
  CASE
    WHEN weight / POWER(height / 100.0, 2) >= 30 THEN 1
    ELSE 0
  END AS isObese
FROM patients;


-- -------------------------------------------------------
-- Q34. Show patient_id, first_name, last_name, and
--      attending doctor's specialty for patients with
--      diagnosis 'Epilepsy' and doctor's first name 'Lisa'
-- -------------------------------------------------------
SELECT
  p.patient_id,
  p.first_name,
  p.last_name,
  d.speciality
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
  AND d.first_name = 'Lisa';



-- ============================================================
-- END OF FILE
-- ============================================================
