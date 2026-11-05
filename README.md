# Baraka Manufacturing: Sales and Profitability Report (Power BI)

An interactive Power BI report for the CFO of Baraka Manufacturing, a fictional Kenyan maker of cooking oil, flour, soap, detergent, juice and tissue. It replaces a monthly spreadsheet that took days to compile with a self-service view of sales, discounts, cost and profit by segment, market, product and month, compared with last year and with the sales plan.

> Synthetic data. Baraka Manufacturing is fictional; the data follows the layout of Microsoft's Financial Sample workbook, re-set in Kenya. All money is in whole Kenyan shillings (KES). Period: January 2023 to December 2025.

## Headline results

| Metric | 2023 | 2024 | 2025 |
| --- | --- | --- | --- |
| Sales (KES M) | 94.2 | 99.6 | 107.3 |
| Profit (KES M) | 25.3 | 25.7 | 26.8 |
| Profit margin | 26.9% | 25.8% | 25.0% |
| Discount % of gross sales | 5.0% | 5.0% | 4.9% |
| Variance to plan | +2.1% | −2.1% | −0.3% |

Sales grew 13.9% in two years, but profit grew only 5.7% because unit costs rose about 2% a year while prices stayed flat. See the [CFO note](docs/cfo-note.md) for findings and recommendations.


## Data model

Star schema with two fact tables and four dimensions:

```
            Date (DAX)             Segment (DAX)
             │      │                │      │
             ▼      ▼                ▼      ▼
      baraka-sales ◄──────────────────  baraka-targets
         ▲      ▲
         │      │
  baraka-products  baraka-markets
```

All relationships are one-to-many, single direction, from dimension to fact. Sales and targets connect only through the shared Date and Segment tables, never directly.

## Data dictionary

| File | Rows | Grain |
| --- | --- | --- |
| `baraka-sales.csv` | 6,264 | One product to one segment in one market in one month, at one discount band |
| `baraka-targets.csv` | 180 | Sales plan for one segment in one month |
| `baraka-products.csv` | 6 | One product: category, pack size, standard cost, list price, launch year |
| `baraka-markets.csv` | 7 | One market: four Kenyan cities and three export cities |

Gross sales = units × sale price; sales = gross sales − discounts; profit = sales − COGS. Discount bands are fixed rates: None 0%, Low 3%, Medium 7%, High 15%.

## How to rebuild

1. Open Power BI Desktop, load the four CSVs from `data/` (see [01-power-query](docs/01-power-query.md)).
2. Create the Date and Segment tables and the relationships ([02-data-model](docs/02-data-model.md)).
3. Add the measures from [`dax/measures.dax`](dax/measures.dax) ([03-measures](docs/03-measures.md)).
4. Build the three pages ([04-report-design](docs/04-report-design.md)).

## Tools

Power BI Desktop · Power Query (M) · DAX
