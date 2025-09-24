page 50150 "ZYN_Companies List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_Companies List';
    SourceTable = "ZYN_Companies Table";
    UsageCategory = Administration;
    CardPageId = "ZYN_Companies Card";

    layout
    {
        area(Content)
        {
            repeater(Details)
            {
                Editable = false;
                field(Name; Rec.Name)
                {
                }
                field("Display Name"; Rec."Display Name")
                {
                }
                field("Company Id"; Rec.Id)
                {
                }
                field("Evaluation Company"; Rec."Evaluation Company")
                {
                }
            }
        }
    }

}