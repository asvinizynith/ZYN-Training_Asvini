page 50128 ZYN_MyCue
{
    PageType = Cardpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'ZYN_MyCue';
    SourceTable = "ZYN_Customer Visit Log";
    layout
    {
        area(Content)
        {
            cuegroup(VisitLog)
            {
                Caption = 'Visit Log';
                field("CustomerCue"; Count)
                {
                    Style = Ambiguous;
                    Caption = 'Visit Log';
                    trigger OnDrillDown()
                    var
                        CustomerList: Page "Customer List";
                        Visit: Record "ZYN_Customer Visit Log";
                        Customer: Record Customer;
                        TempCustomer: Record Customer temporary;
                    begin
                        Visit.Reset();
                        Visit.SetRange("Date", WorkDate());
                        if Visit.FindSet() then begin
                            repeat
                                if Customer.Get(Visit."Customer Number") then begin
                                    if not TempCustomer.Get(Visit."Customer Number") then begin
                                        TempCustomer := Customer;
                                        TempCustomer.Insert();
                                    end;
                                end;
                            until Visit.Next() = 0;
                        end;
                        Page.RunModal(Page::"Customer List", TempCustomer);
                    end;
                }
            }
        }
    }
    var
        Count: Integer;

    trigger OnOpenPage()
    begin
        Count := GetCustomerCount();
    end;

    local procedure GetCustomerCount(): Integer
    var
        Visit: Record "ZYN_Customer Visit Log";
        Today: Date;
        Count: Integer;
    begin
        Today := WorkDate(); // Get current BC work date

        Visit.SetRange("Date", Today);
        Count := Visit.Count();
        exit(Count);
    end;
}


