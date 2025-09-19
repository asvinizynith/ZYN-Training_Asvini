page 50111 "Leave Request List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Leave Request List';
    SourceTable = "Leave Request Table";
    UsageCategory = Administration;
    CardPageId = "Leave Request Card";

    layout
    {
        area(Content)
        {
            repeater(LeaveRequest)
            {
                Editable = false;
                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Leave Category"; Rec."Leave Category")
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field("Remaining leave"; Rec."Remaining leave")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ApproveLeave)
            {
                Caption = 'Approve Leave';
                Image = Approve;
                trigger OnAction()
                var
                    PopulateLeaveCU: Codeunit "Populate Employee Leave Table";
                begin
                    // 1. Ensure only Pending requests can be approved
                    Rec.TestField(Status, Rec.Status::Pending);

                    // 2. Recalculate leave days before approving
                    if (Rec."Start Date" <> 0D) and (Rec."End Date" <> 0D) then
                        Rec."No. of Leave days" := Rec."End Date" - Rec."Start Date" + 1;

                    // 3. Change status to Approved
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify(true);

                    // 4. Update Employee Leave Table using CU (recalc all balances)
                    PopulateLeaveCU.Run();

                    // 5. Refresh Remaining leave in the request
                    Rec."Remaining leave" :=
                        RemainingLeaveCU.CalculateRemainingLeave(Rec."Employee ID", Rec."Leave Category");
                    Rec.Modify(true);
                    Message(
                      'Leave Request %1 approved for %2 days. Remaining leave now: %3',
                       Rec."Employee ID", Rec."No. of Leave days", Rec."Remaining leave");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec."Remaining leave" :=
            RemainingLeaveCU.CalculateRemainingLeave(Rec."Employee ID", Rec."Leave Category");
    end;

    var
        RemainingLeaveCU: Codeunit "Remaining Leave Calculator"; // ✅ Global Declaration
}
