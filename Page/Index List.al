page 50170 "Index List"
{
    ApplicationArea = All;
    Caption = 'Index List';
    PageType = List;
    SourceTable = "Index Table";
    UsageCategory = Administration;
    CardPageId = "Index Card"; // Ensures standard 'New' works too
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code") { }
                field(Description; Rec.Description) { }
                field("Percentage Increase"; Rec."Percentage Increase") { }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(New)
            {
                ApplicationArea = All;
                Caption = 'New';
                Image = New;
                trigger OnAction()
                var
                    NewIndex: Record "Index Table";
                begin
                    Clear(NewIndex);
                    NewIndex.Init();
                    PAGE.RunModal(PAGE::"Index Card", NewIndex);
                end;
            }
        }
    }
}

