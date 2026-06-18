DROP DATABASE IF EXISTS hotel_booking;
CREATE DATABASE hotel_booking;
USE hotel_booking;

-- 1. Total number of bookings
SELECT COUNT(*) FROM hotel_bookings;

-- 2. Total cancellations vs. non-cancellations
SELECT is_canceled, COUNT(*) 
FROM hotel_bookings 
GROUP BY is_canceled;

-- 3. Bookings split by hotel type (City vs Resort)
SELECT hotel, COUNT(*) 
FROM hotel_bookings 
GROUP BY hotel;

-- 4. Average Daily Rate (ADR) by hotel type
SELECT hotel, AVG(adr) 
FROM hotel_bookings 
GROUP BY hotel;

-- 5. ADR by year
SELECT arrival_date_year, AVG(adr) 
FROM hotel_bookings 
GROUP BY arrival_date_year;

-- 6. Revenue lost due to cancellations
SELECT SUM(adr*(stays_in_weekend_nights+stays_in_week_nights)) AS lost_revenue
FROM hotel_bookings 
WHERE is_canceled=1;

-- 7. Bookings by month
SELECT arrival_date_month, COUNT(*) 
FROM hotel_bookings 
GROUP BY arrival_date_month;

-- 8. Cancellations by month
SELECT arrival_date_month, SUM(is_canceled) 
FROM hotel_bookings 
GROUP BY arrival_date_month;

-- 9. Average lead time by month
SELECT arrival_date_month, AVG(lead_time) 
FROM hotel_bookings 
GROUP BY arrival_date_month;

-- 10. Average stay length (weekend + week nights)
SELECT AVG(stays_in_weekend_nights+stays_in_week_nights) AS avg_stay 
FROM hotel_bookings;

-- 11. Distribution of customer types
SELECT customer_type, COUNT(*) 
FROM hotel_bookings 
GROUP BY customer_type;

-- 12. Top 10 countries by bookings
SELECT country, COUNT(*) 
FROM hotel_bookings 
GROUP BY country 
ORDER BY COUNT(*) DESC 
LIMIT 10;

-- 13. Cancellation % by deposit type
SELECT deposit_type, AVG(is_canceled)*100 AS cancel_rate 
FROM hotel_bookings 
GROUP BY deposit_type;

-- 14. Cancellation % by distribution channel
SELECT distribution_channel, AVG(is_canceled)*100 AS cancel_rate 
FROM hotel_bookings 
GROUP BY distribution_channel;

-- 15. Cancellation % by customer type
SELECT customer_type, AVG(is_canceled)*100 AS cancel_rate 
FROM hotel_bookings 
GROUP BY customer_type;

-- 16. Reserved vs. assigned room type mismatch count
SELECT COUNT(*) 
FROM hotel_bookings 
WHERE reserved_room_type <> assigned_room_type;

-- 17. Average ADR by reserved room type
SELECT reserved_room_type, AVG(adr) 
FROM hotel_bookings 
GROUP BY reserved_room_type;

-- 18. Bookings with children vs. without
SELECT SUM(children+babies) AS with_kids, 
       COUNT(*)-SUM(children+babies) AS without_kids 
FROM hotel_bookings;

-- 19. Repeat vs. new guests
SELECT is_repeated_guest, COUNT(*) 
FROM hotel_bookings 
GROUP BY is_repeated_guest;

-- 20. Average lead time for canceled vs. non-canceled bookings
SELECT is_canceled, AVG(lead_time) 
FROM hotel_bookings 
GROUP BY is_canceled;


