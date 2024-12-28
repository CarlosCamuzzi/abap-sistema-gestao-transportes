class ZL_TEST_TEST_DETAILS definition
  public
  inheriting from CL_WCF_BSP_BASE_FORM_VIEW
  create public .

public section.

  data TYPED_CONTEXT type ref to ZL_TEST_TEST_DETAILS_CTXT read-only .

  methods CONSTRUCTOR .

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
  methods SET_MODELS
    redefinition .
  methods DO_HANDLE_EVENT
    redefinition .
  methods WD_CREATE_CONTEXT
    redefinition .
  methods WD_DESTROY_CONTEXT
    redefinition .
private section.

  constants VIEW type STRING value 'TEST_DETAILS.htm' ##NO_TEXT.
ENDCLASS.



CLASS ZL_TEST_TEST_DETAILS IMPLEMENTATION.


  method CONSTRUCTOR.

  super->constructor( ).
  view_name = view.
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


  method SET_MODELS.

*   Set the models for output
  view->set_attribute(
           name   = 'TEST'       "#EC NOTEXT
           value  = typed_context->TEST ).
  endmethod.


  method WD_CREATE_CONTEXT.


*   create the context
    context = cl_bsp_wd_context=>get_instance(
          iv_controller = me
          iv_type = 'ZL_TEST_TEST_DETAILS_CTXT' ).

    typed_context ?= context.


  endmethod.


  method WD_DESTROY_CONTEXT.


    CLEAR me->typed_context.
    super->wd_destroy_context( ).


  endmethod.
ENDCLASS.
