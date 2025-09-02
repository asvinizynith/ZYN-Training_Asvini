report 50165 "Sales Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Sales Report.RDL';

    dataset
    {
        dataitem("Company Information"; "Company Information")
            {
                column("CompanyName"; Name)
                {
                    IncludeCaption = true;
                }
                column(CompanyLogo; Picture)
                {
                    IncludeCaption = true;
                }
                column(CompanyAddress; Address)
                {
                    IncludeCaption = true;
                }
            
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            PrintOnlyIfDetail = true;
            column(No_; "No.")
            {
                IncludeCaption = true;
            }
            column("Customer_Name"; "Sell-to Customer Name")
            {
                IncludeCaption = true;
            }
            column(Posting_Date; "Posting Date")
            {
                IncludeCaption = true;
            }
            column(Document_Date; "Document Date")
            {
                IncludeCaption = true;
            }
             dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemTableView = sorting("Document No.");
                    DataItemLink = "Document No." = field("No.");

                    column(Document_No_; "Document No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(Line_Amount; "Line Amount")
                    {
                        IncludeCaption = true;
                    }
                    column(Quantity; Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(Unit_Price; "Unit Price")
                    {
                        IncludeCaption = true;
                    }}
                    dataitem("Customerledger";"Cust. Ledger Entry")
                    {
                        DataItemTableView = sorting("customer No.");
                         DataItemLink = "Document No." = field("No."),"Customer No."=field("Sell-to Customer No.");
                        column(Cus_Description ;Description)
                        {
                            IncludeCaption=true;
                        }
                        column(Amount;Amount)
                        {
                            IncludeCaption=true;
                        }
                        column(Remaining_Amount;"Remaining Amount")
                        {
                            IncludeCaption=true;
                        }  
            
                    }
                dataitem("Begintextcode;"; "Text Code Table")
                {
                    DataItemLinkReference = "Sales Invoice Header";
                    DataItemTableView =sorting(No,"Line No") WHERE(Selection = CONST("Textcode Selection"::BeginningText));

                    DataItemLink = No = field("No.");
                    column(BeginingText; text)
                    {
                        IncludeCaption = true;
                    }
                }
                    dataitem("Endtextcode;"; "Text Code Table")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView =sorting(No,"Line No") WHERE(Selection = CONST("Textcode Selection"::EndingText));

                        DataItemLink = No = field("No.");
                        column(EndingText; text)
                        {
                            IncludeCaption = true;
                        }
                    }
                }
            }
            
    }
               
            }
    


        

    


    



