page 50170 "ZYN_Index List"
{
    ApplicationArea = All;
    Caption = 'ZYN_Index List';
    PageType = List;
    SourceTable = "ZYN_Index Table";
    UsageCategory = Administration;
    CardPageId = "ZYN_Index Card"; // Ensures standard 'New' works too
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Percentage Increase"; Rec."Percentage Increase")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(New)
            {
                Caption = 'New';
                Image = New;
                trigger OnAction()
                var
                    NewIndex: Record "ZYN_Index Table";
                begin
                    Clear(NewIndex);
                    NewIndex.Init();
                    PAGE.RunModal(PAGE::"ZYN_Index Card", NewIndex);
                end;
            }
        }
    }
}

