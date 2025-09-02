report 50162 BulkPosting
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
   ProcessingOnly = true;
   Caption ='BulkPosting';
    
    dataset
    {
        dataitem(SalesInvoice; "Sales Header")
    
        {
            RequestFilterFields = "No.", "Document Type";
        trigger OnAfterGetRecord()
        begin
            SalesInvoice.SetRange("Document Type","Document Type"::Invoice);
            SalesPost.Run(SalesInvoice);
            invoicecount :=invoicecount +1;
        end;
        }
    }
    
    
var
SalesPost: Codeunit "Sales-Post";
invoicecount : Integer;
trigger OnPostReport()
    begin
        Message('There are %1  sales invoices posted', "invoiceCount");
    end;

    }
    
    
    
    
