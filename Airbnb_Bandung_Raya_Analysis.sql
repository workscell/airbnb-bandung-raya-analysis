-- Cek total row
SELECT COUNT (*) AS total_row
FROM "Airbnb";

-- 1. Bagaimana distribusi harga Airbnb di Bandung Raya?
-- Berapa harga rata-rata, termurah, dan termahal?
SELECT ROUND(AVG("Harga"),2) AS average_harga
FROM "Airbnb";

SELECT "Harga" AS harga_termurah
FROM "Airbnb"
ORDER BY "Harga" ASC
LIMIT 1;

SELECT "Harga" AS harga_termahal
FROM "Airbnb"
ORDER BY "Harga" DESC
LIMIT 1;

-- Apakah terdapat listing dengan harga yang sangat tinggi dibandingkan lainnya?
SELECT "Listing_ID", "Nama", SUM ("Harga") AS total_harga
FROM "Airbnb"
GROUP BY "Listing_ID", "Nama"
HAVING SUM ("Harga") > (SELECT
ROUND(AVG("Harga"),2)
FROM "Airbnb");

-- 2. Wilayah mana yang memiliki rata-rata harga Airbnb tertinggi dan terendah?
-- Bagaimana perbandingan harga rata-rata antarwilayah?
SELECT "Wilayah", ROUND(AVG("Harga"),2) AS average_harga
FROM "Airbnb"
GROUP BY "Wilayah";

-- Wilayah mana yang relatif lebih terjangkau?
SELECT "Wilayah", ROUND(AVG("Harga"),2) AS average_harga
FROM "Airbnb"
GROUP BY "Wilayah"
ORDER BY ROUND(AVG("Harga"),2) ASC
LIMIT 1;

-- Wilayah mana yang memiliki harga paling tinggi?
SELECT "Wilayah", ROUND(AVG("Harga"),2) AS average_harga
FROM "Airbnb"
GROUP BY "Wilayah"
ORDER BY ROUND(AVG("Harga"),2) DESC
LIMIT 1;

-- 3. Bagaimana distribusi rating Airbnb di Bandung Raya?
-- Berapa rata-rata rating seluruh listing yang memiliki rating?
SELECT ROUND(AVG("Rating"),2) AS average_rating
FROM "Airbnb";

-- Berapa banyak listing dengan rating tinggi?
WITH listing_rating AS (
SELECT "Listing_ID", "Rating", CASE
WHEN "Rating" > 3 THEN 'tinggi'
WHEN "Rating" < 3 THEN 'rendah'
WHEN "Rating" = 3 THEN 'sedang'
END AS status_rating
FROM "Airbnb")

SELECT COUNT ("Listing_ID") AS total_listing_rating_tinggi
FROM listing_rating
WHERE status_rating = 'tinggi';


-- Bagaimana persebaran rating antarwilayah?
SELECT "Wilayah", ROUND(AVG("Rating"),2) AS average_rating
FROM "Airbnb"
GROUP BY "Wilayah";

-- 4. Listing Airbnb mana yang memiliki jumlah review terbanyak?
-- Apa saja listing dengan jumlah review tertinggi?
SELECT "Listing_ID", "Nama", "Jumlah_review"
FROM "Airbnb"
ORDER BY "Jumlah_review" DESC
LIMIT 10;

-- Bagaimana distribusi jumlah review?
SELECT "Wilayah", SUM ("Jumlah_review") AS total_review
FROM "Airbnb"
GROUP BY "Wilayah"
ORDER BY SUM ("Jumlah_review") DESC;

-- Apakah listing dengan banyak review juga memiliki rating tinggi?
SELECT "Listing_ID", SUM ("Jumlah_review") AS total_review, ROUND(AVG("Rating"),2) AS average_rating
FROM "Airbnb"
GROUP BY "Listing_ID"
ORDER BY SUM ("Jumlah_review") DESC
LIMIT 10;

-- 5. Apakah harga Airbnb berkaitan dengan rating dan jumlah review?
-- Apakah listing dengan harga tinggi memiliki rating lebih tinggi?
SELECT "Listing_ID", SUM ("Harga") AS total_harga, ROUND(AVG("Rating"),2) AS average_rating
FROM "Airbnb"
GROUP BY "Listing_ID"
ORDER BY SUM ("Harga") DESC
LIMIT 10;

-- Apakah listing dengan banyak review cenderung memiliki rating lebih baik?
SELECT "Listing_ID", SUM ("Jumlah_review") AS total_review, ROUND(AVG("Rating"),2) AS average_rating
FROM "Airbnb"
GROUP BY "Listing_ID"
ORDER BY SUM ("Jumlah_review") DESC;

SELECT "Listing_ID", SUM ("Jumlah_review") AS total_review, ROUND(AVG("Rating"),2) AS average_rating
FROM "Airbnb"
GROUP BY "Listing_ID"
ORDER BY SUM ("Jumlah_review") ASC;

-- Apakah ada pola hubungan antara harga dan popularitas listing?
SELECT "Harga", COUNT ("Listing_ID") AS total_listing
FROM "Airbnb"
GROUP BY "Harga"
ORDER BY COUNT ("Listing_ID") DESC;

-- 6. Wilayah mana yang memiliki jumlah listing Airbnb terbanyak?
-- Wilayah mana yang memiliki konsentrasi listing tertinggi?
SELECT "Wilayah", Count ("Listing_ID") AS total_listing
FROM "Airbnb"
GROUP BY "Wilayah"
ORDER BY COUNT ("Listing_ID") DESC
LIMIT 1;

-- Bagaimana perbandingan jumlah listing dengan rata-rata harganya?
SELECT COUNT ("Listing_ID") AS jumlah_listing, ROUND(AVG("Harga"),2) AS average_harga
FROM "Airbnb";
