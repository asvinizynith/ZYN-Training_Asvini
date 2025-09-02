// codeunit 50163 "salesorder to postedinvoice"
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
//     local procedure OnAfterSalesordertopostbegin(
//        var SalesInvHeader: Record "Sales Invoice Header";
//        SalesHeader: Record "Sales Header";
//        CommitIsSuppressed: Boolean;
//        WhseShip: Boolean;
//        WhseReceive: Boolean;
//        var TempWhseShptHeader: Record "Warehouse Shipment Header";
//        var TempWhseRcptHeader: Record "Warehouse Receipt Header";
//        PreviewMode: Boolean)
//     var
//         extended: Record "Extended Text Line";
//         Beginning: Record "Text Code Table";


//     begin
//         if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
//             Beginning.SetRange("No", SalesInvHeader."No.");
//             Beginning.SetRange("Document Type", Beginning."Document Type"::"Posted Invoice");
//             Beginning.SetRange(Selection, Beginning.Selection::BeginningText);
//             Beginning.DeleteAll();
//             SalesInvHeader."Beginning code" := SalesHeader."Invoice Beginning Text Code";

//             Extended.SetRange("No.", SalesINVHeader."Beginning code");
//             Extended.SetRange("Language Code", SalesHeader."Language Code");


//             if extended.FindSet() then begin
//                 repeat
//                     Beginning.Init();
//                     Beginning."Line No" := 0;
//                     Beginning."No" := SalesINVHeader."No.";
//                     Beginning."Language Code" := extended."Language Code";
//                     Beginning.Text := extended.Text;
//                     Beginning.Selection := Beginning.Selection::BeginningText;
//                     Beginning."Document Type" := Beginning."Document Type"::"Posted Invoice";
//                     Beginning.Insert();


//                 until extended.Next() = 0;
//             end;

//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
//     local procedure OnAfterSalesordertopostend(
//            var SalesInvHeader: Record "Sales Invoice Header";
//            SalesHeader: Record "Sales Header";
//            CommitIsSuppressed: Boolean;
//            WhseShip: Boolean;
//            WhseReceive: Boolean;
//            var TempWhseShptHeader: Record "Warehouse Shipment Header";
//            var TempWhseRcptHeader: Record "Warehouse Receipt Header";
//            PreviewMode: Boolean)
//     var
//         extended: Record "Extended Text Line";
//         Beginning: Record "Text Code Table";


//     begin
//         if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
//             Beginning.SetRange("No", SalesInvHeader."No.");
//             Beginning.SetRange("Document Type", Beginning."Document Type"::"Posted Invoice");
//             Beginning.SetRange(Selection, Beginning.Selection::EndingText);
//             Beginning.DeleteAll();
//             SalesInvHeader."Ending code" := SalesHeader."Invoice Ending Text Code";

//             Extended.SetRange("No.", SalesINVHeader."Ending code");
//             Extended.SetRange("Language Code", SalesHeader."Language Code");


//             if extended.FindSet() then begin
//                 repeat
//                     Beginning.Init();
//                     Beginning."Line No" := 0;
//                     Beginning."No" := SalesINVHeader."No.";
//                     Beginning."Language Code" := extended."Language Code";
//                     Beginning.Text := extended.Text;
//                     Beginning.Selection := Beginning.Selection::EndingText;
//                     Beginning."Line No" := 0;
//                     Beginning."Document Type" := Beginning."Document Type"::"Posted Invoice";
//                     Beginning.Insert();


//                 until extended.Next() = 0;
//             end;

//         end;
//     end;


