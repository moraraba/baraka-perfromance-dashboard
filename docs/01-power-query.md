# Step 1: Load the files in Power Query

Load each CSV with **Get data → Text/CSV → Transform Data**, then set the column types below.

**Checkpoint:** `baraka-sales` has 6,264 rows and `baraka-targets` has 180.

## Data types

| Table | Columns and types |
| --- | --- |
| baraka-sales | `sale_id`, `units_sold`, `sale_price_kes`, `gross_sales_kes`, `discounts_kes`, `sales_kes`, `cogs_kes`, `profit_kes` → Whole number; `month` → Date; `segment`, `market`, `product`, `discount_band` → Text |
| baraka-targets | `month` → Date; `segment` → Text; `target_sales_kes` → Whole number |
| baraka-products | `product`, `category`, `pack_size` → Text; `standard_cost_kes`, `list_price_kes` → Whole number; `launched` → Whole number (a year, not a date) |
| baraka-markets | all four columns → Text |

The discount band **None** must stay as text. Do not replace it with null, or a third of the rows lose their band.

## M code

The full queries are in [`../power-query/`](../power-query/). Change the `Folder` path to where your CSV files are saved. The sales query also adds `band_order`, so discount bands can be sorted None → Low → Medium → High instead of alphabetically (select `discount_band`, then **Sort by column → band_order**).

The `"en-US"` culture in `Table.TransformColumnTypes` makes the ISO dates (`2023-01-01`) parse correctly on any regional setting.

```m
let
    Folder = "C:\Baraka\",
    Source = Csv.Document(File.Contents(Folder & "baraka-sales.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumnTypes(Promoted, {
        {"sale_id", Int64.Type}, {"month", type date},
        {"segment", type text}, {"market", type text}, {"product", type text}, {"discount_band", type text},
        {"units_sold", Int64.Type}, {"sale_price_kes", Int64.Type}, {"gross_sales_kes", Int64.Type},
        {"discounts_kes", Int64.Type}, {"sales_kes", Int64.Type}, {"cogs_kes", Int64.Type}, {"profit_kes", Int64.Type}
    }, "en-US"),
    BandOrder = Table.AddColumn(Typed, "band_order", each
        if [discount_band] = "None" then 1 else if [discount_band] = "Low" then 2
        else if [discount_band] = "Medium" then 3 else 4, Int64.Type)
in
    BandOrder
```

## Data checks

The data is clean. On all 6,264 sales rows:

- `gross_sales_kes` = `units_sold` × `sale_price_kes`
- `sales_kes` = `gross_sales_kes` − `discounts_kes`
- `profit_kes` = `sales_kes` − `cogs_kes`
- No month × segment × market × product × band combination repeats.
