codeunit 50123 "ZYN_Subscript Renew Notify Mgt"
{
    procedure SubscriptionRenewalNotification()
    var
        Notification: Notification;
        SubRenewal: Record "ZYN_Subscription Table";

    begin
        SubRenewal.Reset();
        SubRenewal.SetRange(status, SubRenewal.status::Active);
        SubRenewal.SetRange("End Date", WorkDate() + 15);
        SubRenewal.SetCurrentKey(SystemModifiedAt);
        SubRenewal.SetAscending(SystemModifiedAt, true);
        if SubRenewal.FindSet() then
            repeat
                Clear(Notification);
                Notification.Id := CreateGuid();
                Notification.Scope := NotificationScope::LocalScope;
                Notification.Message :=
                    StrSubstNo('%1 Subscription going to be expired. Next Renewal date %2.', SubRenewal."Customer ID", SubRenewal."Next Renewal Date");
                Notification.Send();
                SubRenewal."Remainder Sent" := true;
                SubRenewal.Modify();
            until SubRenewal.Next() = 0;
    end;
}