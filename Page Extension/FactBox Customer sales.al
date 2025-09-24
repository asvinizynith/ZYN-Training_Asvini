pageextension 50167 "Customersalesfactboxext" extends "Customer Card"
{
    layout
    {
        addfirst(FactBoxes) // Add inside FactBoxes area
        {
            part(CustomerSalesFB; "ZYN_Customer Sales FactBox")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
                Caption='Customer Sales FactBox';
            }
        }
    }
}
