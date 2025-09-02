table 50169 "Index Table"
{
    Caption = 'Index Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Percentage Increase"; Decimal)
        {
            Caption = 'Percentage Increase';
        }
        field(4; "Start Year"; Integer)
        {
            Caption = 'Start Year';
        }
        field(5; "End Year"; Integer)
        {
            Caption = 'End Year';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        IndexLine: Record "Index Lines";
    begin

        GenerateLinesForCode();
    end;

    trigger OnModify()

    begin
        GenerateLinesForCode();
    end;

    trigger OnDelete()
    var
        IndexLine: Record "Index Lines";
    begin
        IndexLine.SetRange("Code", Rec."Code");
        if IndexLine.FindSet() then
            IndexLine.DeleteAll();
    end;

    local procedure GenerateLinesForCode()
    var
        IndexLine: Record "Index Lines";

        Year: Integer;
        CurrentValue: Decimal;
        StartYear: Integer;
        EndYear: Integer;
        PctIncrease: Decimal;
    begin
        IndexLine.SetRange("Code", rec.Code);
        if IndexLine.FindSet() then
            IndexLine.DeleteAll();
        if (Rec."Start Year" = 0) or (Rec."End Year" = 0) or (Rec."Percentage Increase" = 0) then
            exit;

        CurrentValue := 100; // Or: IndexTable."Start Value

        for Year := "Start Year" to "End Year" do begin
            IndexLine.Init();
            IndexLine."Entry No" := 0;
            IndexLine."Code" := Rec.Code;
            IndexLine.Year := Year;
            IndexLine.Value := Round(CurrentValue, 0.01);
            IndexLine.Insert();
            CurrentValue := CurrentValue * (1 + ("Percentage Increase" / 100));
            StartYear += 1;
        end;
    end;

}