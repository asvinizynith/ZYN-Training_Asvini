page 50141 MyCustomerList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {

                field("No."; Rec."No.")

                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;

                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;

                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("State"; Rec."County")
                {
                    ApplicationArea = All;
                }
            }
                    part("Saleorder"; "salesorder")
                    {
                        SubPageLink = "Sell-to Customer Name" = field(Name);
                    }
                    part("SalesInvoice"; "SalesInvoice")
                    {
                        SubPageLink = "Sell-to Customer Name" = field(Name);
                    }
                    part("SalesCreditMemo"; "SalesCreditMemo")
                    {
                        SubPageLink = "Sell-to Customer Name" = field(Name);
                    }

                }
            }

        }

    





