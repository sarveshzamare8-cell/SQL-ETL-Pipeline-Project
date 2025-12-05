✅ Objective

Begin the ETL process by extracting the raw dataset and loading it into a SQL database.

📌 Tasks Completed
1. Downloaded Dataset

Downloaded the file: ecommerce_purchases.csv

Verified that the data contains multiple customer purchase details.

2. Created SQLite Database

Created a new database named etl_pipeline.db using DB Browser for SQLite.

3. Imported Raw Dataset

Loaded ecommerce_purchases.csv into a new table called staging_raw.

Verified row count after import → 201 rows.

4. Identified Issues

Found first row is completely empty.

Column names loaded incorrectly as field1, field2, field3….

📊 Day 1 Output

Database successfully created

Raw dataset imported into staging_raw

Initial issues identified for cleaning in Day 2

✅ Objective

Clean and validate the raw dataset inside the staging table to prepare it for transformation.

📌 Tasks Completed
1. Renamed All Columns Correctly

The imported table had default names (field1, field2, …).
Renamed them to meaningful names:

purchase_id

name

email

country

product

price

payment_method

timestamp

address

phone

2. Removed the Empty First Row

The first row was completely blank after import.

Deleted it using SQL:

DELETE FROM staging_raw WHERE rowid = 1;


Row count changed from 201 → 200 rows.

3. Checked for Null or Empty Values

Used SQL queries to detect blank or missing data:

Checked nulls in all major columns.

Confirmed that after cleanup, no rows contain nulls.

4. Validated Email Formats

Ran SQL to detect invalid email formats:

SELECT * FROM staging_raw 
WHERE email NOT LIKE '%@%.%';


Found 1 invalid email → reviewed for correction/removal.

5. Checked for Duplicates
SELECT purchase_id, COUNT(*)
FROM staging_raw
GROUP BY purchase_id
HAVING COUNT(*) > 1;


Confirmed no duplicate purchase_id exists.

6. Verified Price Values

Ensured:

No negative prices

No zero values

All prices are in numeric format

📊 Day 2 Output

Clean and verified staging table

Proper column names added

Empty row removed

No duplicates remaining

Email validation completed

Dataset now ready for Day 3 transformations

✅ Objective

Perform deep data validation and prepare the staging table for loading into the production (clean) table.

📌 Tasks Completed
1. Final Null/Empty Value Check

Executed SQL checks across all important columns:

SELECT * FROM staging_raw
WHERE purchase_id IS NULL
   OR name = ''
   OR email = ''
   OR country = ''
   OR product = ''
   OR price IS NULL;


✔ Confirmed that no missing or blank values exist.

2. Revalidated Email Format

Ran pattern-matching SQL again to ensure all emails are cleaned:

SELECT * FROM staging_raw
WHERE email NOT LIKE '%@%.%';


✔ All email values now follow correct structure.

3. Reviewed Country Field Consistency

Checked for inconsistent naming (ex: "USA", "United States", "us").

Standardized country names where needed.

4. Rechecked for Duplicate purchase_id
SELECT purchase_id, COUNT(*)
FROM staging_raw
GROUP BY purchase_id
HAVING COUNT(*) > 1;


✔ No duplicates found.

5. Validated Price Values

Confirmed all prices are positive.

Checked for unexpected currency symbols or text.

Ensured prices are numeric.

6. Verified Phone Number Length

Checked for abnormally short or long phone numbers.

Ensured all values meet minimum length (8–15 digits).

7. Completed Final Staging Table Review

Verified all columns are correctly cleaned and ready for transformation.
The dataset is now fully prepared for creation of the production_clean table (Day 4).

📊 Day 3 Output

✅ Objective

Create the final production table and load fully cleaned data from the staging table into it.

📌 Tasks Completed
1. Designed the Final Production Table Schema

Created a new table named production_clean with proper data types and constraints:

CREATE TABLE production_clean (
    purchase_id      INTEGER PRIMARY KEY,
    name             TEXT NOT NULL,
    email            TEXT NOT NULL,
    country          TEXT,
    product          TEXT,
    price            REAL,
    payment_method   TEXT,
    timestamp        TEXT,
    address          TEXT,
    phone            TEXT
);


✔ Added correct data types
✔ Added PRIMARY KEY constraint for purchase_id
✔ Ensured no null values for important fields (name, email)

2. Loaded Clean Data from Staging Table

Copied all validated data from staging_raw into the production table:

INSERT INTO production_clean
SELECT *
FROM staging_raw;


✔ Successfully inserted 200 cleaned rows
✔ No duplicates or invalid records inserted

3. Verified Final Data Load

Executed:

SELECT COUNT(*) FROM production_clean;


Result: 200 rows (expected)

Also checked sample data:

SELECT * FROM production_clean LIMIT 10;
Completely validated and clean staging table

All key data fields verified

Country names standardized

Prices and phone numbers validated
