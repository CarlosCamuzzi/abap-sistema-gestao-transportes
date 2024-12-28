class ZL_TEST_MAINWINDOW definition
  public
  inheriting from CL_WCF_BSP_BASE_WINDOW
  create public .

public section.

  data TYPED_CONTEXT type ref to ZL_TEST_MAINWINDOW_CTXT read-only .

  methods IP_TO_OVERVIEW
    importing
      !IV_COLLECTION type ref to IF_BOL_BO_COL optional .
  methods IP_TO_CREATE
    importing
      !IV_COLLECTION type ref to IF_BOL_BO_COL optional .

  methods CALL_OUTBOUND_PLUG
    redefinition .
protected section.

  methods WD_CREATE_CONTEXT
    redefinition .
  methods WD_DESTROY_CONTEXT
    redefinition .
private section.
ENDCLASS.



CLASS ZL_TEST_MAINWINDOW IMPLEMENTATION.


  method CALL_OUTBOUND_PLUG.


    DATA: lv_plug_method TYPE seocmpname.

    CONCATENATE 'OP_' iv_outbound_plug INTO lv_plug_method.
    TRANSLATE lv_plug_method TO UPPER CASE.               "#EC SYNTCHAR

    TRY.
        IF iv_data_collection IS BOUND.
          CALL METHOD (lv_plug_method)
            EXPORTING
              iv_data_collection = iv_data_collection.
        ELSE.
          CALL METHOD (lv_plug_method).
        ENDIF.
      CATCH cx_sy_dyn_call_error.
        RAISE EXCEPTION TYPE cx_bsp_wd_incorrect_implement
          EXPORTING
            textid     =
              cx_bsp_wd_incorrect_implement=>window_plug_undefined
            controller = me->view_id
            plug       = iv_outbound_plug.
    ENDTRY.


  endmethod.


  method IP_TO_CREATE.



  endmethod.


  method IP_TO_OVERVIEW.



  endmethod.


  method WD_CREATE_CONTEXT.


*   create the context
    context = cl_bsp_wd_context=>get_instance(
          iv_controller = me
          iv_type = 'ZL_TEST_MAINWINDOW_CTXT' ).

    typed_context ?= context.


  endmethod.


  method WD_DESTROY_CONTEXT.


    CLEAR me->typed_context.
    super->wd_destroy_context( ).


  endmethod.
ENDCLASS.
