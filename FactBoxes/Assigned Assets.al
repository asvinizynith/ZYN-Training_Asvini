page 50121 "ZYN_Assigned Assets FactBox"
{
    PageType = CardPart;
    SourceTable = "ZYN_Employee Asset Table";
    ApplicationArea = All;
    Caption = 'ZYN_Assigned Assets FactBox';

    layout
    {
        area(content)
        {
            cuegroup("Assigned Assets")
            {
                field("Assigned Assets count"; AssignedAssets)
                {
                    DrillDown = true;
                    Caption = 'Assigned Assets count';
                    trigger OnDrillDown()
                    var
                        EmployeeAsset: Record "ZYN_Employee Asset Table";
                    begin
                        EmployeeAsset.Reset();
                        EmployeeAsset.SetRange(Status, Rec.Status::Assigned);
                        PAGE.Run(PAGE::"ZYN_Employee Asset List", EmployeeAsset);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        EmployeeAsset: Record "ZYN_Employee Asset Table";
    begin
        EmployeeAsset.Reset();
        EmployeeAsset.SetRange(Status, Rec.Status::Assigned);
        AssignedAssets := EmployeeAsset.Count();
    end;

    var
        AssignedAssets: Integer;
}
