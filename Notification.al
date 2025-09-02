codeunit 50118 "Leave Approval Notification"
{
    procedure ShowLeaveBalanceNotification()
    var
        Notification: Notification;
        LeaveReq: Record "Leave Request Table";
   
    begin
        LeaveReq.Reset();
        LeaveReq.SetRange(Status, LeaveReq.Status::Approved);
        LeaveReq.SetCurrentKey(SystemModifiedAt);
        LeaveReq.SetAscending(SystemModifiedAt, true);
 
        Clear(Notification);
        Notification.Id := 'CDEF7890-ABCD-0123-1234-567890ABCDEF';
        Notification.Scope := NotificationScope::LocalScope;
 
        if LeaveReq.FindLast() then
            Notification.Message :=
                StrSubstNo('Last approved request: %1 for %2 days.',
                           LeaveReq."Employee ID", LeaveReq."End Date" - LeaveReq."Start Date" + 1)
        else
            Notification.Message := 'No approved leave requests found!';
 
        Notification.Send();
    end;
}
 
 
pageextension 50101 MyNotification extends "My Accounts"
{
    layout
    {
        
       
    }
    actions
    {}
    var
    LeaveNotification: Codeunit "Leave Approval Notification";
    trigger OnOpenPage()
    begin
LeaveNotification.ShowLeaveBalanceNotification();
    end;
}
 
