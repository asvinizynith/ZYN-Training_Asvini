page 50127 "ZYN_Subscription Card"
{
    ApplicationArea = All;
    Caption = 'ZYN_Subscription Card';
    PageType = Card;
    SourceTable = "ZYN_Subscription Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Subscription ID"; Rec."Subscription ID")
                {
                }
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