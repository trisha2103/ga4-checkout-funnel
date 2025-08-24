# 🛒 Checkout Funnel — GA4 (BigQuery) + Looker Studio

[![Live Report](https://img.shields.io/badge/Live%20Report-Looker%20Studio-1f6feb?logo=google-chrome&logoColor=white)](https://lookerstudio.google.com/reporting/dc5072db-18ea-4e20-aa4c-587f41eb920d)
![BigQuery](https://img.shields.io/badge/BigQuery-SQL-blue?logo=googlecloud)
![GA4](https://img.shields.io/badge/Google%20Analytics%204-data-orange?logo=google-analytics)
![Made with](https://img.shields.io/badge/Visualization-Looker%20Studio-8A2BE2)
![License](https://img.shields.io/badge/License-MIT-green)

Analyze how users move from **view → add_to_cart → checkout → shipping → payment → purchase**, size the drop-offs, and show revenue impact with clean visuals.

---

## ✨ TL;DR Highlights
- **End-to-end conversion:** **X%**  
- **Mobile vs Desktop gap:** **Y percentage points**  
- **Revenue:** **$R** · **Orders:** **N** · **AOV:** **$Z**  
- **Biggest drop-off:** **<step>** → *top fixes below*  
> Fill these with your numbers after running the views.

---

## 🔎 Problem → 💡 Solution → 📈 Impact

**Problem.** Where are we losing users in checkout, and how much money is left on the table?

**Solution.** Build a session-level funnel in **BigQuery** from the GA4 public ecommerce dataset, and visualize **conversion**, **step drop-offs**, **device/channel splits**, and **revenue/AOV** in **Looker Studio**.

**Impact.** Prioritize experiments on the worst step (especially on **mobile**).  

A quick sizing:
added_orders = sessions_with_checkout × absolute_lift
added_revenue = added_orders × AOV

Example: 10,000 checkout sessions, +5 pp lift, AOV $80 ⇒ **+$40,000**.

---

## 🗺️ Screens

> Click an image to open the live report.

<a href="https://lookerstudio.google.com/reporting/dc5072db-18ea-4e20-aa4c-587f41eb920d">
  <img src="dashboard/Page 1.png" alt="Checkout Funnel – Daily Trends" width="100%">
</a>

<a href="https://lookerstudio.google.com/reporting/dc5072db-18ea-4e20-aa4c-587f41eb920d">
  <img src="dashboard/Page 2.png" alt="Revenue & AOV Overview" width="100%">
</a>

---

## 🧰 Data & Tools
- **Dataset:** `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
- **My views (US region):**
  - `ga4-lab-469920.ga4_lab.ga4_base_events`
  - `ga4-lab-469920.ga4_lab.ga4_session_funnel`
  - `ga4-lab-469920.ga4_lab.ga4_daily_revenue`
- **Viz:** Looker Studio 
---

## ⚙️ How it works (3 steps)

1. **Model the funnel in BigQuery**  
   - `ga4_base_events`: extracts GA4 events and keys (session_id, device, medium)  
   - `ga4_session_funnel`: 1 row per session with timestamps for each funnel step  
   - `ga4_daily_revenue`: orders & revenue from `purchase` items

2. **Create reusable fields in Looker Studio** (Number, **SUM**):  
   - `Sessions = 1`  
   - `CartReached = CASE WHEN t_add_to_cart    IS NULL THEN 0 ELSE 1 END`  
   - `CheckoutReached = CASE WHEN t_begin_checkout IS NULL THEN 0 ELSE 1 END`  
   - `Purchased = CASE WHEN t_purchase        IS NULL THEN 0 ELSE 1 END`  
   - Optional: `MediumFilled = IFNULL(medium, "(none)")` (Text)

3. **Build charts**
   - **Time series:** Sessions, Purchased, **Conversion % = SUM(Purchased)/SUM(Sessions)**  
   - **Stacked bars by day:** CartReached, CheckoutReached, Purchased  
   - **Bars:** by `device_category` and `MediumFilled` (add Conversion % as a metric)  
   - **Scorecards (from daily revenue):** Revenue (SUM), Orders (SUM), **AOV = SUM(revenue)/SUM(orders)**

---

## 🧪 What I’d test next (experiment backlog)
1. **Mobile checkout simplification** — Guest checkout by default + Apple/Google Pay  
2. **Show shipping cost in cart** — reduce surprise later  
3. **Hide coupon box behind “Have a code?”** — fewer discount hunts  
4. **Sticky Add-to-Cart on PDP (mobile)** — easier CTA access  
5. **Inline field validation** — fewer failed submissions

> **Primary KPI:** checkout→purchase or session→purchase; **Guardrails:** AOV, latency.

---

## 📊 Metric glossary

| Metric | Definition |
|---|---|
| **Sessions** | One row in `ga4_session_funnel` (session-level) |
| **Cart rate** | `SUM(CartReached) / SUM(Sessions)` |
| **Checkout rate** | `SUM(CheckoutReached) / SUM(CartReached)` |
| **Purchase rate** | `SUM(Purchased) / SUM(CheckoutReached)` |
| **End-to-end conversion** | `SUM(Purchased) / SUM(Sessions)` |
| **Orders** | Count of transactions from `ga4_daily_revenue` |
| **Revenue** | Sum of item price × quantity for `purchase` |
| **AOV** | `SUM(revenue) / SUM(orders)` |

---

## 🏃 Quickstart (reproduce)

```text
1) BigQuery (US):
   - Run /sql/ga4_base_events.sql
   - Run /sql/ga4_session_funnel.sql
   - Run /sql/ga4_daily_revenue.sql

2) Looker Studio:
   - Connect to ga4_session_funnel + ga4_daily_revenue
   - Add the 4 calculated fields above (SUM)
   - Build charts; add Date, Device, Medium controls
   - Share → Anyone with the link (Viewer)



## 📂 Repo structure
.
├─ sql/
│  ├─ ga4_base_events.sql
│  ├─ ga4_session_funnel.sql
│  └─ ga4_daily_revenue.sql
├─ dashboard/
│  ├─ Page 1.png
│  └─ Page 2.png
└─ README.md
