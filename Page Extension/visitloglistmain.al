// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.customervisitlog;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
pageextension 50111 CustomerCardExt extends "Customer Card"
{
    actions
    {
        addlast(Processing)
        {
            action(VisitLog)
            {
                ApplicationArea = All;
                Caption = 'Visit Log';
                Image = View; // Optional - you can choose an icon
                trigger OnAction()
                begin
                    PAGE.Run(PAGE::"Customer Visit Log List");
                end;
            }
        }
    }
}