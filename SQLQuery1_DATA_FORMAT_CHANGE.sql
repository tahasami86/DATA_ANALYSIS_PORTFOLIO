SELECT *
FROM DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]


/*

DATE FORMAT CONVERSION

*/

SELECT SALE_DATE_CONVERTED_DATETIME , CONVERT(datetime,SaleDate)

FROM DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]


ALTER TABLE [Nashville Housing Data for Data Cleaning_CSV]
ADD SALE_DATE_CONVERTED_DATETIME DATETIME;

UPDATE [Nashville Housing Data for Data Cleaning_CSV]
SET SALE_DATE_CONVERTED_DATETIME=CONVERT(datetime,SaleDate)

SELECT *
FROM DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]



-----------------------------------------------------------------------------------------------------------------------
/*

FILLING NULL VALUES

*/

SELECT *
FROM DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]

SELECT UniqueID, ParcelID, PropertyAddress
FROM DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]
WHERE PropertyAddress IS NULL

SELECT AA.UniqueID , AA.PropertyAddress , BB.PropertyAddress , BB.UniqueID , ISNULL(AA.PropertyAddress , BB.PropertyAddress)
FROM [Nashville Housing Data for Data Cleaning_CSV]  AA
JOIN [Nashville Housing Data for Data Cleaning_CSV]  BB
ON	AA.ParcelID = BB.ParcelID
AND AA.UniqueID <> BB.UniqueID
WHERE AA.PropertyAddress IS NULL

UPDATE AA
SET AA.PropertyAddress = ISNULL(AA.PropertyAddress , BB.PropertyAddress)
FROM [Nashville Housing Data for Data Cleaning_CSV]  AA
JOIN [Nashville Housing Data for Data Cleaning_CSV]  BB
ON	AA.ParcelID = BB.ParcelID
AND AA.UniqueID <> BB.UniqueID
WHERE AA.PropertyAddress IS NULL


SELECT * 
FROM DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]


-------------------------------------------------------------------------------

/*

SEPERATING ADDRESS INTO DIFFERNET COLUMNS
*/

SELECT 
SUBSTRING(PropertyAddress , 1, CHARINDEX( ',', PropertyAddress) - 1 ) AS ADDRE,CHARINDEX(',',PropertyAddress),
SUBSTRING(PropertyAddress , CHARINDEX( ',', PropertyAddress) + 1 , LEN(PropertyAddress) ) AS ADDRE_CITY

FROM DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]



ALTER TABLE DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]
ADD ADDRESS_SPLIT NVARCHAR(255);

UPDATE [Nashville Housing Data for Data Cleaning_CSV]
SET
ADDRESS_SPLIT=SUBSTRING(PropertyAddress , 1, CHARINDEX( ',', PropertyAddress) - 1 ) 


ALTER TABLE DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]
ADD ADDRESS_CITY NVARCHAR(255);


UPDATE [Nashville Housing Data for Data Cleaning_CSV]
SET
ADDRESS_CITY=SUBSTRING(PropertyAddress , CHARINDEX( ',', PropertyAddress) + 1 , LEN(PropertyAddress) ) 



SELECT *
FROM DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]



------------------------------------------------------------------------------------------------------------------

/*

SPLITING OWNER ADDRESS

*/