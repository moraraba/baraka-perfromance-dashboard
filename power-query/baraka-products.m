let
    Folder = "C:\Baraka\",
    Source = Csv.Document(File.Contents(Folder & "baraka-products.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumnTypes(Promoted, {
        {"product", type text}, {"category", type text}, {"pack_size", type text},
        {"standard_cost_kes", Int64.Type}, {"list_price_kes", Int64.Type}, {"launched", Int64.Type}
    }, "en-US")
in
    Typed
