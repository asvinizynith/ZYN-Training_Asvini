page 50122 "ZYN_Assets History FactBox"
{
    PageType = CardPart;
    SourceTable = "ZYN_Employee Asset Table";
    ApplicationArea = All;
    Caption = 'ZYN_Assets History FactBox';

    layout
    {
        area(content)
        {
            cuegroup("Assets")
            {
                field("Assets count"; Assetscount)
                {
                    DrillDown = true;
                    Caption = 'Assets count';
                    trigger OnDrillDown()
                    var
                        AssetHistory: Record "ZYN_Employee Asset Table";
                    begin
                        AssetHistory.Reset();
                        AssetHistory.SetRange("Employee ID", Rec."Employee ID");
                        PAGE.Run(PAGE::"ZYN_Employee Asset List", AssetHistory);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        AssetHistory: Record "ZYN_Employee Asset Table";
    begin
        AssetHistory.Reset();
        AssetHistory.SetRange("Employee ID", Rec."Employee ID");
        Assetscount := AssetHistory.Count();
    end;

    var
        Assetscount: Integer;
}
