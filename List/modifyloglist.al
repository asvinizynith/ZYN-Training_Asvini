page 50106 "Modify Log List"
{
    PageType = List;
    SourceTable = "Modify Log Table";
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry Number"; Rec."Entry Number")
                {
                    ApplicationArea = All;
                    Caption = 'Entry Number';
                }
                field(" No"; Rec."No")
                {
                    ApplicationArea = All;
                    Caption = 'Customer No';
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    Caption = 'Field Name';
                }
                field("Old Value"; Rec."Old Value")
                {
                    ApplicationArea = All;
                    Caption = 'Old Value';
                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = All;
                    Caption = 'New Value';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                }
            }
        }
    }
}