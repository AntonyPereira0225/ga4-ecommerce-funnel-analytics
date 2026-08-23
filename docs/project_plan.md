# Project Plan

## Objective

Build an end-to-end e-commerce analytics portfolio project using GA4 event-export data, BigQuery SQL and Power BI.

## Analytical Stages

### 1. Dataset validation
- Confirm event volume, users and date coverage.
- List available event names.
- Validate the ecommerce funnel events present in the sample.

### 2. GA4 schema exploration
- Inspect nested `event_params` records.
- Extract session identifiers where available.
- Inspect traffic-source, device and geographic fields.
- Inspect repeated `items` records for ecommerce events.

### 3. Funnel modelling
- Build user-level and session-level funnel metrics.
- Calculate stage-to-stage conversion and drop-off.
- Validate purchase completion metrics.

### 4. Segmentation
- Traffic source / medium.
- Device category.
- New vs returning behaviour where supported by the data.
- Date / weekday patterns.

### 5. Commercial analysis
- Purchase events.
- Revenue and transaction performance.
- Product and category performance.
- Basket / item analysis where supported.

### 6. Customer journey analysis
- Order events chronologically by user/session.
- Use window functions to analyse previous/next events.
- Identify common paths associated with purchase.

### 7. Power BI
- Export curated analysis tables.
- Build funnel KPIs and conversion visuals.
- Add channel, device, product and journey views.
- Add interactive filters.

### 8. Portfolio presentation
- Document validated findings.
- Add dashboard screenshots.
- Summarise business recommendations.
