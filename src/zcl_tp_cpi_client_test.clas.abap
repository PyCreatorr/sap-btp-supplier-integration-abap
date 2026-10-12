CLASS zcl_tp_cpi_client_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_tp_cpi_client_test IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.

      TRY.
        " Prototype connectivity test for SAP Integration Suite.
        "
        " This class was used to verify direct HTTP connectivity from
        " SAP BTP ABAP Environment to the Integration Suite runtime
        " using a GET request.
        "
        " No productive credentials are stored in this class.

        " DATA(lo_cpi_client) = NEW zcl_tp_cpi_client(  ).
        DATA lv_url TYPE string.

        lv_url = 'https://<integration-suite-runtime>/http/purchase-orders/dispatch'.

        DATA(lo_destination) =
          cl_http_destination_provider=>create_by_url(
            i_url = lv_url
          ).

        DATA(lo_client) =
          cl_web_http_client_manager=>create_by_http_destination(
            i_destination = lo_destination
          ).

        DATA(lo_request) = lo_client->get_http_request( ).

        lo_request->set_authorization_basic(
          i_username = 'x'
          i_password = 'x'
        ).

        DATA(lo_response) =
          lo_client->execute(
            i_method = if_web_http_client=>get
          ).

        DATA(ls_status) = lo_response->get_status( ).

        out->write( |Status: { ls_status-code } { ls_status-reason }| ).
        out->write( lo_response->get_text( ) ).

        lo_client->close( ).


      CATCH cx_http_dest_provider_error
            cx_web_http_client_error INTO DATA(lx_error).

        out->write(
          |ERROR: { lx_error->get_text( ) }|
        ).
        ENDTRY.
    ENDMETHOD.
ENDCLASS.
