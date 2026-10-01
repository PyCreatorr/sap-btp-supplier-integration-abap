@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Orders for OData Service'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_TP_INTORDER 
    provider contract transactional_query
    as projection on ZI_TP_IntOrder

{   

    key OrderId,
    Supplier,
    Material,
    Quantity,
    DeliveryDate,
    IntegrationStatus,
    SupplierOrderId,
    ConfirmedDeliveryDate
}
