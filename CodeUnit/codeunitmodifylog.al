codeunit 50108 "ZYN_ModifyLog Management"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnCustomerModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        RecRef: RecordRef;
        xRecRef: RecordRef;
        FieldRef: FieldRef;
        xFieldRef: FieldRef;
        ModifyLog: Record "ZYN_Modify Log Table";
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
            begin
                if Format(FieldRef.Value) <> Format(xFieldRef.Value) then begin
                    FieldName := FieldRef.Name;
                    ModifyLog.Init();
                    ModifyLog."Entry Number" := 0;
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

