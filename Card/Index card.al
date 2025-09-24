page 50169 "ZYN_Index Card"
{
    ApplicationArea = All;
    Caption = 'ZYN_Index Card';
    PageType = Card;
    SourceTable = "ZYN_Index Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec."Code")
                {

                 }
                field(Description; Rec.Description)
                { }
                field("Percentage Increase"; Rec."Percentage Increase")
                { }
                field("Start Year"; Rec."Start Year")
                { }
                field("End Year"; Rec."End Year")
                { }
            }
            part(IndexLines; "ZYN_Index Lines List Part")
            {
                ApplicationArea = All;
                Caption = 'Index Lines';
                SubPageLink = "Code" = field("Code");
            }
        }
    }
}