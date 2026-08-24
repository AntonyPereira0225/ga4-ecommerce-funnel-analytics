# Data

The source data is queried directly from Google's public BigQuery dataset:

`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

## Data handling

The raw GA4 event data is **not committed** to this repository. The source contains more than 4.2 million event rows and remains publicly accessible in BigQuery, so duplicating it in GitHub would add unnecessary repository size.

The SQL workflow in `sql/` reproduces the analysis from the public source. In particular, `sql/10_power_bi_export.sql` creates the session-level analytical extract used by the Power BI model.

The final `.pbix` file is included in `dashboard/GA4_Ecommerce_Funnel_Analytics.pbix`, together with the SQL, documentation and dashboard screenshot needed to review and reproduce the project.
