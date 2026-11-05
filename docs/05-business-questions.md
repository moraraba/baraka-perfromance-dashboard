# Answers to the business questions

All figures are from the four source files, January 2023 to December 2025, in KES.

## Loading and modelling

**What does one row of baraka-sales represent?**
The sales of one product to one segment in one market in one month at one discount band. No combination repeats, so the grain is month × segment × market × product × band.

**How do gross sales, discounts, sales, COGS and profit relate?**
Gross sales = units × sale price; sales = gross sales − discounts; profit = sales − COGS. Row 1 (Nairobi, Supermarkets, Cooking Oil, Medium band, January 2023): 849 × 347 = 294,603 gross; − 20,622 discount (7%) = 273,981 sales; − 193,572 COGS = 80,409 profit. The identities hold on all 6,264 rows. Discount bands are fixed rates: None 0%, Low 3%, Medium 7%, High 15%.

**Why do sales and targets need shared date and segment tables?**
See [02-data-model](02-data-model.md#why-shared-dimensions-instead-of-a-direct-sales--targets-link).

**Which columns were hidden, and why?**
See [02-data-model](02-data-model.md#columns-hidden-from-report-view).

## Measures

**Which segment brings in the most profit, and which has the lowest margin?**

| Segment | Profit (KES M) | Margin | Discount % | Sales growth 2023→2025 |
| --- | --- | --- | --- | --- |
| Supermarkets | 35.6 | 28.0% | 3.4% | +13.6% |
| Small shops | 16.9 | 32.3% | 3.2% | +16.0% |
| Distributors | 13.4 | 17.0% | 9.0% | +13.1% |
| Hotels and restaurants | 7.1 | 29.6% | 3.2% | +13.1% |
| Government | 4.7 | 24.9% | 4.5% | +14.9% |

Supermarkets earn the most profit; Distributors have the lowest margin because they take far deeper discounts.

**How does profit margin change from the None band to the High band?**
Overall: 31.0% (None) → 28.0% (Low) → 23.3% (Medium) → 13.8% (High). The same slide happens in every segment:

| Segment | None | Low | Medium | High |
| --- | --- | --- | --- | --- |
| Small shops | 34.5% | 32.6% | 29.2% | 22.5% |
| Hotels and restaurants | 31.8% | 30.2% | 26.1% | 20.3% |
| Supermarkets | 30.4% | 28.3% | 25.5% | 18.2% |
| Government | 28.8% | 26.2% | 22.8% | 14.3% |
| Distributors | 24.1% | 22.9% | 18.4% | 11.2% |

**Which product has grown fastest since 2023?**
Mango Juice 1L: KES 5.9M (2023) → 9.2M (2024) → 14.1M (2025), +140%, with the highest margin of any product (35.3%). The others grew 3–9%; Maize Flour grew slowest (+2.5%).

| Product | 2023 (KES M) | 2025 (KES M) | Growth |
| --- | --- | --- | --- |
| Mango Juice 1L | 5.9 | 14.1 | +139.7% |
| Detergent 1kg | 13.5 | 14.7 | +8.8% |
| Cooking Oil 1L | 27.0 | 28.9 | +7.2% |
| Tissue 10-pack | 9.4 | 10.0 | +6.4% |
| Bar Soap 800g | 11.2 | 11.7 | +4.2% |
| Maize Flour 2kg | 27.2 | 27.9 | +2.5% |

## Report

**Which markets are behind target, and since when?**
Kigali, since July 2024. Its sales fell 25% against July 2023 and stayed about 20% down through June 2025. Against its share of the plan it was 17% behind in 2024 and 27% behind in 2025. Year-on-year growth returned from July 2025, but only against the depressed base. All other markets were within 3% of plan each year and grew 14–17% since 2023.

| Market | Type | 2023 (KES M) | 2025 (KES M) | Growth | 2025 vs allocated plan |
| --- | --- | --- | --- | --- | --- |
| Nairobi | Domestic | 35.8 | 41.6 | +16.2% | +1.7% |
| Dar es Salaam | Export | 6.4 | 7.4 | +16.7% | +2.4% |
| Nakuru | Domestic | 10.8 | 12.5 | +15.3% | +0.9% |
| Mombasa | Domestic | 16.2 | 18.6 | +14.9% | +0.6% |
| Kisumu | Domestic | 12.7 | 14.6 | +14.5% | +0.2% |
| Kampala | Export | 7.7 | 8.8 | +14.2% | +0.2% |
| Kigali | Export | 4.6 | 3.8 | −17.2% | −27.3% |

At company level, all twelve months of 2024 were behind plan (−2.1% for the year), with the biggest gaps in Supermarkets (−KES 0.96M) and Distributors (−KES 0.57M). Export margins (19.0% in 2025) run well below domestic (26.3%).

**Which months are strongest and weakest each year?**
December is strongest every year (KES 10.4M, 10.8M, 11.8M) and January weakest (KES 6.5M, 6.9M, 7.4M). Sales build steadily from February to November, then jump about 20% in December.

**Where is discounting costing the most margin?**
Distributors in the High band. Distributors account for 49.5% of all discount shillings (KES 7.8M of 15.7M) and put 42.5% of their gross sales through the High band, where they earn 11.2% margin. No other segment puts more than 9% of gross sales through the High band.

## Recommendations

**Which segment should get more budget next year?**
Small shops: highest margin (32.3%), fastest growth (+16.0%), low discounting (3.2%) and the second-largest profit pool. Each extra shilling of Small shops sales earns about KES 0.32 of profit, against KES 0.17 from Distributors.

**What would you change in the discount policy?**
Make the 15% band an approved exception rather than a routine rate, tie it to volume commitments, and cap Distributors' High-band share. Moving half of their High-band gross sales to the Medium band would keep about KES 0.5M a year in profit if volumes hold. Report Discount % by segment every month so drift is visible.

**Margin trend.**
Margin fell from 26.9% (2023) to 25.8% (2024) and 25.0% (2025) in every segment. The cause is cost, not discounts: discount % stayed at about 4.9–5.0% each year, while average unit cost rose about 2% a year on each product and realised prices did not move.
