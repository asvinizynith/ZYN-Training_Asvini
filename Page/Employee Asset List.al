page 50120 "Employee Asset List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Employee Asset List';
    SourceTable = "Employee Asset Table";
    UsageCategory = Administration;
    CardPageId = "Employee Asset Card";

    layout
    {
        area(Content)
        {
            repeater(AssetDetails)
            {
                Editable = false;
                field("Entry No"; Rec."Entry No")
                {

                }
                field("Employee ID"; Rec."Employee ID")
                {

                }
                field("Serial No"; Rec."Serial No")
                {

                }
                field("Asset Name"; Rec."Asset Name")
                {

                }

                field(Status; Rec.Status)
                {

                }
                field("Assigned Date"; Rec."Assigned Date")
                {

                }
                field("Returned Date"; Rec."Returned Date")
                {

                }
                field("Lost Date"; Rec."Lost Date")
                {

                }

            }

        }
    }
}