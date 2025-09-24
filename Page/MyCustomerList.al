page 50141 "ZYN_My Customer List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    Editable = false;
    Caption='ZYN_My Customer List';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("State"; Rec."County")
                {
                }
            }
                    part("Saleorder"; "ZYN_Sales Order")
                    {
                        SubPageLink = "Sell-to Customer Name" = field(Name);
                    }
                    part("SalesInvoice"; "ZYN_Sales Invoice")
                    {
                        SubPageLink = "Sell-to Customer Name" = field(Name);
                    }
                    part("SalesCreditMemo"; "ZYN_Sales Credit Memo")
                    {
                        SubPageLink = "Sell-to Customer Name" = field(Name);
                    }
                }
            }
        }

    





