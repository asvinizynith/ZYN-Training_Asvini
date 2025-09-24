page 50135 "ZYN_Update Field"
{
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'ZYN_Update Field';

    layout
    {
        area(Content)
        {
            field(TableName; TableName)
            {
                Editable = true;
                Caption = 'TableName';
                TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
            }
            field(FieldName; FieldName)
            {
                Editable = true;
                Caption = 'FieldName';
                trigger OnDrillDown()
                var
                    RecRef: RecordRef;
                    FieldRef: FieldRef;
                    TempBuffer: Record "ZYN_Buffer Table" temporary;
                    i: Integer;
                    FN: text;
                begin
                    if TableName = 0 then
                        Error('Please select a table first.');

                    RecRef.Open(TableName);

                    for i := 1 to RecRef.FieldCount do begin
                        FieldRef := RecRef.FieldIndex(i);
                        TempBuffer.Init();
                        TempBuffer."Field ID" := FieldRef.Number;
                        FN := FieldRef.Name;
                        TempBuffer."Field Name" := FN;
                        TempBuffer.Insert();
                    end;
                    RecRef.Close();

                    if Page.RunModal(Page::"ZYN_Buffer Table List", TempBuffer, selectedfield) = Action::LookupOK then begin

                        FieldID := TempBuffer."Field ID";
                        FieldName := TempBuffer."Field Name";
                    end;
                end;
            }
            field(RecordSelection; RecordSelection)
            {
                Editable = true;
                Caption = 'RecordSelection';
                trigger OnDrillDown()
                var
                    RecRef: RecordRef;
                    FieldRef: FieldRef;
                    Linecounter: Integer;
                    FieldDataBuffer: Record "ZYN_Buffer Table" temporary;
                begin
                    if (TableName = 0) OR (FieldID = 0) then
                        Error('Please select a table first.');
                    RecRef.Open(TableName);
                    FieldRef := RecRef.Field(FieldID);

                    if RecRef.FindSet() then begin
                        repeat
                            Linecounter += 1;
                            FieldDataBuffer.Init();
                            FieldDataBuffer."Field ID" := Linecounter;
                            FieldDataBuffer."Record Selection" := Format(FieldRef.Value);
                            FieldDataBuffer."Record ID" := RecRef.RecordId;
                            FieldDataBuffer.Insert();

                        until RecRef.Next() = 0;
                    end;
                    RecRef.Close();
                    if Page.RunModal(Page::"ZYN_Buffer Table List", FieldDataBuffer, selectedfield) = Action::LookupOK then begin
                        RecordSelection := FieldDataBuffer."Record SElection";
                        valueID := FieldDataBuffer."Record ID";
                    end;
                end;
            }
            field(ValueEnter; ValueEnter)
            {
                Caption = 'Value';
                trigger OnValidate()
                var
                    RecRef: RecordRef;
                    FieldRef: FieldRef;
                begin

                    RecRef.Open(TableName);
                    if not RecRef.Get(valueID) then
                        Error('Could not find the selected record.');

                    FieldRef := RecRef.Field(FieldID);
                    FieldRef.Value := ValueEnter;
                    RecRef.Modify();
                    Message('Value updated successfully.');
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        TableName: Integer;
        FieldName: Text[50];
        ValueEnter: Text[50];
        FieldID: Integer;
        FieldValue: Text[50];
        selectedfield: Integer;
        RecordSelection: Text[50];
        valueID: RecordId;
}