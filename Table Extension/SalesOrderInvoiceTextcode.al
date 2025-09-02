tableextension 50159 salesorderinvoiceext extends "Sales Header"
{
    fields
    {
        field(50160; "Invoice Beginning Text Code"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                extended: Record "Extended Text Line";
                Beginning: Record "Text Code Table";
                customer: Record "Customer";
                LineNo: Integer;
            begin
                if Rec."No." = '' then
                    Error('select the customer No first');
                Beginning.SetRange("Customer No", Rec."Sell-to Customer No.");
                Beginning.SetRange(Selection, Beginning.Selection::BeginningText);
                Beginning.DeleteAll();


                if Customer.Get(Rec."Sell-to Customer No.") then begin
                    extended.SetRange("No.", Rec."Beginning Text Code");
                    extended.SetRange("Language Code", Customer."Language Code");
                    LineNo := 0;

                    if extended.FindSet() then begin
                        repeat
                            Beginning.Init();
                            Beginning."Customer No" := Rec."Sell-to Customer No.";
                            Beginning.No := Rec."No.";
                            Beginning."Language Code" := extended."Language Code";
                            Beginning.Text := extended.Text;
                            Beginning."Line No" := LineNo;
                            Beginning.Selection := Beginning.Selection::BeginningText;
                            Beginning."Document Type" := Rec."Document Type";
                            Beginning.Insert(true);
                            LineNo += 0;


                        until extended.Next() = 0;
                    end;
                end;


            end;

        }

        field(50161; "Invoice Ending Text Code"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                extended: Record "Extended Text Line";
                Beginning: Record "Text Code Table";
                customer: Record "Customer";
                LineNo: Integer;
            begin
                if Rec."No." = '' then
                    Error('select the customer No first');
                Beginning.SetRange("Customer No", Rec."Sell-to Customer No.");
                Beginning.SetRange(Selection, Beginning.Selection::EndingText);
                Beginning.DeleteAll();


                if Customer.Get(Rec."Sell-to Customer No.") then begin
                    extended.SetRange("No.", Rec."Ending Text Code");
                    extended.SetRange("Language Code", Customer."Language Code");
                    LineNo := 0;

                    if extended.FindSet() then begin
                        repeat
                            Beginning.Init();
                            Beginning."Customer No" := Rec."Sell-to Customer No.";
                            Beginning.No := Rec."No.";
                            Beginning."Language Code" := extended."Language Code";
                            Beginning.Text := extended.Text;
                            Beginning.Selection := Beginning.Selection::EndingText;
                            Beginning."Line No" := LineNo;
                            Beginning."Document Type" := Rec."Document Type";
                            Beginning.Insert(true);
                            LineNo += 0;


                        until extended.Next() = 0;
                    end;
                end;


            end;
        }
    }
    
    trigger OnDelete()
    var
        CodeTable: Record "Text Code Table";
    begin
        CodeTable.SetRange(No, SalesHeader."No.");
        CodeTable.SetRange(Selection, "Textcode Selection"::BeginningText);//("Document Type", "Sales Document Type"::Order)
        CodeTable.DeleteAll();

        CodeTable.SetRange(No, SalesHeader."No.");
        CodeTable.SetRange(Selection, "Textcode Selection"::EndingText);//("Document Type", "Sales Document Type"::Order)
        CodeTable.DeleteAll();

    end;

}


