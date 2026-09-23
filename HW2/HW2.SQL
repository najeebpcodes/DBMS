USE coffee_shop_db;

SELECT category, AVG(price) AS average_price
FROM pastries
GROUP BY category;

SELECT experience_level, COUNT(*) AS total_baristas
FROM baristas
GROUP BY experience_level;

SELECT city, COUNT(*) AS total_shops
FROM shops
GROUP BY city;

SELECT category, MAX(price) AS maximum_price
FROM pastries
GROUP BY category;

SELECT shopID, COUNT(*) AS pastries_added
FROM offers
GROUP BY shopID;

SELECT p.name, p.category, p.price
FROM pastries AS p
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM pastries AS p2
    WHERE p2.category = p.category
);

SELECT DISTINCT o.shopID
FROM offers AS o
WHERE o.pastryID IN (
    SELECT p.pastryID
    FROM pastries AS p
    WHERE p.price > (
        SELECT AVG(price)
        FROM pastries
    )
);

SELECT shopID, pastryID
FROM offers
WHERE date_added = (
    SELECT MIN(date_added)
    FROM offers
);

SELECT shopID
FROM offers
GROUP BY shopID
HAVING COUNT(*) = (
    SELECT MAX(pastry_count)
    FROM (
        SELECT COUNT(*) AS pastry_count
        FROM offers
        GROUP BY shopID
    ) AS shop_counts
);

SELECT name
FROM baristas
WHERE baristaID IN (
    SELECT baristaID
    FROM employs
    WHERE shopID IN (
        SELECT shopID
        FROM shops
        WHERE city = 'Seattle'
    )
);

