page 50121 "Assigned Assets FactBox"
{
    PageType = CardPart;
    SourceTable = "Employee Asset Table";
    ApplicationArea = All;
    Caption = 'Assigned Assets FactBox';

    layout
    {
        area(content)
        {
            cuegroup("Assigned Assets")
            {
                field("Assigned Assets count"; AssignedAssets)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Assigned Assets count';
                    trigger OnDrillDown()
                    var
                        EmployeeAsset: Record "Employee Asset Table";
                    begin
                        EmployeeAsset.Reset();
                        EmployeeAsset.SetRange(Status, Rec.Status::Assigned);
                        PAGE.Run(PAGE::"Employee Asset List", EmployeeAsset);
                    end;
                }

            }


        }
    }
    trigger OnAfterGetRecord()
    var
        EmployeeAsset: Record "Employee Asset Table";
    begin
        EmployeeAsset.Reset();
        EmployeeAsset.SetRange(Status, Rec.Status::Assigned);
        AssignedAssets := EmployeeAsset.Count();
    end;


    var
        AssignedAssets: Integer;
}
