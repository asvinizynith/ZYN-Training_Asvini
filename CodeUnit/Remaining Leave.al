codeunit 50101 "Remaining Leave"
{
    procedure CalculateRemainingLeave(EmployeeID: Code[30]; LeaveCategory: Code[50]): Integer
    var
        LeaveCat: Record "Leave Category Table";
        LeaveReq: Record "Leave Request Table";
        TotalTaken: Integer;
    begin
        // Check if category exists
        if LeaveCat.Get(LeaveCategory) then begin
            LeaveReq.SetRange("Employee ID", EmployeeID);
            LeaveReq.SetRange("Leave Category", LeaveCategory);
            LeaveReq.SetRange(Status, LeaveReq.Status::Approved);

            TotalTaken := 0;
            if LeaveReq.FindSet() then
                repeat
                    TotalTaken += LeaveReq."No. of Leave days";
                until LeaveReq.Next() = 0;

            exit(LeaveCat."No. Of Days Allowed" - TotalTaken);
        end;

        exit(0); // if no category found
    end;
}
