page 50106 "ZYN_Modify Log List"
{
    PageType = List;
    SourceTable = "ZYN_Modify Log Table";
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    Caption = 'ZYN_Modify Log List';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(" No"; Rec."No")
                {
                    Caption = 'Customer No';
                }
                field("Field Name"; Rec."Field Name")
                {
                    Caption = 'Field Name';
                }
                field("Old Value"; Rec."Old Value")
                {
                    Caption = 'Old Value';
                }
                field("New Value"; Rec."New Value")
                {
                    Caption = 'New Value';
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'User ID';
                }
            }
        }
    }
}