class ZL_TEST_TEST_OVP definition
  public
  inheriting from CL_WCF_BSP_BASE_OVP
  create public .

public section.

  data TYPED_CONTEXT type ref to ZL_TEST_TEST_OVP_CTXT read-only .

  methods IF_BSP_WD_DYN_BTN_CONTROL~GET_BUTTONS
    redefinition .
  methods IF_BSP_WD_DYN_BTN_CONTROL~GET_LOCAL_TOOLBAR_BUTTONS
    redefinition .
  methods IF_BSP_WD_DYN_BTN_CONTROL~GET_NO_OF_VISIBLE_TOOLBAR_BTNS
    redefinition .
  methods IF_WCF_BSP_VIEW_CONTEXT~GET_MAIN_CONTEXT_NODE
    redefinition .
  methods IF_WCF_BSP_VIEW_CONTEXT~GET_PARENT_CONTEXT_NODE
    redefinition .
  methods IF_WCF_BSP_VIEW_CONTEXT~GET_ROOT_CONTEXT_NODE
    redefinition .
protected section.

  methods GET_OPTIONS
    redefinition .
  methods DO_DETERMINE_CONFIG_KEYS
    redefinition .
  methods DO_HANDLE_EVENT
    redefinition .
  methods WD_CREATE_CONTEXT
    redefinition .
  methods WD_DESTROY_CONTEXT
    redefinition .
private section.
ENDCLASS.



CLASS ZL_TEST_TEST_OVP IMPLEMENTATION.


  method DO_DETERMINE_CONFIG_KEYS.

  ev_object_type = 'ZTEST1'.

  endmethod.


  method DO_HANDLE_EVENT.


    super->do_handle_event(
      EXPORTING
        event           = event
        htmlb_event     = htmlb_event
        htmlb_event_ex  = htmlb_event_ex
        global_messages = global_messages
      RECEIVING
        global_event    = global_event
      ).

"Eventhandler dispatching
"Code slot required to detect events created with workbench
*@SLOT EVENT_DISPATCHER "<-----Do not touch this comment!!!!
  CASE htmlb_event_ex->event_server_name.
    WHEN 'dummy'.

*@END EVENT_DISPATCHER "<-----Do not touch this comment!!!!


  ENDCASE.
  endmethod.


  method GET_OPTIONS.

    ev_editable   = 'X'.
    ev_deleteable = 'X'.
    ev_main       = 'X'.

  endmethod.


  method IF_BSP_WD_DYN_BTN_CONTROL~GET_BUTTONS.

    DATA ls_button TYPE crmt_thtmlb_button.

    rt_result = super->if_bsp_wd_dyn_btn_control~get_buttons( ).

  endmethod.


  method IF_BSP_WD_DYN_BTN_CONTROL~GET_LOCAL_TOOLBAR_BUTTONS.

    DATA ls_button TYPE crmt_thtmlb_button.
    rt_result = super->if_bsp_wd_dyn_btn_control~get_local_toolbar_buttons( ).

  endmethod.


  method IF_BSP_WD_DYN_BTN_CONTROL~GET_NO_OF_VISIBLE_TOOLBAR_BTNS.

    rv_result = super->if_bsp_wd_dyn_btn_control~get_no_of_visible_toolbar_btns( ).

  endmethod.


  method IF_WCF_BSP_VIEW_CONTEXT~GET_MAIN_CONTEXT_NODE.

    ro_context_node = typed_context->TEST.

  endmethod.


  method IF_WCF_BSP_VIEW_CONTEXT~GET_PARENT_CONTEXT_NODE.


  endmethod.


  method IF_WCF_BSP_VIEW_CONTEXT~GET_ROOT_CONTEXT_NODE.


  endmethod.


  method WD_CREATE_CONTEXT.


*   create the context
    context = cl_bsp_wd_context=>get_instance(
          iv_controller = me
          iv_type = 'ZL_TEST_TEST_OVP_CTXT' ).

    typed_context ?= context.


  endmethod.


  method WD_DESTROY_CONTEXT.


    CLEAR me->typed_context.
    super->wd_destroy_context( ).


  endmethod.
ENDCLASS.
