# Step 2: Build the star schema

The model has two fact tables (`baraka-sales`, `baraka-targets`) and four dimensions (`Date`, `Segment`, `baraka-products`, `baraka-markets`). Create the two new tables with **Modeling → New table**, using the DAX in [`../dax/tables.dax`](../dax/tables.dax).

## Date table

```dax
Date =
ADDCOLUMNS (
    CALENDAR ( DATE ( 2023, 1, 1 ), DATE ( 2025, 12, 31 ) ),
    "Year", YEAR ( [Date] ),
    "Quarter", "Q" & QUARTER ( [Date] ),
    "Month Number", MONTH ( [Date] ),
    "Month", FORMAT ( [Date], "mmm" ),
    "Year Month Key", YEAR ( [Date] ) * 100 + MONTH ( [Date] ),
    "Month Year", FORMAT ( [Date], "mmm yyyy" )
)
```

Then **Table tools → Mark as date table → Date**. Sort `Month` by `Month Number` and `Month Year` by `Year Month Key`, otherwise months sort alphabetically.

## Segment table

```dax
Segment =
DATATABLE (
    "segment", STRING,
    "segment_order", INTEGER,
    {
        { "Supermarkets", 1 },
        { "Distributors", 2 },
        { "Small shops", 3 },
        { "Hotels and restaurants", 4 },
        { "Government", 5 }
    }
)
```

`Segment = DISTINCT ( 'baraka-sales'[segment] )` also works, but cannot carry a sort order.

## Relationships

All one-to-many, single direction, dimension → fact.

| From (one side) | To (many side) |
| --- | --- |
| `Date[Date]` | `baraka-sales[month]` |
| `Date[Date]` | `baraka-targets[month]` |
| `Segment[segment]` | `baraka-sales[segment]` |
| `Segment[segment]` | `baraka-targets[segment]` |
| `baraka-products[product]` | `baraka-sales[product]` |
| `baraka-markets[market]` | `baraka-sales[market]` |

Delete any relationship Power BI auto-detects between sales and targets. Months are stored as the first of the month, so they match the Date table exactly.

## Why shared dimensions instead of a direct sales ↔ targets link

Neither table has a unique key the other can point to. Sales has many rows per month and segment (one per product, market and band); targets has one row per month and segment. A direct link would be many-to-many and ambiguous. Shared `Date` and `Segment` tables filter both facts the same way, so one Year slicer or one segment axis shows actual and plan side by side.

## Columns hidden from report view

| Columns | Why hidden |
| --- | --- |
| Fact foreign keys: sales `month`, `segment`, `market`, `product`; targets `month`, `segment` | Users should slice by dimension columns; a slicer on `baraka-sales[segment]` would not filter targets |
| `sale_id` | Row identifier with no analytic meaning |
| Raw money and unit columns on sales and targets | Report users use the formatted measures; stops meaningless sums such as a total of `sale_price_kes` |
| `Month Number`, `Year Month Key`, `segment_order`, `band_order` | Sort helpers only |

Set `launched` in products to **Don't summarize** so it never shows as a total of years.
