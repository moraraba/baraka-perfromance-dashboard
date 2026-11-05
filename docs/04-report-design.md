# Step 4: Report design

Three pages, each answering one question for the CFO. The same three slicers (Year, Segment, Market) sit on every page and are synced (**View → Sync slicers**), so a choice follows the reader from page to page.

## Page 1: Overview (are we ahead of last year and plan?)

| Visual | Fields |
| --- | --- |
| 4 KPI cards | Total Sales, Total Profit, Profit Margin, Variance to Target (Sales Growth % as reference label) |
| Line and clustered column chart | X: `Date[Month Year]`; columns: Total Sales, Sales Last Year; line: Total Profit |
| Slicers | `Date[Year]` (tiles), `Segment[segment]`, `baraka-markets[market]` (dropdown) |

![Page 1](../screenshots/page1-overview.png)

## Page 2: Profitability (where do we make money?)

| Visual | Fields |
| --- | --- |
| Clustered bar | `Segment[segment]` by Total Profit; tooltip Profit Margin |
| Clustered bar | `baraka-products[product]` by Total Profit; tooltip Sales Growth vs 2023 % |
| Matrix with colour scale | Rows: `Segment[segment]`; columns: `discount_band`; values: Profit Margin (red low → green high) |
| Line and column chart | `discount_band` by Total Discounts (columns) and Profit Margin (line) |

![Page 2](../screenshots/page2-profitability.png)

## Page 3: Markets and plan (who is behind?)

| Visual | Fields |
| --- | --- |
| Donut or 100% bar | `baraka-markets[market_type]` by Total Sales |
| Table | market, market_type, Total Sales, Sales Growth %, Profit Margin, Variance to Target % (red/green icons) |
| Line chart | X: `Date[Month Year]`; lines: Total Sales, Target Sales |
| Column chart | X: `Date[Month Year]`; Variance to Target, red when negative (Format → Columns → fx → rules) |

![Page 3](../screenshots/page3-markets-plan.png)

## Design choices

- Each visual's title states its answer, not its fields: "Margin falls from 31% to 14% as discounts deepen", not "Profit Margin by discount_band".
- One colour for actual, grey for last year or plan, red only for shortfalls.
- Cards and axes in millions (KES M).
