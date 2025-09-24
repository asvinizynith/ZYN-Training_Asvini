pageextension 50101 MyNotification extends "My Accounts"
{
    var
        LeaveNotification: Codeunit "ZYN_Leave Approval Notify Mgt";

    trigger OnOpenPage()
    begin
        LeaveNotification.ShowLeaveBalanceNotification();
    end;
}