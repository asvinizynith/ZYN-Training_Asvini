page 50112 "ZYN_Leave Request Card"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'ZYN_Leave Request Card';
    SourceTable = "ZYN_Leave Request Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Employee ID"; Rec."Employee ID")
                {
                    trigger OnValidate()
                    begin
                        UpdateRemainingLeave();
                    end;
                }
                field("Leave Category"; Rec."Leave Category")
                {
                    trigger OnValidate()
                    begin
                        UpdateRemainingLeave();
                    end;
                }
                field("Remaining leave"; Rec."Remaining leave")
                {
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    trigger OnValidate()
                    begin
                        CalcLeaveDays();
                    end;
                }
                field("End Date"; Rec."End Date")
                {
                    trigger OnValidate()
                    begin
                        CalcLeaveDays();
                    end;
                }
                field("No. of Leave days"; Rec."No. of Leave days")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {                   
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
        RemainingLeaveCU: Codeunit "ZYN_Remaining Leave Calculator";

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
}
