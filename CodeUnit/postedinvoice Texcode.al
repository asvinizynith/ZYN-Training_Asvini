// codeunit 50152 "Posted Invoice Text Code"

// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
   
//     local procedure OnAfterSalesInvbegin(
//     var SalesInvHeader: Record "Sales Invoice Header";
//     SalesHeader: Record "Sales Header";
//     CommitIsSuppressed: Boolean;
//     WhseShip: Boolean;
//     WhseReceive: Boolean;
//     var TempWhseShptHeader: Record "Warehouse Shipment Header";
//     var TempWhseRcptHeader: Record "Warehouse Receipt Header";
//     PreviewMode: Boolean)
//     var
//         BeginningTextCode: Record "Text Code Table";
//         PostedText: Record "Text Code Table";

//     begin
//  if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
//     PostedText.SetRange("No", SalesInvHeader."No.");
//             PostedText.SetRange("Document Type", PostedText."Document Type"::"Posted Invoice");
//             PostedText.SetRange(Selection, PostedText.Selection::BeginningText);
//             PostedText.DeleteAll();

//         SalesInvHeader."Beginning Code" := SalesHeader."Beginning Text Code";
// SalesInvHeader.Modify();
//         BeginningTextCode.SetRange(No, SalesINVHeader."Beginning Code");
//         BeginningTextCode.SetRange("Language Code",SalesHeader."Language Code");

//         if BeginningTextCode.FindSet() then begin
//             repeat
//                 PostedText.Init();
//                 PostedText."Line No" := 0;
//                 PostedText.No := SalesInvHeader."No.";
//                 PostedText."Language Code" := BeginningTextCode."Language Code";
//                 PostedText.Text := BeginningTextCode.Text;
//                 PostedText.Selection := PostedText.Selection::BeginningText;
//                 PostedText."Document Type" := PostedText."Document Type"::"Posted Invoice";
//                 PostedText.Insert();

//             until BeginningTextCode.Next() = 0;
//         end;

        
//     end;
//     end;
//      [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
// local procedure OnAfterSalesInvend(
//     var SalesInvHeader: Record "Sales Invoice Header";
//     SalesHeader: Record "Sales Header";
//     CommitIsSuppressed: Boolean;
//     WhseShip: Boolean;
//     WhseReceive: Boolean;
//     var TempWhseShptHeader: Record "Warehouse Shipment Header";
//     var TempWhseRcptHeader: Record "Warehouse Receipt Header";
//     PreviewMode: Boolean)
//     var
//         EndingTextCode: Record "Text Code Table";
//         PostedText: Record "Text Code Table";

//     begin
//  if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
//     PostedText.SetRange("No", SalesInvHeader."No.");
//             PostedText.SetRange("Document Type", PostedText."Document Type"::"Posted Invoice");
//             PostedText.SetRange(Selection, PostedText.Selection::EndingText);
//             PostedText.DeleteAll();

//         SalesInvHeader."Ending Code" := SalesHeader."Ending Text Code";
// SalesInvHeader.Modify();
//         EndingTextCode.SetRange(No, SalesINVHeader."Ending Code");
//         EndingTextCode.SetRange("Language Code",SalesHeader."Language Code");

//         if EndingTextCode.FindSet() then begin
//             repeat
//                 PostedText.Init();
//                 PostedText."Line No" := 0;
//                 PostedText.No := SalesInvHeader."No.";
//                 PostedText."Language Code" := EndingTextCode."Language Code";
//                 PostedText.Text := EndingTextCode.Text;
//                 PostedText.Selection := PostedText.Selection::EndingText;
//                 PostedText."Document Type" := PostedText."Document Type"::"Posted Invoice";
//                 PostedText.Insert();

//             until EndingTextCode.Next() = 0;
//         end;

        
//     end;
//     end;

  

// }




    
    





