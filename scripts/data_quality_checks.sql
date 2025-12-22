
-- 1. Check for NULL values in critical columns
SELECT *
FROM production_clean
WHERE purchase_id IS NULL
   OR name IS NULL
   OR email IS NULL
   OR price IS NULL
   OR timestamp IS NULL;

-- Expected result: 0 rows


-- 2. Check for duplicate purchase_id
SELECT purchase_id, COUNT(*) AS duplicate_count
FROM production_clean
GROUP BY purchase_id
HAVING COUNT(*) > 1;

-- Expected result: 0 rows


-- 3. Validate email format
SELECT *
FROM production_clean
WHERE email NOT LIKE '%@%.%';

-- Expected result: 0 rows


-- 4. Validate price values (no zero or negative)
SELECT *
FROM production_clean
WHERE price <= 0;

-- Expected result: 0 rows


-- 5. Validate timestamp format
SELECT *
FROM production_clean
WHERE datetime(timestamp) IS NULL;

-- Expected result: 0 rows


-- 6. Row count validation between staging and production
SELECT
    (SELECT COUNT(*) FROM staging_raw) AS staging_count,
    (SELECT COUNT(*) FROM production_clean) AS production_count;

-- Expected result: counts should match


-- 7. Phone number length validation
SELECT *
FROM production_clean
WHERE LENGTH(phone) < 8
   OR LENGTH(phone) > 15;

-- Expected result: 0 rows