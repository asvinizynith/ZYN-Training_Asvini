pageextension 50167 "Customersalesfactboxext" extends "Customer Card"
{
    layout
    {
        addfirst(FactBoxes) // Add inside FactBoxes area
        {
            part(CustomerSalesFB; "Customer Sales FactBox")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
            
        }
    }
}
pageextension 50168 "CustomerListfactboxext" extends "Customer List"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(CustomerSalesFB; "Customer Sales FactBox")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
        }
    }
}
