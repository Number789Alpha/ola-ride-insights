# 🚖 OLA Ride Insights — Enterprise Mobility Analytics & Business Intelligence Platform

[![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge&logo=streamlit&logoColor=white)](https://streamlit.io/)
[![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![SQLite](https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](https://www.sqlite.org/)
[![Plotly](https://img.shields.io/badge/Plotly-3F4F75?style=for-the-badge&logo=plotly&logoColor=white)](https://plotly.com/)
[![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org/)

---

## 📌 Executive Overview

The rise of on-demand ride-hailing networks has transformed urban transit economics, offering rapid accessibility to millions of city commuters. **OLA**, India's leading ride-hailing mobility service, generates high-velocity data points across booking intakes, driver allocations, surge tariffs, cancellations, and ratings. 

Deriving actionable unit-economic visibility from this volume requires full-stack data modeling. This project presents an **end-to-end analytics platform** analyzing **103,024 ride booking records from July 2024**, comprising:
1. **Automated ETL & Preprocessing**: Handling operational nulls, formatting datetime features, calculating fulfillment rates, and compiling an ultra-fast normalized SQLite database (`ola_rides.db`).
2. **Production SQL Analytical Suite (`ola_queries.sql`)**: 10 optimized queries answering core operational, fulfillment, cancellation, and rating questions.
3. **Power BI Dashboard (`OLA.pbix`)**: Multi-page corporate visual report analyzing overall performance, vehicle tier efficiency, revenue realization, cancellation reasons, and two-way rating sentiment.
4. **Interactive Streamlit Web Dashboard (`app.py`)**: Company-level web dashboard incorporating OLA's brand design, page-level **About sections**, dynamic slicers, interactive Plotly visualizations, **detailed Below-Graph explanations**, and an embedded **SQL Query Studio**.

---

## 🏗️ Technical Architecture & Pipeline

```
├── 📁 assets/               # Extracted vehicle icons, navigation badges & OLA brand assets
├── 📄 app.py                # Main company-level Streamlit web dashboard
├── 📊 OLA.pbix              # Complete 5-page Power BI Dashboard file
├── 📑 OLA_DataSet.xlsx      # Master raw operational dataset (July 2024, 103,024 rows)
├── 🗄️ ola_rides.db          # Embedded high-performance SQLite relational database
├── 📄 ola_rides.csv         # Cleaned, standardized CSV cache for sub-second loading
├── 📜 ola_queries.sql       # 10 production SQL queries with business insights & comments
├── 📋 requirements.txt      # Python dependencies
└── 📖 README.md             # Project documentation & execution guide
```

---

## 🔍 SQL Business Intelligence Solutions

The database (`ola_bookings` table) captures **103,024 rides** across Bangalore operating zones. Below are the 10 benchmark SQL queries implemented and verified:

| # | Business Question | SQL Logic Highlights | Key Operational Benchmark |
|---|---|---|---|
| **1** | **Retrieve all successful bookings** | `WHERE Booking_Status = 'Success'` | **63,967 completed rides** (**62.09% conversion rate**). |
| **2** | **Average ride distance by vehicle type** | `GROUP BY Vehicle_Type, AVG(Ride_Distance)` | **Prime Sedan** leads (15.76 KM); **Auto** serves micro-transit (6.24 KM). |
| **3** | **Total cancelled rides by customers** | `WHERE Booking_Status = 'Canceled by Customer'` | **10,499 bookings (10.19%)** dropped off by riders. |
| **4** | **Top 5 customers by ride volume** | `GROUP BY Customer_ID ORDER BY COUNT(*) DESC LIMIT 5` | Customer `CID954071` booked 5 rides; 4 riders tied with 4 trips. |
| **5** | **Driver cancellations (Personal & Car issues)** | `WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue'` | **6,542 rides**; accounts for **35.49%** of driver cancellations. |
| **6** | **Min/Max driver ratings for Prime Sedan** | `WHERE Vehicle_Type = 'Prime Sedan'` | **Max: 5.0**, **Min: 3.0**, **Average: 3.99 / 5.0**. |
| **7** | **Retrieve all UPI payment rides** | `WHERE Payment_Method = 'UPI'` | **25,881 rides (40.46%)** transacted cashless via UPI (₹14.20M). |
| **8** | **Average customer rating per vehicle type** | `GROUP BY Vehicle_Type, AVG(Customer_Rating)` | **Prime Plus** leads (4.009); all tiers stay between 3.988 - 4.009. |
| **9** | **Total booking value of successful rides** | `SUM(Booking_Value) WHERE Booking_Status = 'Success'` | **₹35,080,467.00 (₹35.08M)** net realized revenue. |
| **10** | **Incomplete rides with stated reasons** | `WHERE Incomplete_Rides = 'Yes'` | **3,926 rides (3.81%)**: Customer Demand (1,601), Breakdown (1,591), Other (734). |

---

## 📊 Streamlit & Power BI Segregated Views

### 1. 01 - Overall Performance
* **About Section**: Macro-level operational diagnostic measuring booking volume, GMV, and status conversion rates.
* **Visuals**: Ride Volume Over Time, Booking Status Breakdown, Hourly Time-Slot Friction, Vehicle Category Distribution.
* **Key Takeaway**: Baseline conversion hovers at 62.1%. Driver cancellations (17.9%) nearly double customer cancellations (10.2%).

### 2. 02 - Vehicle Analysis
* **About Section**: Dissects fleet performance across Auto, Bike, eBike, Mini, Prime Sedan, Prime SUV, and Prime Plus.
* **Visuals**: Top 5 Vehicle Types by Cumulative Distance, Total Requested vs Realized Booking Value, 100% Outcome Parity Stack.
* **Key Takeaway**: Prime Sedan covers the highest mileage (234.5k KM). Cancellation rates stay tightly clustered (17.6% - 18.1%) across all vehicle classes.

### 3. 03 - Revenue Analysis
* **About Section**: Financial monetization channels, payment gateway distribution, and high-frequency patron accounts.
* **Visuals**: Revenue by Payment Method, Top 5 Customers by Booking Value, Daily Revenue & Distance Alignment.
* **Key Takeaway**: Cash generates ₹19.23M (54.8%) while UPI delivers ₹14.20M (40.5%). Top customers spent ₹2,200 - ₹2,600+ across 4-5 premium rides.

### 4. 04 - Cancellation Analysis
* **About Section**: Root-cause diagnostics on booking drop-offs, driver rejections, and mid-trip aborts.
* **Visuals**: Customer Cancellation Reasons, Driver Cancellation Reasons, Incomplete Rides Breakdown.
* **Key Takeaway**: 55.6% of customer cancellations are driven by stationary drivers (3,175) or drivers soliciting cancellation (2,670). Driver cancellations are led by personal/car issues (6,542).

### 5. 05 - Ratings Analysis
* **About Section**: Evaluates mutual customer-driver satisfaction, score distributions, and vehicle tier sentiment parity.
* **Visuals**: Driver Ratings Distribution, Customer Ratings Distribution, Cross-Category Rating Comparison.
* **Key Takeaway**: Remarkable statistical symmetry with identical 3.998 averages for both drivers and riders.

### 6. ⚡ Interactive SQL Query Studio
* **Capabilities**: Execute any of the 10 core SQL questions live, inspect query execution time in milliseconds, and run custom queries in an interactive SQL terminal.

---

## 🚀 Installation & Local Execution

### 1. Clone the Repository
```bash
git clone https://github.com/Number789Alpha/ola-ride-insights.git
cd ola-ride-insights
```

### 2. Create and Activate Virtual Environment
```bash
python -m venv venv
# On Windows
venv\Scripts\activate
# On macOS/Linux
source venv/bin/activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Launch the Streamlit Dashboard
```bash
streamlit run app.py
```
Open **`http://localhost:8501`** in your browser.

---

## 💡 Strategic Recommendations for OLA Leadership

1. **Automated Driver Reassignment**: Trigger auto-reassignment if driver GPS speed is zero for >3 minutes to eliminate ~5,800 monthly cancellations.
2. **UPI Digital Conversion Incentives**: Offering 2% cashback or Ola Money wallet credits can migrate 15-20% of high-friction cash rides into digital settlement.
3. **Vehicle Breakdown Quick-Response**: Deploying nearby rescue vehicles and providing automated un-traveled distance refunds recovers rider NPS for the 1,591 monthly breakdowns.
4. **Driver Congestion Bonuses**: Dynamic evening bonuses (5 PM - 8 PM) incentivize driver acceptance in congested zones, mitigating the 10,124 "Driver Not Found" supply shortfalls.

---

## 👤 Author

**Priyank Mishra**  
*Aspiring Data Analyst | Python • SQL • Pandas • Streamlit • Power BI*  
* GitHub: [@Number789Alpha](https://github.com/Number789Alpha)
