# 1.**Project Title**

Laptop Market Analysis Using Excel, SQL, and Power BI

<img width="1500" height="1000" alt="image" src="https://github.com/user-attachments/assets/2df48815-13e4-4b7c-839d-7dde5f335f69" />



# 2. **Objective**

The goal of this project is to analyze a laptops dataset to understand market trends, pricing patterns, product specifications, and brand competitiveness. This analysis helps identify the most demanded laptops, price variations, and key features that influence customer decisions.

# 3. **Tools and Technologies Used**
   
Tool	Purpose
Microsoft Excel      :-    	Data cleaning and preprocessing
PostgreSQL	         :-     SQL-based data analysis
Power BI             :-     Data visualization and dashboard creation

#4. **Dataset Description**

Dataset Name: Laptop Market Dataset

Columns Used:

Company – Laptop brand

Product – Model name

TypeName – Type of laptop (Gaming, Ultrabook, Notebook, etc.)

Inches – Screen size

Ram – RAM size

OS – Operating system

Weight – Weight of the laptop

Price_Euros – Price in Euros


# 5. **Data Cleaning Process (Excel)**

Before importing the dataset into PostgreSQL, the following steps were done in Excel:

1. Removed duplicate laptop entries.

2. Filled missing OS or TypeName values with “Unknown”.

3. Standardized text (trim spaces, proper case for brands).

4. Converted Inches, RAM, and Price into numeric format.

5. Fixed inconsistent units (example: removed “kg” from weight).

6. Verified correct date types and ensured formatting consistency.

7. Checked for outliers (extremely high or low prices).

# 6. **Data Analysis Using PostgreSQL**

-- **Step 1 Creating table** 

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

-- **step 2 import data**

    select * from laptops;

-- **step 3 Busisness problems** 

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

-- **step 4 solution**

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

# 7. **Key Findings Summary**

1. Gaming laptops and Ultrabooks are the most expensive categories.

2. Intel dominates the CPU market, while NVIDIA leads in gaming GPUs.

3. Higher RAM and IPS displays significantly increase laptop prices.

4. SSDs are the most common storage type, replacing HDDs.

5. Larger screen sizes (especially 15.6") tend to have higher average prices.

6. The lightest high-performance laptops are mostly premium ultrabooks.

# 8. **Conclusion**

This analysis shows how laptop prices and performance are strongly influenced by key features such as RAM, CPU power, GPU type, screen quality, and storage. Premium categories like Gaming laptops and Ultrabooks cost the highest due to advanced specifications. Intel and NVIDIA dominate the market in their respective segments, while SSDs and larger screens have become standard trends. Overall, this project highlights clear pricing patterns, performance trends, and market preferences, helping users and businesses make better decisions based on laptop specifications and value.




























