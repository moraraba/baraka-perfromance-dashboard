let
    Folder = "C:\Baraka\",
    Source = Csv.Document(File.Contents(Folder & "baraka-markets.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed = Table.TransformColumnTypes(Promoted, {
        {"market", type text}, {"country", type text}, {"region", type text}, {"market_type", type text}
    }, "en-US")
in
    Typed
