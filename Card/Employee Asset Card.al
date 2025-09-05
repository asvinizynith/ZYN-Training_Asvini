page 50119 "Employee Asset Card"
{
    ApplicationArea = All;
    Caption = 'Employee Asset Card';
    PageType = Card;
    SourceTable = "Employee Asset Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No"; Rec."Entry No")
                {

                }
                field("Employee ID"; Rec."Employee ID")
                {

                }
                field("Serial No"; Rec."Serial No")
                {
trigger OnValidate()
    var
        EmpAssetRec: Record "Employee Asset Table";
    begin
        // If the asset is already assigned, check if it's assigned to this employee
        EmpAssetRec.Reset();
        EmpAssetRec.SetRange("Serial No", Rec."Serial No");
        if EmpAssetRec.FindFirst() then begin
            if (EmpAssetRec.Status = EmpAssetRec.Status::Assigned) and
               (EmpAssetRec."Employee ID" <> Rec."Employee ID") then
                Error('This asset is already assigned to another employee.');
        end;
    end;
                }
                field("Asset Name"; Rec."Asset Name")
                {

                }

                field(Status; Rec.Status)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(); // refresh UI
                        SetEditableFlags();
                    end;
                }
                field("Assigned Date"; rec."Assigned Date")
                {
                    ApplicationArea = All;
                    Editable = AssignedDateEditable;
                }

                field("Returned Date"; rec."Returned Date")
                {
                    ApplicationArea = All;
                    Editable = ReturnedDateEditable;
                }

                field("Lost Date"; rec."Lost Date")
                {
                    ApplicationArea = All;
                    Editable = LostDateEditable;
                }
            }


        }
    }
    var
        AssignedDateEditable: Boolean;
        ReturnedDateEditable: Boolean;
        LostDateEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        SetEditableFlags();
    end;

    local procedure SetEditableFlags()
    begin
        case Rec.Status of
            Rec.Status::Assigned:
                begin
                    // User enters Assigned Date manually
                    AssignedDateEditable := true;
                    ReturnedDateEditable := false;
                    LostDateEditable := false;
                end;

            Rec.Status::Returned:
                begin
                    // Assigned Date is auto-filled from HandleStatusChange()
                    AssignedDateEditable := false;
                    ReturnedDateEditable := true;   // only Returned Date editable
                    LostDateEditable := false;
                end;

            Rec.Status::Lost:
                begin
                    // Assigned Date is auto-filled from HandleStatusChange()
                    AssignedDateEditable := false;
                    ReturnedDateEditable := false;
                    LostDateEditable := true;       // only Lost Date editable
                end;

            else begin
                AssignedDateEditable := true;
                ReturnedDateEditable := true;
                LostDateEditable := true;
            end;
        end;
    end;
}

