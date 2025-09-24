codeunit 50105 "ZYN_Employee Leave Management"
{
    trigger OnRun()
    var
        Employee: Record "ZYN_Employee Table";
        LeaveCategory: Record "ZYN_Leave Category Table";
        EmpolyeeLeave: Record "ZYN_Employee Leave Table";
        RemainingLeaveCU: Codeunit "ZYN_Remaining Leave Calculator";
    begin
        Employee.Reset();
        if Employee.FindSet() then
            repeat
                LeaveCategory.Reset();
                if LeaveCategory.FindSet() then
                    repeat
                        // Check if Employee-LeaveCategory combo already exists
                        if not EmpolyeeLeave.Get(Employee."Employee ID", LeaveCategory."Leave Category") then begin
                            EmpolyeeLeave.Init();
                            EmpolyeeLeave."Employee ID" := Employee."Employee ID";
                            EmpolyeeLeave."Leave Category" := LeaveCategory."Leave Category";

                            // Call Remaining Leave Codeunit
                            EmpolyeeLeave."Remaining leave" :=
                                RemainingLeaveCU.CalculateRemainingLeave(
                                    Employee."Employee ID",
                                    LeaveCategory."Leave Category");
                            EmpolyeeLeave.Insert();
                        end else begin
                            // Update existing record
                            EmpolyeeLeave."Remaining leave" :=
                                RemainingLeaveCU.CalculateRemainingLeave(
                                    Employee."Employee ID",
                                    LeaveCategory."Leave Category");
                            EmpolyeeLeave.Modify();
                        end;
                    until LeaveCategory.Next() = 0;
            until Employee.Next() = 0;
        Message('Employee Leave Table updated successfully.');
    end;
}
