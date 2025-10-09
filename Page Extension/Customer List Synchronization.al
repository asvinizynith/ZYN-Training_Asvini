pageextension 50100 CustomerListExt extends "Customer List"
{
    actions
    {
        addlast(Processing)
        {
            action(SendToCustomer)
            {
                Caption = 'Send To Customer';
                ApplicationArea = All;
                Image = SendTo;

                trigger OnAction()
                var
                    Customer: Record Customer;
                    Selection: Integer;
                    SelectedCompany: Text;
                    SyncCodeunit: Codeunit Zyn_CustomerVendorContactSync;
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.IsEmpty() then
                        Error('Please select at least one customer.');

                    // Select target company
                    Selection := StrMenu(GetCompanyList(), 1, 'Select a slave company');
                    if Selection = 0 then
                        exit;

                    SelectedCompany := GetCompanyByIndex(Selection);

                    SyncCodeunit.SyncCustomer(Rec."No.", SelectedCompany);

                    Message('Selected customers synced to %1 successfully.', SelectedCompany);
                end;
            }
        }
    }

    local procedure GetCompanyList(): Text
    var
        CompanyRec: Record "ZYN_Companies Table";
        MenuString: Text;
    begin
        if CompanyRec.FindSet() then
            repeat
                if CompanyRec.Name <> CompanyName then
                    MenuString += CompanyRec.Name + ',';
            until CompanyRec.Next() = 0;
        exit(MenuString);
    end;

    local procedure GetCompanyByIndex(Index: Integer): Text
    var
        CompanyRec: Record "ZYN_Companies Table";
        Counter: Integer;
    begin
        Counter := 0;
        if CompanyRec.FindSet() then
            repeat
                if CompanyRec.Name <> CompanyName then begin
                    Counter += 1;
                    if Counter = Index then
                        exit(CompanyRec.Name);
                end;
            until CompanyRec.Next() = 0;
        exit('');
    end;
}
