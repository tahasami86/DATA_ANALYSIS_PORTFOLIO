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

SPLITING OWNER ADDRESS into different Columns

*/

SELECT  PARSENAME(REPLACE(OwnerAddress,',' , '.'),3),
		PARSENAME(REPLACE(OwnerAddress,',' , '.'),2),
		PARSENAME(REPLACE(OwnerAddress,',' , '.'),1)
FROM [Nashville Housing Data for Data Cleaning_CSV]

ALTER TABLE DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]
ADD OWNER_ADDRESS_SPLIT NVARCHAR(255);

UPDATE [Nashville Housing Data for Data Cleaning_CSV]
SET
OWNER_ADDRESS_SPLIT=PARSENAME(REPLACE(OwnerAddress,',' , '.'),3)

ALTER TABLE DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]
ADD OWNER_SPLIT_CITY NVARCHAR(255);

UPDATE [Nashville Housing Data for Data Cleaning_CSV]
SET OWNER_SPLIT_CITY=PARSENAME(REPLACE(OwnerAddress,',' , '.'),2)


ALTER TABLE DATA_CLEANING_PROJECT..[Nashville Housing Data for Data Cleaning_CSV]
ADD OWNER_SPLIT_STATE NVARCHAR(255);

UPDATE [Nashville Housing Data for Data Cleaning_CSV]
SET OWNER_SPLIT_STATE=PARSENAME(REPLACE(OwnerAddress,',' , '.'),1)


SELECT *
FROM [Nashville Housing Data for Data Cleaning_CSV]


-------------------------------------------------------------------------------

/*

CHANGE VALUES 


*/

--------------------------------------------------------------------------------


SELECT DISTINCT(SoldAsVacant_NEW),COUNT(SoldAsVacant)
FROM [Nashville Housing Data for Data Cleaning_CSV]
GROUP BY SoldAsVacant_NEW
ORDER BY 1

ALTER TABLE [Nashville Housing Data for Data Cleaning_CSV]
ADD SoldAsVacant_NEW NVARCHAR(255)

UPDATE [Nashville Housing Data for Data Cleaning_CSV]
SET SoldAsVacant_New=cast(SoldAsVacant as nvarchar)


UPDATE [Nashville Housing Data for Data Cleaning_CSV]
SET SoldAsVacant_NEW=CASE
                     WHEN SoldAsVacant_NEW = 1 THEN 'YES'
                     WHEN SoldAsVacant_NEW = 0 THEN 'NO'
                   END;
				



----------------------------------------------------------------------------------------

/*

REMOVE DUPLICATES


*/

---------------------------------------------------------------------------------------
WITH ROWNUMCTE AS(				
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 LegalReference
				 ORDER BY UniqueID
				 ) row_num
FROM [Nashville Housing Data for Data Cleaning_CSV]
)

SELECT *
FROM ROWNUMCTE
WHERE row_num > 1



-------------------------------------------------------------------------

/*

Delet Columns

*/


----------------------------------------------------------------------------


SELECT *
FROM [Nashville Housing Data for Data Cleaning_CSV]

ALTER TABLE [Nashville Housing Data for Data Cleaning_CSV]
DROP COLUMN PropertyAddress, OwnerAddress




