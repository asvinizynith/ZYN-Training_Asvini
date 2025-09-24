page 50147 "ZYN_Expense Approval Req Claim"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_Expense Approval Req Claim';
    SourceTable = "ZYN_Expense Claim Table";
    SourceTableView = where(status = const("Pending Approval"));
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(ExpenseDetails)
            {
                Editable = false;
                field("Employee ID"; Rec."Employee ID")
                {
                }
                field("Category Code"; Rec."Category Code")
                {
                }
                field("Category Name"; Rec."Category Name")
                {
                }
                field(Subtype; Rec.Subtype)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Claim Date"; Rec."Claim Date")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Bill Date"; Rec."Bill Date")
                {
                }
                field("Bill Copy"; Rec."File Name")
                {
                    Caption = 'Bill Copy';
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(DownloadBillCopy)
            {
                Caption = 'Download Bill Copy';
                trigger OnAction()
                var
                    InS: InStream;
                begin
                    if Rec."File Name" = '' then
                        Error('No file has been uploaded.');

                    Rec."Bill Copy".CreateInStream(InS);
                    DownloadFromStream(InS, '', '', '', Rec."File Name");
                end;
            }
            action(ApproveClaim)
            {
                Caption = 'Approve';
                Image = Approvals;
                trigger OnAction()
                begin
                    ValidateBeforeApproval();
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify(true);
                    CurrPage.Update();
                end;
            }
            action(Reject)
            {
                Caption = 'Reject Claim';
                Image = Cancel;
                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::"Pending Approval" then
                        Error('Only claims in Pending Approval status can be rejected.');
                    // We call validation
                    // If it passes → we block rejection
                    // If it fails → error is raised and we catch with ELSE
                    if ValidateBeforeApprovalAllowed() then
                        Error('This claim satisfies approval rules and cannot be rejected.')
                    else begin
                        Rec.Status := Rec.Status::Rejected;
                        Rec.Modify(true);
                        CurrPage.Update();
                        Message('The claim has been rejected because it did not satisfy approval rules.');
                    end;
                end;
            }
        }
    }
    procedure ValidateBeforeApprovalAllowed(): Boolean
    begin
        ValidateBeforeApproval(); // your existing logic
        exit(true);  // No error → allowed
    end;

    procedure ValidateBeforeApproval()
    var
        ExpenseClaim: Record "ZYN_Expense Claim Table";
        Expenseclaimcategory: Record "ZYN_Expense Claim Category";

    begin
        // 1. Check Amount Limit
        if Expenseclaimcategory.Get(Rec."Category Code", Rec.Subtype, Rec."Category Name") then begin
            if rec.Amount > Expenseclaimcategory."Amount Limit" then
                Error('Amount Exceeds The Limit');
        end;
        // 2. Check Status
        if Rec.Status <> Rec.Status::"Pending Approval" then
            Error('Claim status must be Pending Approval before approval.');
        // 3. Validate Claim Date vs Bill Date
        if (Rec."Bill Date" <> 0D) and (Rec."Claim Date" <> 0D) then begin
            if Rec."Claim Date" < Rec."Bill Date" then
                Error('Claim Date (%1) cannot be earlier than Bill Date (%2).', Rec."Claim Date", Rec."Bill Date");

            if Rec."Claim Date" > CalcDate('<+3M>', Rec."Bill Date") then
                Error('Claim Date (%1) cannot be more than 3 months after Bill Date (%2).', Rec."Claim Date", Rec."Bill Date");
        end;
        // 4. Duplicate Claim Check
        ExpenseClaim.Reset();
        ExpenseClaim.SetRange("Employee ID", Rec."Employee ID");
        ExpenseClaim.SetRange("Category Code", Rec."Category Code");
        ExpenseClaim.SetRange("Bill Date", Rec."Bill Date");
        ExpenseClaim.SetRange("Subtype", Rec."Subtype");
        ExpenseClaim.SetFilter("Entry No.", '<>%1', Rec."Entry No.");
        if ExpenseClaim.FindSet() then
            Error(
                'A claim already exists for Employee %1, Category %2, Bill Date %3, Subtype %4.',
                Rec."Employee ID", Rec."Category Code", Rec."Bill Date", Rec."Subtype");
    end;
}