# GA4 E-Commerce Funnel Analytics

**BigQuery SQL | GA4 | Funnel Analysis | Customer Journey | Power BI | Digital Analytics**

## Project Overview

This portfolio project analyses Google Analytics 4 (GA4) e-commerce event data from the Google Merchandise Store to identify conversion drop-offs, channel performance, device behaviour, product performance and customer-journey patterns.

The project demonstrates an end-to-end digital analytics workflow:

**GA4 event export → BigQuery SQL → nested/repeated field handling → funnel modelling → customer journey analysis → Power BI dashboard → business recommendations**

## Business Problem

> Where do users drop out of the e-commerce journey, which channels and devices generate the strongest conversion performance, and what actions could improve revenue and purchase completion?

## Planned Funnel

The primary conversion journey will be analysed using GA4 events such as:

`session_start → view_item → add_to_cart → begin_checkout → purchase`

Funnel definitions will be validated against the event names actually present in the sample dataset before final KPIs are reported.

## Business Questions

1. How many users and sessions reach each stage of the purchase funnel?
2. Where are the largest conversion drop-offs?
3. Which source / medium combinations generate the strongest purchase conversion?
4. How does funnel behaviour differ by device category?
5. Which products and categories generate the most revenue and purchases?
6. How do new and returning-user journeys differ?
7. Which user journeys and event sequences most often lead to purchase?
8. How can these findings be communicated through an interactive Power BI dashboard?

## Data Source

**Source:** Google Analytics BigQuery sample dataset  
**Property:** Google Merchandise Store  
**Dataset:** `bigquery-public-data.ga4_obfuscated_sample_ecommerce`  
**Analysis window available in the sample:** 1 November 2020 to 31 January 2021  

The public dataset contains obfuscated GA4 event-export data. Some values are intentionally replaced or limited, so findings will be treated as portfolio analysis rather than production business reporting.

## Skills Demonstrated

### BigQuery SQL
- Wildcard tables and `_TABLE_SUFFIX`
- `UNNEST()` for repeated GA4 records
- Event-parameter extraction
- CTEs
- Conditional aggregation
- Window functions
- User- and session-level analysis
- Funnel conversion calculations
- Traffic-source segmentation
- Device segmentation
- Product-level analysis

### GA4 / Digital Analytics
- Event-based measurement
- Ecommerce event analysis
- Funnel design
- Session and user behaviour
- Acquisition analysis
- Conversion-rate analysis
- Customer-journey interpretation

### Power BI
- Power Query
- Data modelling
- DAX measures
- Funnel visualisation
- Channel and device analysis
- Product performance reporting
- Interactive slicers
- Executive dashboard design

## Planned Analysis Workflow

1. Connect to the public GA4 sample dataset in BigQuery.
2. Profile event volume, users, dates and event names.
3. Inspect nested `event_params` and repeated `items` fields.
4. Build a clean session- and event-level analytical layer using SQL.
5. Define and validate funnel stages.
6. Calculate user and session conversion rates and stage drop-offs.
7. Segment funnel performance by traffic source, medium and device.
8. Analyse purchases, revenue, products and categories.
9. Explore customer journeys using ordered event sequences and window functions.
10. Export curated analysis tables for Power BI.
11. Build an interactive e-commerce funnel dashboard.
12. Summarise commercial insights and optimisation opportunities.

## Repository Structure

```text
ga4-ecommerce-funnel-analytics/
├── README.md
├── .gitignore
├── data/
│   └── README.md
├── sql/
│   ├── README.md
│   └── 01_dataset_profile.sql
├── docs/
│   ├── project_plan.md
│   └── data_dictionary.md
├── dashboard/
│   └── README.md
└── images/
    └── README.md
```

## Project Status

🟡 **In development — repository and analytical plan initialized. BigQuery exploration is the next stage.**

## Author

**Antony Pereira George**  
Dublin, Ireland  
Data Analyst | SQL | Python | Power BI

---

*This project uses Google's public, obfuscated GA4 sample e-commerce dataset and is intended for educational and portfolio purposes.*
