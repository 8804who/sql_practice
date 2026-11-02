WITH recovery_date AS (
    SELECT c.patient_id, c.test_date as positive_date, (SELECT MIN(test_date) FROM covid_tests WHERE result = 'Negative' AND test_date >  c.test_date   AND patient_id = c.patient_id GROUP BY patient_id ) as negative_date
    FROM covid_tests c
    WHERE c.result = 'Positive'
),
tt AS (
    SELECT patient_id, negative_date, MIN(positive_date) as positive_date
    FROM recovery_date
    WHERE negative_date IS NOT NULL
    GROUP BY patient_id, negative_date
),
pp AS (
    SELECT patient_id, MIN(positive_date) as positive_date
    FROM tt
    GROUP BY patient_id
)
SELECT p.patient_id, patient_name, age, MIN(tt.negative_date - tt.positive_date) as recovery_time
FROM patients p
INNER JOIN tt ON p.patient_id = tt.patient_id
INNER JOIN pp ON pp.positive_date = tt.positive_date
GROUP BY p.patient_id, patient_name, age
ORDER BY recovery_time, patient_name