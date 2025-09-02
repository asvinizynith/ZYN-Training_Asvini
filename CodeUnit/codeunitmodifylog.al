codeunit 50108 CustomerChangeTracker
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnCustomerModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        RecRef: RecordRef;
        xRecRef: RecordRef;
        FieldRef: FieldRef;
        xFieldRef: FieldRef;
        ModifyLog: Record "Modify Log Table";
        i: Integer;
        CurrentUser: Code[50];
        FieldName: Text[50];
    begin
        CurrentUser := UserId();

        RecRef.GetTable(Rec);
        xRecRef.GetTable(xRec);

        for i := 1 to RecRef.FieldCount do begin
            FieldRef := RecRef.FieldIndex(i);
            xFieldRef := xRecRef.FieldIndex(i);

            // Only track specific fields
            /* case FieldRef.Number of
                 3,    // Name
                 4,    // Name 2
                 5,    // Address
                 7,    // City
                 9,    // Post Code
                 10,   // Country/Region Code
                 22,   // Language Code
                 10000: // Payment Terms Code (custom field or adjust based on actual field ID)*/
            begin
                if Format(FieldRef.Value) <> Format(xFieldRef.Value) then begin
                    FieldName := FieldRef.Name;

                    ModifyLog.Init();
                    ModifyLog."Entry Number":= 0;
                    ModifyLog."No" := Rec."No.";
                    ModifyLog."Field Name" := FieldName;
                    ModifyLog."Old Value" := Format(xFieldRef.Value);
                    ModifyLog."New Value" := Format(FieldRef.Value);
                    ModifyLog."User ID" := CurrentUser;
                    ModifyLog.Insert();
                end;
            end;
        end;
    end;

}

