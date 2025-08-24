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
