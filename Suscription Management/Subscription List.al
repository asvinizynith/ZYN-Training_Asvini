page 50129 "Subscription List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Subscription List';
    SourceTable = "Subscription Table";
    UsageCategory = Administration;
    CardPageId = "Subscription Card";

    layout
    {
        area(Content)
        {
            repeater(Subscription)
            {
                Editable = false;

                field("Customer ID"; Rec."Customer ID")
                {

                }
                field("Plan ID"; Rec."Plan ID")
                {

                }
                field("Start Date"; Rec."Start Date")
                {

                }
                field(Duration; Rec.Duration)
                {

                }
                field("End Date"; Rec."End Date")
                {

                }
                field("Next Billing Date"; Rec."Next Billing Date")
                {

                }
                field(status; Rec.status)
                {

                }
                field("Next Renewal Date"; Rec."Next Renewal Date")
                {

                }
                field("Remainder Sent"; Rec."Remainder Sent")
                {

                }

            }

        }

    }
}