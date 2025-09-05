page 50126 "Plan List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Plan List';
    SourceTable = "Plan Table";
    UsageCategory = Administration;
    CardPageId = "Plan Card";

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
                ApplicationArea = All;
                Image = Stop;

                trigger OnAction()
                var
                    PlanRec: Record "Plan Table";
                    SubRec: Record "Subscription Table";
                begin
                    CurrPage.SetSelectionFilter(PlanRec);
                    if PlanRec.FindSet() then
                        repeat
                            // Update subscriptions linked to this plan
                            SubRec.Reset();
                            SubRec.SetRange("Plan ID", PlanRec."Plan ID"); // adjust to your field name
                            if SubRec.FindSet() then
                                repeat
                                    SubRec.Status := SubRec.Status::Inactive;
                                    SubRec.Modify(true);
                                until SubRec.Next() = 0;
                        until PlanRec.Next() = 0;


                end;
            }
            action(Delete)
            {
                Caption = 'Delete ';
                ApplicationArea = All;
                Image = Delete;

                trigger OnAction()
                var
                    PlanRec: Record "Plan Table";
                    SubRec: Record "Subscription Table";
                    Confirmed: Boolean;
                begin
                    CurrPage.SetSelectionFilter(PlanRec);

                    if not Confirm('Do you want to delete all inactive subscriptions for the selected plan(s)?', false) then
                        exit;

                    if PlanRec.FindSet() then
                        repeat
                            SubRec.Reset();
                            SubRec.SetRange("Plan ID", PlanRec."Plan ID"); // adjust to your actual field name
                            SubRec.SetRange(Status, SubRec.Status::Inactive); // only inactive

                            if SubRec.FindSet() then
                                repeat
                                    SubRec.Delete(true);
                                until SubRec.Next() = 0;
                        until PlanRec.Next() = 0;

                    Message('All inactive subscriptions for the selected plan(s) have been deleted.');
                end;
            }
        }
    }
}