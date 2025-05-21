{{ config(materialized='table') }}

WITH base AS (
    SELECT
        YearsExperience,
        Salary
    FROM dbt_demo.salary_dataset
),

categorized AS (
    SELECT
        YearsExperience,
        Salary,
        CASE
            WHEN YearsExperience < 3 THEN 'Junior'
            WHEN YearsExperience < 7 THEN 'Mid'
            ELSE 'Senior'
        END AS ExperienceLevel
    FROM base
),

aggregated AS (
    SELECT
        ExperienceLevel,
        COUNT(*) AS EmployeeCount,
        ROUND(AVG(Salary), 2) AS AverageSalary,
        ROUND(AVG(YearsExperience), 2) AS AverageExperience
    FROM categorized
    GROUP BY ExperienceLevel
)

SELECT * FROM aggregated;
