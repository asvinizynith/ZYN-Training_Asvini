page 50140 "ZYN_Expense Claim List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_Expense Claim List';
    SourceTable = "ZYN_Expense Claim Table";
    UsageCategory = Administration;
    CardPageId = "ZYN_Expense Claim Card";

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
            action(Cancel)
            {
                Caption = 'Cancel';
                Image = Cancel;
                trigger OnAction()
                begin
                    // Allow cancel only if status = Pending Approval
                    if Rec.Status = Rec.Status::"Pending Approval" then begin
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.Modify(true);
                        CurrPage.Update();
                    end else
                        Error('Only claims in Pending Approval status can be cancelled.');
                end;
            }
        }
    }
}