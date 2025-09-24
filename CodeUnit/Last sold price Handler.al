codeunit 50161 "ZYN_Last Sold Price Handler"
{
    Subtype = Upgrade;
    trigger OnUpgradePerCompany()
    var
        SalesInvLine: Record "Sales Invoice Line";
        LastSold: Record "ZYN_Last Sold Price Finder";
        UpgradeTag: Codeunit "Upgrade Tag";
        UpgradeTagValue: Text[100];
        InsertedCount: Integer;
        UpdatedCount: Integer;
    begin
        UpgradeTagValue := 'LastSoldPriceFinderUpgrade';
        // ✅ If upgrade already done, skip it
        if UpgradeTag.HasUpgradeTag(UpgradeTagValue) then
            exit;
        InsertedCount := 0;
        UpdatedCount := 0;

        SalesInvLine.Reset();
        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);

        if SalesInvLine.FindSet() then begin
            repeat
                LastSold.Reset();
                LastSold.SetRange("Customer No", SalesInvLine."Sell-to Customer No.");
                LastSold.SetRange("Item No", SalesInvLine."No.");

                if not LastSold.FindFirst() then begin
                    LastSold.Init();
                    LastSold."Customer No" := SalesInvLine."Sell-to Customer No.";
                    LastSold."Item No" := SalesInvLine."No.";
                    LastSold."LastItem Sold Price" := SalesInvLine."Unit Price";
                    LastSold."Posting Date" := SalesInvLine."Posting Date";
                    LastSold.Insert(true);
                    InsertedCount += 1;
                end else begin
                    if SalesInvLine."Posting Date" > LastSold."Posting Date" then begin
                        LastSold."LastItem Sold Price" := SalesInvLine."Unit Price";
                        LastSold."Posting Date" := SalesInvLine."Posting Date";
                        LastSold.Modify(true);
                        UpdatedCount += 1;
                    end;
                end;
            until SalesInvLine.Next() = 0;
        end;
        // ✅ Mark upgrade as complete so it doesn't run again
        UpgradeTag.SetUpgradeTag(UpgradeTagValue);
    end;
}
