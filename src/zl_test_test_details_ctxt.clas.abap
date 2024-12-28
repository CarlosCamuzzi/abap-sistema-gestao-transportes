class ZL_TEST_TEST_DETAILS_CTXT definition
  public
  inheriting from CL_BSP_WD_CONTEXT
  create public .

public section.

  data TEST type ref to ZL_TEST_TEST_DETAILS_CN00 read-only .
protected section.

  methods CREATE_TEST .

  methods CREATE_CONTEXT_NODES
    redefinition .
  methods CONNECT_NODES
    redefinition .
private section.
ENDCLASS.



CLASS ZL_TEST_TEST_DETAILS_CTXT IMPLEMENTATION.


  method CONNECT_NODES.
 "#EC NEEDED
    DATA: coll_wrapper TYPE REF TO cl_bsp_wd_collection_wrapper. "#EC NEEDED




  endmethod.


  method CREATE_CONTEXT_NODES.
 "#EC NEEDED

* create context nodes

    create_TEST( ).


  endmethod.


  method CREATE_TEST.

    DATA:
      model        TYPE REF TO if_bsp_model,
      coll_wrapper TYPE REF TO cl_bsp_wd_collection_wrapper,"#EC NEEDED
      entity       TYPE REF TO cl_crm_bol_entity,           "#EC NEEDED
      entity_col   TYPE REF TO if_bol_entity_col.           "#EC NEEDED

    model = owner->create_model(
        class_name     = 'ZL_TEST_TEST_DETAILS_CN00'
        model_id       = 'TEST' ).          "#EC NOTEXT
    TEST ?= model.
    CLEAR model.

    "Binding
    owner->do_context_node_binding(
           iv_controller_type = CL_BSP_WD_CONTROLLER=>CO_TYPE_COMPONENT
           iv_name            = ''
           iv_target_node_name = 'TEST'
           iv_node_2_bind = TEST ).



  endmethod.
ENDCLASS.
