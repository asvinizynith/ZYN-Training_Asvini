page 50182 "Income List"
{
    ApplicationArea = All;
    Caption = 'Income Tracker';
    PageType = List;
    SourceTable = "Income Table";
    UsageCategory = Administration;
    CardPageId = "Income Card"; // Ensures standard 'New' works too
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Income Description"; Rec."Income Description") { }
                field("Income Amount"; Rec."Income Amount") { }
                field("Income Date"; Rec."Income Date") { }
                field("Income Category"; Rec."Income Category")
                {
                    ApplicationArea = All;

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
                ApplicationArea = All;
                Caption = 'Income Category List';
                Image = List;
                RunObject = page "Income Category List ";

            }
            action(IncomeTracker)
            {
                ApplicationArea = All;
                Caption = 'Income Tracker Report';
                Image = Report;
                RunObject = report "Income Tracker Report";
            }
        }
    }

}