page 50102 "ZYN_Customer Visit Log List"
{
    PageType = List;
    SourceTable = "ZYN_Customer Visit Log";
    CardPageId = "ZYN_Customer Visit Log Card";
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    Caption = 'ZYN_Customer Visit Log List';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Customer Number"; Rec."Customer Number")
                {
                }
                field("Date"; Rec."Date")
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