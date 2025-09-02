page 50112 "Leave Request Card"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'Leave Request Card';
    SourceTable = "Leave Request Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateRemainingLeave();
                    end;
                }

                field("Leave Category"; Rec."Leave Category")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateRemainingLeave();
                    end;
                }

                field("Remaining leave"; Rec."Remaining leave")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CalcLeaveDays();
                    end;
                }

                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CalcLeaveDays();
                    end;
                }

                field("No. of Leave days"; Rec."No. of Leave days")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateRemainingLeave();
    end;

    var
        RemainingLeaveCU: Codeunit "Remaining Leave";

    local procedure UpdateRemainingLeave()
    begin
        if (Rec."Employee ID" <> '') and (Rec."Leave Category" <> '') then
            Rec."Remaining leave" :=
              RemainingLeaveCU.CalculateRemainingLeave(Rec."Employee ID", Rec."Leave Category");
    end;

    local procedure CalcLeaveDays()
    begin
        if (Rec."Start Date" <> 0D) and (Rec."End Date" <> 0D) then
            Rec."No. of Leave days" := Rec."End Date" - Rec."Start Date" + 1;
    end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     Rec.Status := Rec.Status::Pending;   // ✅ Default status when new record is created
    // end;
}
