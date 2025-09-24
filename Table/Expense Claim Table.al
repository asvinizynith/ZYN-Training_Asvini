table 50118 "ZYN_Expense Claim Table"
{
    Caption = 'Expense Claim Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Employee ID"; Code[20])
        {
            Caption = 'Employee ID';
            TableRelation = "ZYN_Employee Table"."Employee ID";
        }
        field(3; "Category Code"; Code[30])
        {
            Caption = 'Category Code';
        }
        field(4; "Category Name"; Text[50])
        {
            Caption = 'Category Name';
            Editable = false;
        }
        field(5; Subtype; Text[50])
        {
            Caption = 'Subtype';
            Editable = false;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            trigger OnValidate()
            var
                Expenseclaimcategory: Record "ZYN_Expense Claim Category";
            begin
                if Expenseclaimcategory.Get("Category Code", Subtype, "Category Name") then begin
                    if Amount > Expenseclaimcategory."Amount Limit" then
                        Error('Amount Exceeds The Limit');
                end;
            end;
        }
        field(9; "Bill Date"; Date)
        {
            Caption = 'Bill Date';
        }
        field(7; "Claim Date"; Date)
        {
            Caption = 'Claim Date';
            trigger OnValidate()
            begin
                if ("Bill Date" <> 0D) and ("Claim Date" <> 0D) then begin
                    if "Claim Date" > CalcDate('<+3M>', "Bill Date") then
                        Error('The Claim Date cannot be more than 3 months after the Bill Date (%1).', "Bill Date");
                end;
            end;
        }
        field(8; Status; Enum "ZYN_Expense Claim Status")
        {
            Caption = 'Status';
        }
        field(10; "Bill Copy"; Blob)
        {
            Caption = 'Bill Copy';
            Subtype = Memo;
        }
        field(12; "File Name"; Text[30])
        {
        }
        field(11; Remarks; Text[100])
        {
            Caption = 'Remarks';
        }
    }
    keys
    {
        key(PK; "Category Code", "Entry No.", Subtype, "Employee ID")
        {
            Clustered = true;
        }
    }
}
