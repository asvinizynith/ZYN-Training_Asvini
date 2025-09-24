codeunit 50101 "ZYN_Remaining Leave Calculator"
{
    procedure CalculateRemainingLeave(EmployeeID: Code[30]; LeaveCategory: Code[50]): Integer
    var
        LeaveCategoryRecord: Record "ZYN_Leave Category Table";
        LeaveRequest: Record "ZYN_Leave Request Table";
        TotalTaken: Integer;
    begin
        // Check if category exists
        if LeaveCategoryRecord.Get(LeaveCategory) then begin
            LeaveRequest.SetRange("Employee ID", EmployeeID);
            LeaveRequest.SetRange("Leave Category", LeaveCategory);
            LeaveRequest.SetRange(Status, LeaveRequest.Status::Approved);
            TotalTaken := 0;
            if LeaveRequest.FindSet() then
                repeat
                    TotalTaken += LeaveRequest."No. of Leave days";
                until LeaveRequest.Next() = 0;

            exit(LeaveCategoryRecord."No. Of Days Allowed" - TotalTaken);
        end;
        exit(0); // if no category found
    end;
}
