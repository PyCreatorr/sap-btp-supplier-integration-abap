CLASS zcl_tp_cpi_client DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      TYPES:
      BEGIN OF ty_response,
        status_code TYPE i,
        reason      TYPE string,
        body        TYPE string,
      END OF ty_response.

    METHODS dispatch_orders
        RETURNING VALUE(rs_response) TYPE ty_response
        RAISING
            cx_web_http_client_error
            cx_http_dest_provider_error.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tp_cpi_client IMPLEMENTATION.

    METHOD dispatch_orders.
        DATA(lo_destination) =
            cl_http_destination_provider=>create_by_cloud_destination(
            i_name = 'CPI_SUPPLIER_DISPATCH'
            i_authn_mode = if_a4c_cp_service=>service_specific
         ).

        DATA(lo_client) =
            cl_web_http_client_manager=>create_by_http_destination(
                i_destination = lo_destination
             ).

        DATA(lo_request) = lo_client->get_http_request(  ).

        lo_request->set_uri_path(
            i_uri_path = '/http/purchase-orders/dispatch'
         ).

         DATA(lo_response) =
            lo_client->execute(
                i_method = if_web_http_client=>get
             ).

         DATA(ls_status) = lo_response->get_status( ).

        rs_response-status_code = ls_status-code.
        rs_response-reason      = ls_status-reason.
        rs_response-body        = lo_response->get_text( ).

        lo_client->close( ).

    ENDMETHOD.


ENDCLASS.
