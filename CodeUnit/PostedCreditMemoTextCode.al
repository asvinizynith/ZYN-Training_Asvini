codeunit 50158 "Posted CreditMemo Text"

{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoHeaderInsert', '', false, false)]
    local procedure OnAfterSalesCrMemoHeaderInsertbegin(var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
     SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean;
     WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header";
     var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    var
        BeginningTextCode: Record "Text Code Table";
        PostedText: Record "Text Code Table";
        LineNo: Integer;
    begin
        SalesCrMemoHeader."Beginning Code" := SalesHeader."Beginning Text Code";

        BeginningTextCode.SetRange(No, SalesHeader."No.");
        BeginningTextCode.SetRange(Selection, BeginningTextCode.Selection::BeginningText);

        if BeginningTextCode.FindSet() then begin
            LineNo := 0;
            repeat
                PostedText.Init();
                PostedText.No := SalesCrMemoHeader."No.";
                PostedText."Language Code" := BeginningTextCode."Language Code";
                PostedText.Text := BeginningTextCode.Text;
                PostedText.Selection := PostedText.Selection::BeginningText;
                PostedText."Document Type" := PostedText."Document Type"::"Posted Credit Memo";
                PostedText."Line No" := LineNo;
                PostedText.Insert(true);
                LineNo += 0;
            until BeginningTextCode.Next() = 0;
        end;
        BeginningTextCode.SetRange(No, SalesHeader."No.");
        BeginningTextCode.SetRange(Selection, BeginningTextCode.Selection::BeginningText);
        BeginningTextCode.DeleteAll();
    end;

    local procedure OnAfterSalesCrMemoHeaderendInsertend(var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
     SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean;
     WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header";
     var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    var
        BeginningTextCode: Record "Text Code Table";
        PostedText: Record "Text Code Table";
        LineNo: Integer;
    begin
        SalesCrMemoHeader."Ending Code" := SalesHeader."Ending Text Code";

        BeginningTextCode.SetRange(No, SalesHeader."No.");
        BeginningTextCode.SetRange(Selection, BeginningTextCode.Selection::EndingText);

        if BeginningTextCode.FindSet() then begin
            LineNo := 0;
            repeat
                PostedText.Init();
                PostedText.No := SalesCrMemoHeader."No.";
                PostedText."Language Code" := BeginningTextCode."Language Code";
                PostedText.Text := BeginningTextCode.Text;
                PostedText.Selection := PostedText.Selection::EndingText;
                PostedText."Document Type" := PostedText."Document Type"::"Posted Credit Memo";
                PostedText."Line No" := LineNo;
                PostedText.Insert(true);
                LineNo += 0;
            until BeginningTextCode.Next() = 0;
        end;
        BeginningTextCode.SetRange(No, SalesHeader."No.");
        BeginningTextCode.SetRange(Selection, BeginningTextCode.Selection::EndingText);
        BeginningTextCode.DeleteAll();
    end;



}