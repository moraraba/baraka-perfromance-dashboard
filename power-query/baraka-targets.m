let
    Folder = "C:\Baraka\",
    Source = Csv.Document(File.Contents(Folder & "baraka-targets.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumnTypes(Promoted, {
        {"month", type date}, {"segment", type text}, {"target_sales_kes", Int64.Type}
    }, "en-US")
in
    Typed
