page 50126 "ZYN_Plan List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_Plan List';
    SourceTable = "ZYN_Plan Table";
    UsageCategory = Administration;
    CardPageId = "ZYN_Plan Card";

    layout
    {
        area(Content)
        {
            repeater(Plan)
            {
                Editable = false;
                field("Plan ID"; Rec."Plan ID")
                {
                }
                field("Plan Name"; Rec."Plan Name")
                {
                }
                field("Monthly Fee"; Rec."Monthly Fee")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Inactive)
            {
                Caption = 'Inactive';
                Image = Stop;
                trigger OnAction()
                var
                    Plan: Record "ZYN_Plan Table";
                    Subscription: Record "ZYN_Subscription Table";
                begin
                    CurrPage.SetSelectionFilter(Plan);
                    if Plan.FindSet() then
                        repeat
                            // Update subscriptions linked to this plan
                            Subscription.Reset();
                            Subscription.SetRange("Plan ID", Plan."Plan ID"); // adjust to your field name
                            if Subscription.FindSet() then
                                repeat
                                    Subscription.Status := Subscription.Status::Inactive;
                                    Subscription.Modify(true);
                                until Subscription.Next() = 0;
                        until Plan.Next() = 0;
                end;
            }
            action(Delete)
            {
                Caption = 'Delete ';
                Image = Delete;
                trigger OnAction()
                var
                    Plan: Record "ZYN_Plan Table";
                    Subscription: Record "ZYN_Subscription Table";
                    Confirmed: Boolean;
                begin
                    CurrPage.SetSelectionFilter(Plan);

                    if not Confirm('Do you want to delete all inactive subscriptions for the selected plan(s)?', false) then
                        exit;

                    if Plan.FindSet() then
                        repeat
                            Subscription.Reset();
                            Subscription.SetRange("Plan ID", Plan."Plan ID"); // adjust to your actual field name
                            Subscription.SetRange(Status, Subscription.Status::Inactive); // only inactive
                            if Subscription.FindSet() then
                                repeat
                                    Subscription.Delete(true);
                                until Subscription.Next() = 0;
                        until Plan.Next() = 0;

                    Message('All inactive subscriptions for the selected plan(s) have been deleted.');
                end;
            }
        }
    }
}