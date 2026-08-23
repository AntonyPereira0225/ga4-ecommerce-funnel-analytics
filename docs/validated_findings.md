# Validated Findings

## Dataset profile

- Analysis period: **1 November 2020 to 31 January 2021**
- Event records: **4,295,584**
- Distinct GA4 users (`user_pseudo_id`): **270,154**
- Days represented: **92**
- Session-level Power BI model: **354,857 sessions**

## Purchase funnel

The portfolio funnel is defined as:

`Session Start → View Item → Add to Cart → Begin Checkout → Purchase`

| Funnel stage | Sessions | Stage conversion | Stage drop-off | Overall conversion |
|---|---:|---:|---:|---:|
| Session Start | 354,857 | — | — | 100.00% |
| View Item | 75,271 | 21.21% | 78.79% | 21.21% |
| Add to Cart | 14,909 | 19.81% | 80.19% | 4.20% |
| Begin Checkout | 10,853 | 72.79% | 27.21% | 3.06% |
| Purchase | 4,745 | 43.72% | 56.28% | 1.34% |

### Funnel interpretation

- Overall session-to-purchase conversion is **1.34%**.
- The largest shopping-stage leakage occurs between **View Item and Add to Cart**, where **80.19%** of sessions do not progress to an add-to-cart event.
- **Checkout to Purchase** also shows meaningful leakage, with a **56.28%** drop-off.
- These event patterns show *where* users leave the measured funnel; they do not establish *why* users leave.

## Visitor type

| Visitor type | Sessions | Purchase sessions | Purchase conversion |
|---|---:|---:|---:|
| New Visitor | 257,400 | 1,736 | 0.67% |
| Returning Visitor | 97,457 | 3,009 | 3.09% |

Returning-visitor sessions convert at **3.09%**, versus **0.67%** for new-visitor sessions. Returning visitors also generate more purchase sessions despite substantially lower traffic volume.

## Device performance

| Device | Sessions | Purchase sessions | Purchase conversion |
|---|---:|---:|---:|
| Desktop | 205,899 | 2,695 | 1.31% |
| Mobile | 141,079 | 1,949 | 1.38% |
| Tablet | 7,879 | 101 | 1.28% |

Conversion is relatively consistent across device categories. Mobile has the highest observed rate at **1.38%**, but the differences are small enough that device type should not be presented as a major conversion differentiator.

## Acquisition source / medium

Selected first-user acquisition combinations:

| First-user source / medium | Sessions | Purchase sessions | Purchase conversion |
|---|---:|---:|---:|
| google / organic | 111,488 | 1,222 | 1.10% |
| (direct) / (none) | 82,362 | 1,061 | 1.29% |
| <Other> / <Other> | 51,775 | 500 | 0.97% |
| <Other> / referral | 34,110 | 465 | 1.36% |
| shop.googlemerchandisestore… / referral | 28,044 | 567 | 2.02% |
| (data deleted) / (data deleted) | 21,087 | 677 | 3.21% |
| google / cpc | 15,534 | 151 | 0.97% |

High traffic volume does not automatically correspond to higher purchase conversion. Because this public dataset is obfuscated, values such as `<Other>` and `(data deleted)` are retained for transparency but should not be used for specific marketing recommendations.

## Product observations

Examples from the top product analysis:

- **Super G Unisex Joggers** recorded the most purchase sessions among the displayed products (**227**) but a relatively modest **1.24% view-to-purchase rate**.
- **Google Camp Mug Ivory** recorded **181 purchase sessions** and a much stronger **5.68% view-to-purchase rate**.
- **Google Clear Pen 4-Pack** recorded a **4.78% view-to-purchase rate**.
- **Google Campus Bike** recorded a **4.74% view-to-purchase rate**.

This demonstrates the difference between products that win through traffic volume and products that convert product interest more efficiently.

## Power BI dashboard KPIs

The session-level Power BI export is restricted to sessions with an observed `session_start` event and a non-null GA4 session ID. Under this dashboard scope:

- Total Sessions: **354,857**
- Purchase Sessions: **4,745**
- Purchase Conversion Rate: **1.34%**
- Total Revenue: approximately **$352.83K**
- Revenue per Session: approximately **$0.99**

The dashboard includes interactive filters for date, device category and visitor type, plus funnel, visitor, device, acquisition and time-series views.
