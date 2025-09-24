page 50111 "ZYN_Leave Request List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_Leave Request List';
    SourceTable = "ZYN_Leave Request Table";
    UsageCategory = Administration;
    CardPageId = "ZYN_Leave Request Card";

    layout
    {
        area(Content)
        {
            repeater(LeaveRequest)
            {
                Editable = false;
                field("Request ID"; Rec."Request ID")
                {
                }
                field("Employee ID"; Rec."Employee ID")
                {
                }
                field("Leave Category"; Rec."Leave Category")
                {
                }
                field(Reason; Rec.Reason)
                {
                }
                field("Remaining leave"; Rec."Remaining leave")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Status; Rec.Status)
                {
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
                    EmployeeLeave: Codeunit "ZYN_Employee Leave Management";
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
                    EmployeeLeave.Run();

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
        RemainingLeaveCU: Codeunit "ZYN_Remaining Leave Calculator"; // ✅ Global Declaration
}
