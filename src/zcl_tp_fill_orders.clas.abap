CLASS zcl_tp_fill_orders DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tp_fill_orders IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.

    DATA lt_orders TYPE TABLE OF ztp_int_order.

    " Demo table reset
    DELETE FROM ztp_int_order.

    lt_orders = VALUE #(
        (  order_id = '450000001' supplier = 'SUPPLIER_A' material = 'MAT-100' quantity = 500 delivery_date = '20260920' integration_status = 'NEW' )
        (  order_id = '450000002' supplier = 'SUPPLIER_B' material = 'MAT-200' quantity = 250 delivery_date = '20260919' integration_status = 'NEW' )
        (  order_id = '450000003' supplier = 'SUPPLIER_A' material = 'MAT-100' quantity = 100 delivery_date = '20260918' integration_status = 'NEW' )
        (  order_id = '450000004' supplier = 'SUPPLIER_B' material = 'MAT-400' quantity = 120 delivery_date = '20260915' integration_status = 'NEW' )
    ).


    INSERT ztp_int_order FROM TABLE @lt_orders.

    SELECT *
        FROM ztp_int_order
        INTO TABLE @FINAL(result).

    out->write( |{ sy-dbcnt } purchase orders inserted. | ).
    out->write( result ).

    ENDMETHOD.
ENDCLASS.