// }
codeunit 50170 "Posted Invoice/Order Text Code"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure OnAfterSalesInvHeaderInsertCombined(
        var SalesInvHeader: Record "Sales Invoice Header";
        SalesHeader: Record "Sales Header";
        CommitIsSuppressed: Boolean;
        WhseShip: Boolean;
        WhseReceive: Boolean;
        var TempWhseShptHeader: Record "Warehouse Shipment Header";
        var TempWhseRcptHeader: Record "Warehouse Receipt Header";
        PreviewMode: Boolean)
    var
        BeginningText: Record "Text Code Table";
        EndingText: Record "Text Code Table";
        PostedText: Record "Text Code Table";
        Extended: Record "Extended Text Line";
    begin
        // --- Handle Invoices ---
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
            // Beginning text
            PostedText.Reset();
            PostedText.SetRange("No", SalesInvHeader."No.");
            PostedText.SetRange("Document Type", PostedText."Document Type"::"Posted Invoice");
            PostedText.SetRange(Selection, PostedText.Selection::BeginningText);
            PostedText.DeleteAll();

            SalesInvHeader."Beginning Code" := SalesHeader."Beginning Text Code";
            SalesInvHeader.Modify();

            BeginningText.Reset();
            BeginningText.SetRange("No", SalesInvHeader."Beginning Code");
            BeginningText.SetRange("Language Code", SalesHeader."Language Code");

            if BeginningText.FindSet() then
                repeat
                    PostedText.Init();
                    PostedText."Line No" := 0;
                    PostedText."No" := SalesInvHeader."No.";
                    PostedText."Language Code" := BeginningText."Language Code";
                    PostedText.Text := BeginningText.Text;
                    PostedText.Selection := PostedText.Selection::BeginningText;
                    PostedText."Document Type" := PostedText."Document Type"::"Posted Invoice";
                    PostedText.Insert();
                until BeginningText.Next() = 0;

            // Ending text
            PostedText.Reset();
            PostedText.SetRange("No", SalesInvHeader."No.");
            PostedText.SetRange("Document Type", PostedText."Document Type"::"Posted Invoice");
            PostedText.SetRange(Selection, PostedText.Selection::EndingText);
            PostedText.DeleteAll();

            SalesInvHeader."Ending Code" := SalesHeader."Ending Text Code";
            SalesInvHeader.Modify();

            EndingText.Reset();
            EndingText.SetRange("No", SalesInvHeader."Ending Code");
            EndingText.SetRange("Language Code", SalesHeader."Language Code");

            if EndingText.FindSet() then
                repeat
                    PostedText.Init();
                    PostedText."Line No" := 0;
                    PostedText."No" := SalesInvHeader."No.";
                    PostedText."Language Code" := EndingText."Language Code";
                    PostedText.Text := EndingText.Text;
                    PostedText.Selection := PostedText.Selection::EndingText;
                    PostedText."Document Type" := PostedText."Document Type"::"Posted Invoice";
                    PostedText.Insert();
                until EndingText.Next() = 0;
        end;

        // --- Handle Orders ---
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            // Beginning text from Extended
            PostedText.Reset();
            PostedText.SetRange("No", SalesInvHeader."No.");
            PostedText.SetRange("Document Type", PostedText."Document Type"::"Posted Invoice");
            PostedText.SetRange(Selection, PostedText.Selection::BeginningText);
            PostedText.DeleteAll();

            SalesInvHeader."Beginning Code" := SalesHeader."Invoice Beginning Text Code";
            SalesInvHeader.Modify();

            Extended.Reset();
            Extended.SetRange("No.", SalesInvHeader."Beginning Code");
            Extended.SetRange("Language Code", SalesHeader."Language Code");

            if Extended.FindSet() then
                repeat
                    PostedText.Init();
                    PostedText."Line No" := 0;
                    PostedText."No" := SalesInvHeader."No.";
                    PostedText."Language Code" := Extended."Language Code";
                    PostedText.Text := Extended.Text;
                    PostedText.Selection := PostedText.Selection::BeginningText;
                    PostedText."Document Type" := PostedText."Document Type"::"Posted Invoice";
                    PostedText.Insert();
                until Extended.Next() = 0;

            // Ending text from Extended
            PostedText.Reset();
            PostedText.SetRange("No", SalesInvHeader."No.");
            PostedText.SetRange("Document Type", PostedText."Document Type"::"Posted Invoice");
            PostedText.SetRange(Selection, PostedText.Selection::EndingText);
            PostedText.DeleteAll();

            SalesInvHeader."Ending Code" := SalesHeader."Invoice Ending Text Code";
            SalesInvHeader.Modify();

            Extended.Reset();
            Extended.SetRange("No.", SalesInvHeader."Ending Code");
            Extended.SetRange("Language Code", SalesHeader."Language Code");

            if Extended.FindSet() then
                repeat
                    PostedText.Init();
                    PostedText."Line No" := 0;
                    PostedText."No" := SalesInvHeader."No.";
                    PostedText."Language Code" := Extended."Language Code";
                    PostedText.Text := Extended.Text;
                    PostedText.Selection := PostedText.Selection::EndingText;
                    PostedText."Document Type" := PostedText."Document Type"::"Posted Invoice";
                    PostedText.Insert();
                until Extended.Next() = 0;
        end;
    end;
}
