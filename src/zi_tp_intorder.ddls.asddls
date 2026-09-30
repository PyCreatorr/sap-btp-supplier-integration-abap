@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Orders for Integration'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TP_IntOrder as select from ztp_int_order
{
    key order_id            as OrderId,
    supplier                as Supplier,
    material                as Material,
    quantity                as Quantity,
    delivery_date           as DeliveryDate,
    integration_status      as IntegrationStatus,
    supplier_order_id       as SupplierOrderId,
    confirmed_delivery_date as ConfirmedDeliveryDate
}
