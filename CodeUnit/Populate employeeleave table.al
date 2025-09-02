codeunit 50105 "Populate Employee Leave Table"
{


    trigger OnRun()
    var
        Employee: Record "Employee Table";
        LeaveCategory: Record "Leave Category Table";
        EmpLeave: Record "Employee Leave Table";
        RemainingLeaveCU: Codeunit "Remaining Leave";
    begin
        Employee.Reset();
        if Employee.FindSet() then
            repeat
                LeaveCategory.Reset();
                if LeaveCategory.FindSet() then
                    repeat
                        // Check if Employee-LeaveCategory combo already exists
                        if not EmpLeave.Get(Employee."Employee ID", LeaveCategory."Leave Category") then begin
                            EmpLeave.Init();
                            EmpLeave."Employee ID" := Employee."Employee ID";
                            EmpLeave."Leave Category" := LeaveCategory."Leave Category";

                            // Call Remaining Leave Codeunit
                            EmpLeave."Remaining leave" :=
                                RemainingLeaveCU.CalculateRemainingLeave(
                                    Employee."Employee ID",
                                    LeaveCategory."Leave Category");

                            EmpLeave.Insert();
                        end else begin
                            // Update existing record
                            EmpLeave."Remaining leave" :=
                                RemainingLeaveCU.CalculateRemainingLeave(
                                    Employee."Employee ID",
                                    LeaveCategory."Leave Category");
                            EmpLeave.Modify();
                        end;
                    until LeaveCategory.Next() = 0;
            until Employee.Next() = 0;

        Message('Employee Leave Table updated successfully.');
    end;
}
