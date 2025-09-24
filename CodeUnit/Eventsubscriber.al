codeunit 50124 "ZYN_My Subscribers"
{
    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Codeunit, codeunit::"ZYN_My Publishers", 'OnAfterNewCustomerCreated', '', true, true)]
    procedure CheckCustomerNameOnAfterNewCustomerCreated(line: Text[50])
    begin
        Message('New Customer %1 has been Created', line);
    end;
}
