-- Laptop Price Analysis 

drop table laptops
-- Step 1 Creating table 

CREATE TABLE laptops (
    Company VARCHAR(50),
    Product VARCHAR(100),
    TypeName VARCHAR(50),
    Inches DECIMAL(4,1),
    Ram VARCHAR(10),
    OS VARCHAR(50),
    Weight VARCHAR(20),
    Price_euros DECIMAL(10,2),

    Screen VARCHAR(50),
    ScreenW INT,
    ScreenH INT,
    Touchscreen BOOLEAN,
    IPSpanel BOOLEAN,
    RetinaDisplay BOOLEAN,

    CPU_company VARCHAR(50),
    CPU_freq VARCHAR(20),
    CPU_model VARCHAR(100),

    PrimaryStorage INT,
    SecondaryStorage INT,
    PrimaryStorageType VARCHAR(20),
    SecondaryStorageType VARCHAR(20),

    GPU_company VARCHAR(50),
    GPU_model VARCHAR(100)
);

--step 2 import data 
select * from laptops;

--step 3 Busisness problems 

--1. Find the average laptop price for each company
--2. Identify which laptop type (TypeName: Ultrabook, Gaming, etc.) has the highest average price
--3. Find the top 10 most expensive laptops and their key specifications
--4. Determine how RAM size affects laptop prices
--5. Compare the average price of laptops with IPS panel vs non-IPS panel
--6. Find the count of touchscreen vs non-touchscreen laptops
--7. Analyze which CPU company (Intel/AMD) dominates the market
--8. Rank laptops based on CPU frequency and price to find the top performance laptops
--9. Find the most common primary storage type (SSD/HDD)
--10. Determine average price by screen size category (e.g., 13”, 14”, 15.6”)
--11. Find which GPU company (NVIDIA/AMD/Intel) is used most in gaming laptops
--12. Identify the lightest laptops (Weight) with the highest specs (RAM + CPU + GPU)

--step 4 solution

--1. Find the average laptop price for each company
	select company , round (avg(price_euros),2) as avg_price from laptops 
	group by company
	order by avg_price desc

--2. Identify which laptop type (TypeName: Ultrabook, Gaming, etc.) has the highest average price
	select typename,round (avg(price_euros),2)as avg_price from laptops 
	group by typename 
	order by avg_price desc 

--3. Find the top 10 most expensive laptops and their key specifications
	SELECT Company, Product, Price_euros, CPU_model, Ram, GPU_model
	FROM laptops
	ORDER BY Price_euros DESC
	LIMIT 10;

--4. Determine how RAM size affects laptop prices
	select Ram , round (avg(price_euros),2) as avg_price from laptops 
	group by Ram 
	order by Ram;

--5. Compare the average price of laptops with IPS panel vs non-IPS panel
	SELECT IPSpanel, Round (AVG(Price_euros),2) AS avg_price
	FROM laptops
	GROUP BY IPSpanel;

--6. Find the count of touchscreen vs non-touchscreen laptops
	select touchscreen,count(*)as total from laptops
	group by touchscreen ;
	
--7. Analyze which CPU company (Intel/AMD) dominates the market
	select cpu_company , count(*) as total_laptops from  laptops
	group by cpu_company
	order by total_laptops desc;

--8. Rank laptops based on CPU frequency and price to find the top performance laptops
	select  
		company,
		product,
		cpu_freq,
		price_euros,
		rank() over (order by cpu_freq desc ,price_euros desc )as performance_rank
		from laptops ;
		
--9. Find the most common primary storage type (SSD/HDD)
	select primarystoragetype,count(*) as total from laptops
	group by primarystoragetype 
	order by total desc;
	
--10. Determine average price by screen size category (e.g., 13”, 14”, 15.6”)
		select inches , round (avg(price_euros),2) as avg_price  from laptops 
		group by inches 
		order by inches asc;

--11. Find which GPU company (NVIDIA/AMD/Intel) is used most in gaming laptops
	 select gpu_company , count(*) as total from laptops 
	 where typename = 'Gaming'
	 group by gpu_company 
	 order by total desc;
	 
--12. Identify the lightest laptops (Weight) with the highest specs (RAM + CPU + GPU)
		SELECT 
		    Company,
		    Product,
		    Weight,
		    Ram,
		    CPU_model,
		    GPU_model,
		    Price_euros
		FROM laptops
		ORDER BY Weight ASC, Ram DESC, Price_euros DESC
		LIMIT 10;














