page 50139 "Expense Claim Card"
{
    ApplicationArea = All;
    Caption = 'Expense Claim Card';
    PageType = Card;
    SourceTable = "expense claim table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {

                }
                field("Employee ID"; Rec."Employee ID")
                {

                }
                field("Category code"; Rec."Category Code")
                {
                    trigger OnDrillDown()
                    var
                        ExpenseClaimCategory: Record "Expense Claim Category Table";
                    begin
                        if Page.RunModal(Page::"Expense Claim Category List", ExpenseClaimCategory) = Action::LookupOK then begin
                            Rec."Category Code" := ExpenseClaimCategory."Category Code";
                            Rec."Subtype" := ExpenseClaimCategory."Subtype";    // auto-fill subtype after selection
                            Rec."Category Name" := ExpenseClaimCategory."Category Name";
                        end;
                        CalcAvailableLimit();
                    end;

                    trigger OnValidate()
                    begin
                        CalcAvailableLimit();
                    end;
                }
                field("Category Name"; Rec."Category Name")
                {

                }
                field(Subtype; Rec.Subtype)
                {

                }
                field("Available Amount Limit"; "AvailableAmountLimit")
                {
                    ApplicationArea = All;
                    Caption = 'Available Amount Limit';
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {

                }
                field("Bill Date"; Rec."Bill Date")
                {

                }
                field("Claim Date"; Rec."Claim Date")
                {

                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }

                field("Bill Copy"; Rec."File Name")
                {
                    Caption = 'Bill Copy';
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    var
                        InS: InStream;
                        OutS: OutStream;
                        FileName: Text;
                    begin
                        // If file already uploaded → download
                        if Rec."File Name" <> '' then begin
                            Rec."Bill Copy".CreateInStream(InS);
                            DownloadFromStream(InS, '', '', '', Rec."File Name");
                            exit;
                        end;
                        // Else upload new file
                        if UploadIntoStream('Select Bill Copy', '', '', FileName, InS) then begin
                            Rec."Bill Copy".CreateOutStream(OutS);
                            CopyStream(OutS, InS);
                            Rec."File Name" := FileName;
                            Rec.Modify(true);
                            CurrPage.Update();
                        end;
                    end;
                }
                field(Remarks; Rec.Remarks)
                {

                }
            }
        }
    }
    var
        AvailableAmountlimit: Decimal;

    procedure CalcAvailableLimit()
    var
        ExpenseClaimRec: Record "Expense Claim table";
        ClaimCategoryRec: Record "Expense Claim Category Table";
        TotalApproved: Decimal;
        StartDate: Date;
        EndDate: Date;
    begin
        Clear(AvailableAmountlimit);
        TotalApproved := 0;

        if (Rec."Employee ID" = '') or (Rec."Subtype" = '') or (Rec."Category Code" = '') then
            exit;
        StartDate := CALCDATE('<-CY>', WORKDATE);
        EndDate := CALCDATE('<CY>', WORKDATE);

        if not ClaimCategoryRec.Get(Rec."Category Code", Rec."Category Name", Rec.Subtype) then
            exit;

        ExpenseClaimRec.Reset();
        ExpenseClaimRec.SetRange("Employee ID", Rec."Employee ID");
        ExpenseClaimRec.SetRange("Category Code", Rec."Category Code");
        ExpenseClaimRec.SetRange("Subtype", Rec."Subtype");
        ExpenseClaimRec.SetRange("Category Name", Rec."Category Name");
        ExpenseClaimRec.SetRange(Status, ExpenseClaimRec.Status::Approved);
        ExpenseClaimRec.SetRange("Claim Date", StartDate, EndDate);

        if ExpenseClaimRec.FindSet() then
            repeat
                TotalApproved += ExpenseClaimRec.Amount;
            until ExpenseClaimRec.Next() = 0;

        AvailableAmountlimit := ClaimCategoryRec."Amount Limit" - TotalApproved;
        CurrPage.Update();
    end;
}


