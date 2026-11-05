# Step 3: The measure library

Create an empty table to hold the measures (**Enter data → name it `_Measures`**, then delete its column once a measure lives there), and add each measure with **New measure**. The full set is in [`../dax/measures.dax`](../dax/measures.dax).

Format money as whole number with thousands separator; percentages as % with one decimal.

## Core measures

```dax
Total Sales = SUM ( 'baraka-sales'[sales_kes] )
Gross Sales = SUM ( 'baraka-sales'[gross_sales_kes] )
Total Discounts = SUM ( 'baraka-sales'[discounts_kes] )
Discount % = DIVIDE ( [Total Discounts], [Gross Sales] )
Total COGS = SUM ( 'baraka-sales'[cogs_kes] )
Total Profit = SUM ( 'baraka-sales'[profit_kes] )
Profit Margin = DIVIDE ( [Total Profit], [Total Sales] )
Units Sold = SUM ( 'baraka-sales'[units_sold] )
```

## Time intelligence

```dax
Sales Last Year = CALCULATE ( [Total Sales], SAMEPERIODLASTYEAR ( 'Date'[Date] ) )
Sales Growth % = DIVIDE ( [Total Sales] - [Sales Last Year], [Sales Last Year] )
Sales YTD = TOTALYTD ( [Total Sales], 'Date'[Date] )
Profit Last Year = CALCULATE ( [Total Profit], SAMEPERIODLASTYEAR ( 'Date'[Date] ) )
Profit Growth % = DIVIDE ( [Total Profit] - [Profit Last Year], [Profit Last Year] )
Sales 2023 = CALCULATE ( [Total Sales], REMOVEFILTERS ( 'Date' ), 'Date'[Year] = 2023 )
Sales Growth vs 2023 % = DIVIDE ( [Total Sales] - [Sales 2023], [Sales 2023] )
```

Sales Last Year is blank for 2023 because the data starts in January 2023. That is expected.

## Plan measures

The plan is set by segment and month only, with no market or product. Summed plainly, it would repeat the full segment target on every market row. This version splits each segment's target across markets and products by their share of that segment's 2023 sales (the first plan year). With no market or product filter the share is 100%, so it equals a plain SUM of the targets.

```dax
Target Sales =
SUMX (
    VALUES ( Segment[segment] ),
    VAR SegmentTarget = CALCULATE ( SUM ( 'baraka-targets'[target_sales_kes] ) )
    VAR Share =
        DIVIDE (
            CALCULATE ( [Total Sales], REMOVEFILTERS ( 'Date' ), 'Date'[Year] = 2023 ),
            CALCULATE (
                [Total Sales],
                REMOVEFILTERS ( 'Date' ), 'Date'[Year] = 2023,
                REMOVEFILTERS ( 'baraka-markets' ),
                REMOVEFILTERS ( 'baraka-products' )
            )
        )
    RETURN SegmentTarget * Share
)

Variance to Target = [Total Sales] - [Target Sales]
Variance to Target % = DIVIDE ( [Variance to Target], [Target Sales] )
Target YTD = TOTALYTD ( [Target Sales], 'Date'[Date] )
```

Simpler alternative: `Target Sales = SUM ( 'baraka-targets'[target_sales_kes] )`, with market slicers kept off the variance card.

## Expected totals (no filters)

| Measure | Value |
| --- | --- |
| Total Sales | KES 301,036,384 |
| Gross Sales | KES 316,693,098 |
| Total Discounts | KES 15,656,714 |
| Discount % | 4.9% |
| Total Profit | KES 77,793,572 |
| Profit Margin | 25.8% |
| Target Sales | KES 301,471,000 |
| Variance to Target | −KES 434,616 |
