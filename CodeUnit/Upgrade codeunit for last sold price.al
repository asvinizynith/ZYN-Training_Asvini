codeunit 50161 "Upgrade Last Sold Price"
{
    Subtype = Upgrade;
    trigger OnUpgradePerCompany()
    var
        SalesInvLine: Record "Sales Invoice Line";
        LastSoldRec: Record "Last Sold Price Finder";
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
                LastSoldRec.Reset();
                LastSoldRec.SetRange("Customer No", SalesInvLine."Sell-to Customer No.");
                LastSoldRec.SetRange("Item No", SalesInvLine."No.");

                if not LastSoldRec.FindFirst() then begin
                    LastSoldRec.Init();
                    LastSoldRec."Customer No" := SalesInvLine."Sell-to Customer No.";
                    LastSoldRec."Item No" := SalesInvLine."No.";
                    LastSoldRec."LastItem Sold Price" := SalesInvLine."Unit Price";
                    LastSoldRec."Posting Date" := SalesInvLine."Posting Date";
                    LastSoldRec.Insert(true);
                    InsertedCount += 1;
                end else begin
                    if SalesInvLine."Posting Date" > LastSoldRec."Posting Date" then begin
                        LastSoldRec."LastItem Sold Price" := SalesInvLine."Unit Price";
                        LastSoldRec."Posting Date" := SalesInvLine."Posting Date";
                        LastSoldRec.Modify(true);
                        UpdatedCount += 1;
                    end;
                end;
            until SalesInvLine.Next() = 0;
        end;
        // ✅ Mark upgrade as complete so it doesn't run again
        UpgradeTag.SetUpgradeTag(UpgradeTagValue);
    end;
}
