page 50103 "ZYN_Customer Visit Log Card"
{
    PageType = Card;
    SourceTable = "ZYN_Customer Visit Log";
    ApplicationArea = All;
    Caption = 'ZYN_Customer Visit Log Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Customer Number"; Rec."Customer Number")
                {
                }
                field("Date"; Rec.Date)
                {
                }
                field("Purpose"; Rec."Purpose")
                {
                }
                field("Notes"; Rec."Notes")
                {
                }
            }
        }
    }
}