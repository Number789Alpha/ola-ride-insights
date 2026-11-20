-- ====================================================================
-- OLA RIDE INSIGHTS - SQL QUERIES & BUSINESS INTELLIGENCE SCRIPT
-- Database: SQLite / MySQL / PostgreSQL Compatible
-- Table: ola_bookings
-- Dataset: July 2024 (103,024 Records)
-- ====================================================================

-- --------------------------------------------------------------------
-- 1. Retrieve all successful bookings
-- Business Context: Identifies revenue-generating trips completed without cancellation or abort.
-- Result: 63,967 records
-- --------------------------------------------------------------------
SELECT 
    Booking_ID,
    Date,
    Time,
    Customer_ID,
    Vehicle_Type,
    Pickup_Location,
    Drop_Location,
    Booking_Value,
    Payment_Method,
    Ride_Distance
FROM ola_bookings
WHERE Booking_Status = 'Success';


-- --------------------------------------------------------------------
-- 2. Find the average ride distance for each vehicle type
-- Business Context: Determines fleet trip characteristics and micro-mobility vs sedan range.
-- --------------------------------------------------------------------
SELECT 
    Vehicle_Type,
    ROUND(AVG(Ride_Distance), 2) AS Avg_Distance_KM,
    ROUND(MIN(Ride_Distance), 2) AS Min_Distance_KM,
    ROUND(MAX(Ride_Distance), 2) AS Max_Distance_KM,
    COUNT(Booking_ID) AS Total_Trips
FROM ola_bookings
GROUP BY Vehicle_Type
ORDER BY Avg_Distance_KM DESC;


-- --------------------------------------------------------------------
-- 3. Get the total number of cancelled rides by customers
-- Business Context: Measures consumer drop-off attrition and rider wait dissatisfaction.
-- Result: 10,499 records
-- --------------------------------------------------------------------
SELECT 
    COUNT(Booking_ID) AS Total_Cancelled_By_Customer,
    ROUND(COUNT(Booking_ID) * 100.0 / (SELECT COUNT(*) FROM ola_bookings), 2) AS Customer_Cancel_Percentage
FROM ola_bookings
WHERE Booking_Status = 'Canceled by Customer';


-- --------------------------------------------------------------------
-- 4. List the top 5 customers who booked the highest number of rides
-- Business Context: Highlights top-tier frequent riders for loyalty rewards and VIP prioritization.
-- --------------------------------------------------------------------
SELECT 
    Customer_ID,
    COUNT(Booking_ID) AS Total_Rides_Booked,
    SUM(CASE WHEN Booking_Status = 'Success' THEN 1 ELSE 0 END) AS Successful_Rides,
    SUM(Booking_Value) AS Total_Booking_Value
FROM ola_bookings
GROUP BY Customer_ID
ORDER BY Total_Rides_Booked DESC, Total_Booking_Value DESC
LIMIT 5;


-- --------------------------------------------------------------------
-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues
-- Business Context: Diagnoses driver-side friction from mechanical breakdown or personal constraints.
-- Result: 6,542 records
-- --------------------------------------------------------------------
SELECT 
    COUNT(Booking_ID) AS Rides_Cancelled_Personal_Car_Issue,
    ROUND(COUNT(Booking_ID) * 100.0 / (SELECT COUNT(*) FROM ola_bookings WHERE Booking_Status = 'Canceled by Driver'), 2) AS Pct_Of_Driver_Cancellations
FROM ola_bookings
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';


-- --------------------------------------------------------------------
-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings
-- Business Context: Evaluates driver quality variance in the premium sedan service tier.
-- Result: Max = 5.0, Min = 3.0, Avg = 3.99
-- --------------------------------------------------------------------
SELECT 
    MAX(Driver_Ratings) AS Max_Driver_Rating,
    MIN(Driver_Ratings) AS Min_Driver_Rating,
    ROUND(AVG(Driver_Ratings), 2) AS Avg_Driver_Rating
FROM ola_bookings
WHERE Vehicle_Type = 'Prime Sedan'
  AND Driver_Ratings IS NOT NULL;


-- --------------------------------------------------------------------
-- 7. Retrieve all rides where payment was made using UPI
-- Business Context: Analyzes adoption of instant digital payments vs cash transactions.
-- Result: 25,881 records
-- --------------------------------------------------------------------
SELECT 
    Booking_ID,
    Date,
    Customer_ID,
    Vehicle_Type,
    Booking_Value,
    Ride_Distance
FROM ola_bookings
WHERE Payment_Method = 'UPI';


-- --------------------------------------------------------------------
-- 8. Find the average customer rating per vehicle type
-- Business Context: Compares passenger satisfaction across vehicle categories.
-- --------------------------------------------------------------------
SELECT 
    Vehicle_Type,
    ROUND(AVG(Customer_Rating), 3) AS Avg_Customer_Rating,
    ROUND(AVG(Driver_Ratings), 3) AS Avg_Driver_Rating,
    COUNT(Customer_Rating) AS Rated_Trips_Count
FROM ola_bookings
WHERE Customer_Rating IS NOT NULL
GROUP BY Vehicle_Type
ORDER BY Avg_Customer_Rating DESC;


-- --------------------------------------------------------------------
-- 9. Calculate the total booking value of rides completed successfully
-- Business Context: Quantifies net gross merchandise value (GMV) realized by the business.
-- Result: INR 35,080,467.00
-- --------------------------------------------------------------------
SELECT 
    SUM(Booking_Value) AS Total_Successful_Booking_Value_INR,
    COUNT(Booking_ID) AS Successful_Ride_Count,
    ROUND(AVG(Booking_Value), 2) AS Avg_Booking_Value_INR
FROM ola_bookings
WHERE Booking_Status = 'Success';


-- --------------------------------------------------------------------
-- 10. List all incomplete rides along with the reason
-- Business Context: Uncovers mid-trip termination causes (breakdowns, passenger emergencies).
-- Result: 3,926 records
-- --------------------------------------------------------------------
SELECT 
    Booking_ID,
    Date,
    Customer_ID,
    Vehicle_Type,
    Pickup_Location,
    Drop_Location,
    Incomplete_Rides_Reason
FROM ola_bookings
WHERE Incomplete_Rides = 'Yes'
ORDER BY Date DESC;

