pageextension 50168 "CustomerListfactboxext" extends "Customer List"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(CustomerSalesFB; "ZYN_Customer Sales FactBox")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
                Caption = 'Customer Sales FactBox';
            }
        }
    }
}
