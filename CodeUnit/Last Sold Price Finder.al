codeunit 50160 "ZYN_Last Sold Price Finder"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post",'OnAfterSalesInvLineInsert', '', false, false)]
    local procedure OnAfterSalesInvLineInsert(
        var SalesInvLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesLine: Record "Sales Line";
        ItemLedgShptEntryNo: Integer;
        WhseShip: Boolean;
        WhseReceive: Boolean;
        CommitIsSuppressed: Boolean;
        var SalesHeader: Record "Sales Header";
        var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary;
        var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary;
        var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary;
        PreviewMode: Boolean)
    var
        LastSold: Record "ZYN_Last Sold Price Finder";
    begin
        // Only store for Items
        if SalesInvLine.Type <> SalesInvLine.Type::Item then
            exit;
        // Look for existing record
        LastSold.Reset();
        LastSold.SetCurrentKey("Customer No", "Item No", "Posting Date");
        LastSold.SetRange("Customer No", SalesInvLine."Sell-to Customer No.");
        LastSold.SetRange("Item No", SalesInvLine."No.");

        if LastSold.FindLast() then begin
            // Update existing record
            LastSold.Validate("LastItem Sold Price", SalesInvLine."Unit Price");
            LastSold.Validate("Posting Date", SalesInvLine."Posting Date");
            LastSold.Modify(true);
        end else begin
            // Insert new record
            LastSold.Init();
            LastSold.Validate("Customer No", SalesInvLine."Sell-to Customer No.");
            LastSold.Validate("Item No", SalesInvLine."No.");
            LastSold.Validate("LastItem Sold Price", SalesInvLine."Unit Price");
            LastSold.Validate("Posting Date", SalesInvLine."Posting Date");
            LastSold.Insert(true);
        end;
    end;
}
