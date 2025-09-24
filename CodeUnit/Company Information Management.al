codeunit 50127 "ZYN_Company Information Manage"
{
    var
        SyncInProgress: Boolean;

    local procedure StartSync(): Boolean
    begin
        if SyncInProgress then
            exit(false);
        SyncInProgress := true;
        exit(true);
    end;

    local procedure EndSync()
    begin
        SyncInProgress := false;
    end;
    // --- INSERT ---
    [EventSubscriber(ObjectType::Table, Database::"ZYN_Companies Table", 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterInsertMyCompany(var Rec: Record "ZYN_Companies Table"; RunTrigger: Boolean)
    var
        BCCompany: Record Company;
    begin
        if not StartSync() then
            exit;
        if not BCCompany.Get(Rec.Name) then begin
            BCCompany.Init();
            BCCompany.TransferFields(Rec);
            // Add any other fields you maintain
            BCCompany.Insert(true);
        end;
        EndSync();
    end;

    // --- MODIFY ---
    [EventSubscriber(ObjectType::Table, Database::"ZYN_Companies Table", 'OnAfterModifyEvent', '', true, true)]
    local procedure OnAfterModifyMyCompany(var Rec: Record "ZYN_Companies Table"; RunTrigger: Boolean)
    var
        BCCompany: Record Company;
    begin
        if not StartSync() then
            exit;
        if BCCompany.Get(Rec.Name) then begin
            if (BCCompany."Display Name" <> Rec."Display Name") or (BCCompany."Evaluation Company" <> Rec."Evaluation Company") then begin
                BCCompany."Display Name" := Rec."Display Name";
                BCCompany."Evaluation Company" := Rec."Evaluation Company";
            end;
            // Sync other fields
            BCCompany.Modify(true);
        end;
        EndSync();
    end;

    // --- DELETE ---
    [EventSubscriber(ObjectType::Table, Database::"ZYN_Companies Table", 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnAfterDeleteMyCompany(var Rec: Record "ZYN_Companies Table"; RunTrigger: Boolean)
    var
        BCCompany: Record Company;
    begin
        if not StartSync() then
            exit;
        if BCCompany.Get(Rec.Name) then begin
            BCCompany.Delete(true);
        end;
        EndSync();
    end;

    // --- INSERT ---
    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterInsertCompany(var Rec: Record "Company"; RunTrigger: Boolean)
    var
        MyCompany: Record "ZYN_Companies Table";
    begin
        if not StartSync() then
            exit;
        if not MyCompany.Get(Rec.Name) then begin
            MyCompany.Init();
            MyCompany.TransferFields(Rec);
            // Add any other fields you maintain
            MyCompany.Insert(true);
        end;
        EndSync();
    end;

    // --- MODIFY ---
    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterModifyEvent', '', true, true)]
    local procedure OnAfterModifyCompany(var Rec: Record "Company"; RunTrigger: Boolean)
    var
        MyCompany: Record "ZYN_Companies Table";
    begin
        if not StartSync() then
            exit;
        if MyCompany.Get(Rec.Name) then begin
            if (MyCompany."Display Name" <> Rec."Display Name") or (MyCompany."Evaluation Company" <> Rec."Evaluation Company") then begin
                MyCompany."Display Name" := Rec."Display Name";
                MyCompany."Evaluation Company" := Rec."Evaluation Company";
            end;
            ;
        end;
        EndSync();
    end;

    // --- DELETE ---
    [EventSubscriber(ObjectType::Table, Database::"Company", 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnAfterDeleteCompany(var Rec: Record "Company"; RunTrigger: Boolean)
    var
        MyCompany: Record "ZYN_Companies Table";
    begin
        if not StartSync() then
            exit;
        if MyCompany.Get(Rec.Name) then begin
            MyCompany.Delete(true);
        end;
        EndSync();
    end;
}
