pageextension 50120 MyExtension extends "Customer List"
{
    actions
    {
        addafter(ApplyTemplate)
        {
            action(NewPurchaseOrder)
            {
                ApplicationArea = All;
                Caption = 'Purchase Order';
                Image = Document;
                RunObject = Page "Purchase Order";
                RunPageLink = "Buy-from Vendor No." = field("No.");
                RunPageMode = Create;
                ToolTip = 'Create a purchase order for the customer.';
                Promoted = true;
                PromotedCategory = Process;
            }
            action(NewPurchaseOrder2)
            {
                ApplicationArea = All;
                Caption = 'Purchase Order OnAction';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.Init();
                    PurchaseHeader."No." := '';
                    PurchaseHeader.Validate("Buy-from Vendor No.", Rec."No.");
                    PurchaseHeader.Insert(true);
                    Page.Run(Page::"Purchase Order", PurchaseHeader);
                end;
            }
        }
    }
}
