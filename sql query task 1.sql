
--WORK DATA
-- Step 1: Create the merged_work_sponsorship table

CREATE TABLE dbo.merged_work_sponsorship
(
    Year INT NOT NULL,
    Quarter NVARCHAR(50) NOT NULL,
    Application_Type NVARCHAR(100) NOT NULL,
    Category_of_Leave NVARCHAR(100) NOT NULL,
    Industry NVARCHAR(100) NULL,
    Geographical_region NVARCHAR(100) NULL,
    Nationality NVARCHAR(100) NULL,
    Application_Count INT NOT NULL,
    Data_View NVARCHAR(20) NOT NULL
);
GO

-- Step 2: Insert merged Industry-level and Nationality-level data

INSERT INTO dbo.merged_work_sponsorship
(
    Year,
    Quarter,
    Application_Type,
    Category_of_Leave,
    Industry,
    Geographical_region,
    Nationality,
    Application_Count,
    Data_View
)

SELECT
    Year,
    Quarter,
    Type_of_application AS Application_Type,
    Category_of_leave AS Category_of_Leave,
    Industry,
    NULL AS Geographical_region,
    NULL AS Nationality,
    Applications AS Application_Count,
    'By_Industry' AS Data_View
FROM
    [UK_Immigration.].[dbo].[migration-work-sponsorship-datasets-1]

UNION ALL

SELECT
    Year,
    Quarter,
    Type_of_application AS Application_Type,
    Category_of_leave AS Category_of_Leave,
    NULL AS Industry,
    Geographical_region,
    Nationality,
    Applications AS Application_Count,
    'By_Nationality' AS Data_View
FROM
    [UK_Immigration.].[dbo].[migration-work-sponsorship-datasets-2];
GO


select*
from [UK_Immigration.].dbo.merged_work_sponsorship


--STUDY DATA
-- Step 1: Create the merged_study_sponsorship table

CREATE TABLE dbo.merged_study_sponsorship
(
    Year INT NOT NULL,
    Quarter NVARCHAR(50) NOT NULL,
    Application_Type NVARCHAR(100) NOT NULL,
    Institution_Group NVARCHAR(100) NOT NULL,
    Institution_Type NVARCHAR(100) NULL,
    Geographical_region NVARCHAR(100) NULL,
    Nationality NVARCHAR(100) NULL,
    Application_Count INT NOT NULL,
    Data_View NVARCHAR(20) NOT NULL
);
GO

-- Step 2: Insert merged Nationality-level and Institution-level data

INSERT INTO dbo.merged_study_sponsorship
(
    Year,
    Quarter,
    Application_Type,
    Institution_Group,
    Institution_Type,
    Geographical_region,
    Nationality,
    Application_Count,
    Data_View
)

SELECT
    Year,
    Quarter,
    Type_of_application AS Application_Type,
    Institution_type_group AS Institution_Group,
    NULL AS Institution_Type,             
    Geographical_region,
    Nationality,
    Applications AS Application_Count,
    'By_Nationality' AS Data_View
FROM
    [UK_Immigration.].[dbo].[migration-study-sponsorship-datasets-2]

UNION ALL

SELECT
    Year,
    Quarter,
    Type_of_application AS Application_Type,
    Institution_type_group AS Institution_Group,
    Institution_type AS Institution_Type,  
    NULL AS Geographical_region,
    NULL AS Nationality,
    Applications AS Application_Count,
    'By_Institution' AS Data_View
FROM
    [UK_Immigration.].[dbo].[migration-study-sponsorship-datasets-1];
GO

