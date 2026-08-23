# SQL Analysis

This folder contains the BigQuery SQL used to profile the GA4 sample dataset and build the e-commerce funnel, acquisition, device, product and customer-journey analyses.

Planned sequence:

1. `01_dataset_profile.sql` — validate dataset size, users, dates and event names.
2. Funnel-stage analysis — measure users reaching each e-commerce stage.
3. Channel/device analysis — compare conversion by acquisition source and device.
4. Product analysis — analyse item performance and revenue.
5. Customer journey analysis — order events and inspect paths to purchase.

The source tables are queried with wildcard syntax:

`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
