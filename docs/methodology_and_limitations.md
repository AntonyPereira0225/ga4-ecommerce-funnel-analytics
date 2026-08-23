# Methodology and Limitations

## Analytical grain

The analysis uses the public Google Analytics 4 obfuscated e-commerce sample dataset for the Google Merchandise Store covering **1 November 2020 to 31 January 2021**.

GA4 event-level data is transformed into a session-level analytical layer using:

- `user_pseudo_id`
- the `ga_session_id` value extracted from `event_params`
- a combined session identifier of `user_pseudo_id + ga_session_id`

The Power BI dataset contains one row per session where a non-null `ga_session_id` is available and an observed `session_start` event is present.

## Funnel definition

The primary funnel is:

`session_start → view_item → add_to_cart → begin_checkout → purchase`

For each session, SQL flags whether each event is present using conditional aggregation. A session is counted at a stage when the corresponding event appears in that session.

### Important funnel limitation

This portfolio funnel is a **session-event-presence funnel**, not a strict chronological sequence model. It does not require the first occurrence of each event to appear in exact stage order. The approach is appropriate for summarising session-level stage participation, but it should not be described as a strict ordered-path funnel.

A production extension could enforce event chronology using `event_timestamp` and sequential stage rules.

## Visitor classification

A session containing the GA4 `first_visit` event is classified as **New Visitor**. Sessions without `first_visit` are classified as **Returning Visitor** for this portfolio analysis.

This is a behavioural classification within the available GA4 sample and should not be interpreted as a complete lifetime customer-history measure.

## Acquisition fields

The analysis uses:

- `traffic_source.source`
- `traffic_source.medium`

These are **first-user acquisition** attributes in the GA4 export. They do not represent the traffic source of every individual session. Dashboard and findings therefore use labels such as **first-user source / medium** rather than session channel.

## Revenue scope

The Power BI export filters to sessions with an observed `session_start` event. Revenue shown on the dashboard is therefore revenue associated with that scoped session population.

This produces approximately **$352.83K** in dashboard revenue. A broader event-based daily aggregation may include revenue attached to GA4 session IDs where an observed `session_start` event is not present in the selected export scope, so broader totals can differ. The dashboard value is used as the portfolio KPI because it reconciles to the same session population used by the funnel and slicers.

## Public dataset obfuscation

The Google sample data is intentionally obfuscated. Acquisition values such as:

- `<Other>`
- `(data deleted)`

are preserved rather than reconstructed. They are not used for specific marketing recommendations.

## Causality

The analysis identifies behavioural patterns and points of funnel leakage. It does **not** establish causal reasons for abandonment. For example, a high View Item → Add to Cart drop-off shows where measured progression weakens but cannot determine whether the cause is price, product relevance, UX, stock availability or another factor without additional evidence.

## Portfolio interpretation

This project is intended to demonstrate:

- BigQuery SQL on nested GA4 exports
- sessionisation and conditional aggregation
- funnel and segmentation analysis
- DAX-based KPI reporting
- interactive Power BI dashboard design
- evidence-based business interpretation

It should be presented as an analytical portfolio project using a public sample dataset, not as production reporting for Google or the Google Merchandise Store.
