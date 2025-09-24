page 50182 "ZYN_Income List"
{
    ApplicationArea = All;
    Caption = 'ZYN_Income Tracker';
    PageType = List;
    SourceTable = "ZYN_Income Table";
    UsageCategory = Administration;
    CardPageId = "ZYN_Income Card"; // Ensures standard 'New' works too
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Income Description"; Rec."Income Description")
                {
                }
                field("Income Amount"; Rec."Income Amount")
                {
                }
                field("Income Date"; Rec."Income Date")
                {
                }
                field("Income Category"; Rec."Income Category")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Action)
            {
                Caption = 'Income Category List';
                Image = List;
                RunObject = page "ZYN_Income Category List";
            }
            action(IncomeTracker)
            {
                Caption = 'Income Tracker Report';
                Image = Report;
                RunObject = report "ZYN_Income Tracker Report";
            }
        }
    }
}