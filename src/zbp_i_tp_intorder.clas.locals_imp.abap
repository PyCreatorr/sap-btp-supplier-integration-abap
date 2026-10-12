CLASS lhc_PurchaseOrder DEFINITION INHERITING FROM cl_abap_behavior_handler.


  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR PurchaseOrder RESULT result.

    METHODS dispatch
      FOR MODIFY
      IMPORTING
        keys FOR ACTION PurchaseOrder~dispatch
      RESULT result.

    METHODS resetDemo
        FOR MODIFY
        IMPORTING keys FOR ACTION PurchaseOrder~resetDemo.

    METHODS changeMaterial
        FOR MODIFY
        IMPORTING keys FOR ACTION PurchaseOrder~changeMaterial
        RESULT result.


ENDCLASS.

CLASS lhc_PurchaseOrder IMPLEMENTATION.

  METHOD dispatch.
    MODIFY ENTITIES OF zi_tp_intorder IN LOCAL MODE
        ENTITY PurchaseOrder
                UPDATE FIELDS ( IntegrationStatus )
                WITH VALUE #(
                FOR key IN keys
              (
                %tky = key-%tky
                IntegrationStatus = 'DISPATCH_REQUESTED'
               )
             )
         FAILED failed
         REPORTED reported.

    READ ENTITIES OF zi_tp_intorder IN LOCAL MODE
        ENTITY PurchaseOrder
            ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(orders).
    result = VALUE #(
        FOR order IN orders
            (
              %tky = order-%tky
              %param = order
            )
     ).


  ENDMETHOD.


  METHOD resetDemo.
    SELECT order_id
    FROM ztp_int_order INTO TABLE @DATA(lt_orders).

    MODIFY ENTITIES OF zi_tp_intorder IN LOCAL MODE
        ENTITY PurchaseOrder
            UPDATE FIELDS (
                IntegrationStatus
                SupplierOrderId
                ConfirmedDeliveryDate
             )
             WITH VALUE #(
                FOR ls_order IN lt_orders (
                    OrderId = ls_order-order_id
                    IntegrationStatus = 'NEW'
                    SupplierOrderId = ''
                    ConfirmedDeliveryDate = '00000000'
                 )

              )
              FAILED failed
              REPORTED reported.


  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD changeMaterial.
    MODIFY ENTITIES OF zi_tp_intorder IN LOCAL MODE
        ENTITY PurchaseOrder
            UPDATE FIELDS ( Material )
            WITH VALUE #(
                FOR key IN keys (
                    %tky = key-%tky
                    Material = key-%param-Material
                )
            )
        FAILED failed
        REPORTED reported.

    READ ENTITIES OF zi_tp_intorder IN LOCAL MODE
        ENTITY PurchaseOrder
            ALL FIELDS WITH CORRESPONDING #( keys )
           RESULT DATA(orders).

    result = VALUE #(
        FOR order IN orders (
            %tky = order-%tky
            %param = order
         )
    ).


  ENDMETHOD.

ENDCLASS.
