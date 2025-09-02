page 50125 Myrolecenter 

{
    PageType = RoleCenter;
    Caption = 'My Role Center Asvini';
    ApplicationArea = All;
layout
{
    area(RoleCenter)
    {
        part(myCue; 50128)
        {
            ApplicationArea = All;
            Caption = 'My Cue';
            //SubPageLink = "Customer Number" = field("Customer Number");
        }
    }
}
    actions
    {
        area(Sections)
        {
            group(Sales)
            {
                caption = 'Sales';
                action(salesOrders)
                {
                    Caption = 'sales orders';
                    RunObject = page "Sales Order";
                    ApplicationArea = All;
                }
                action(salesQuotes)
                {
                    Caption = 'sales qutoes';
                    RunObject = page "Sales Quote";
                    ApplicationArea = All;
                }
                action(salesInvoices)
                {
                    Caption = 'sales invoices';
                    RunObject = page "Sales Invoice";
                    ApplicationArea = All;
                
                
                }
            }
           
        }
        area(Embedding)
        {
            action(Customers)
            {
                Caption = 'Customers';
                RunObject = page "Customer List";
           ApplicationArea = All;
            
        }
    }
}
}

profile Zynith
{
    ProfileDescription = 'Zynith';
    RoleCenter = Myrolecenter;
    Caption = 'Zynith';
}
   
    
    