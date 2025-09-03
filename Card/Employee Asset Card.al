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

                }
                field("Asset Name"; Rec."Asset Name")
                {

                }

                field(Status; Rec.Status)
                {

                }
                field("Assigned Date"; rec."Assigned Date")
                {
                    ApplicationArea = All;
                    Editable = IsAssignedEditable;
                }

                field("Returned Date"; rec."Returned Date")
                {
                    ApplicationArea = All;
                    Editable = IsReturnedEditable;

                }

                field("Lost Date"; rec."Lost Date")
                {
                    ApplicationArea = All;
                    Editable = IsLostEditable;

                }
            }


        }
    }
    var
        IsAssignedEditable: Boolean;
        IsReturnedEditable: Boolean;
        IsLostEditable: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateFieldEditability();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateFieldEditability();
    end;

    local procedure UpdateFieldEditability()
    begin
        // Reset all
        IsAssignedEditable := false;
        IsReturnedEditable := false;
        IsLostEditable := false;

        case rec.Status of
            rec.Status::Assigned:
                begin
                    IsAssignedEditable := true;   // Only Assigned Date editable
                end;

            rec.Status::Returned:
                begin
                    IsReturnedEditable := true;   // Only Returned Date editable
                end;

            rec.Status::Lost:
                begin
                    IsLostEditable := true;       // Only Lost Date editable
                end;
        end;
    end;
}

