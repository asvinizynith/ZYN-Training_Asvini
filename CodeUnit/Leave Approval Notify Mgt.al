codeunit 50118 "ZYN_Leave Approval Notify Mgt"
{
    procedure ShowLeaveBalanceNotification()
    var
        Notification: Notification;
        LeaveRequest: Record "ZYN_Leave Request Table";
   
    begin
        LeaveRequest.Reset();
        LeaveRequest.SetRange(Status, LeaveRequest.Status::Approved);
        LeaveRequest.SetCurrentKey(SystemModifiedAt);
        LeaveRequest.SetAscending(SystemModifiedAt, true);
        Clear(Notification);
        Notification.Id := 'CDEF7890-ABCD-0123-1234-567890ABCDEF';
        Notification.Scope := NotificationScope::LocalScope;
 
        if LeaveRequest.FindLast() then
            Notification.Message :=
                StrSubstNo('Last approved request: %1 for %2 days.',
                           LeaveRequest."Employee ID", LeaveRequest."End Date" - LeaveRequest."Start Date" + 1)
        else
            Notification.Message := 'No approved leave requests found!';
        Notification.Send();
    end;
}
 

 
