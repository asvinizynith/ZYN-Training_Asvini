page 50122 "Assets History FactBox"
{
    PageType = CardPart;
    SourceTable = "Employee Asset Table";
    ApplicationArea = All;
    Caption = 'Assets History FactBox';

    layout
    {
        area(content)
        {
            cuegroup("Assets")
            {
                field("Assets count"; Assetscount)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Assets count';
                    trigger OnDrillDown()
                    var
                        AssetHistory: Record "Employee Asset Table";
                    begin
                        AssetHistory.Reset();
                        AssetHistory.SetRange("Employee ID", Rec."Employee ID");

                        PAGE.Run(PAGE::"Employee Asset List", AssetHistory);
                    end;
                }

            }


        }
    }
    trigger OnAfterGetRecord()
    var
        AssetHistory: Record "Employee Asset Table";
    begin
        AssetHistory.Reset();
        AssetHistory.SetRange("Employee ID", Rec."Employee ID");
        Assetscount := AssetHistory.Count();
    end;


    var
        Assetscount: Integer;
}
