# GA4 Data Dictionary

This project uses the Google Analytics 4 BigQuery event-export schema. GA4 data is event based and contains nested and repeated fields.

## Core Event Fields

| Field | Purpose in this project |
|---|---|
| `event_date` | Event date in `YYYYMMDD` format |
| `event_timestamp` | Event timestamp in microseconds |
| `event_name` | Name of the GA4 event, used to identify funnel stages |
| `user_pseudo_id` | Pseudonymous user identifier |
| `user_first_touch_timestamp` | First recorded visit/open timestamp |
| `platform` | Platform associated with the event |

## Event Parameters

`event_params` is a repeated RECORD containing key/value pairs. Parameters required for analysis will be extracted with `UNNEST(event_params)`.

Potential examples include session identifiers and page/event context. Parameter availability will be validated against the sample before use.

## Traffic Source

The `traffic_source` RECORD contains first-user acquisition information such as:

- `traffic_source.source`
- `traffic_source.medium`
- `traffic_source.name`

These fields describe the source that first acquired the user and should not automatically be interpreted as session-level attribution.

## Device and Geography

Useful segmentation records include device and geographic attributes. The exact fields used in final queries will be validated before reporting.

## Ecommerce

The `ecommerce` RECORD contains transaction-level ecommerce metrics for relevant events, including fields such as transaction ID and purchase-related values where populated.

## Items

`items` is a repeated RECORD containing item-level ecommerce attributes such as:

- `item_id`
- `item_name`
- `item_brand`
- `item_variant`
- `item_category`
- quantity and price-related fields where populated

Item analysis requires `UNNEST(items)`.

## Data-quality note

The public dataset is intentionally obfuscated. Placeholder, blank and null values may occur and internal consistency can be limited. All portfolio findings will therefore be based on validated fields and clearly documented assumptions.
