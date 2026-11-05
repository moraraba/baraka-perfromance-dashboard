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
