class ZL_TEST_BSPWDCOMPONENT definition
  public
  inheriting from CL_BSP_WD_COMPONENT_CONTROLLER
  create public .

public section.

  data TYPED_CONTEXT type ref to ZL_TEST_BSPWDCOMPONENT_CTXT read-only .

  methods CONSTRUCTOR .
protected section.

  methods WD_USAGE_INITIALIZE
    redefinition .
  methods WD_CREATE_CONTEXT
    redefinition .
  methods WD_DESTROY_CONTEXT
    redefinition .
private section.

  constants CONTROLLER type STRING value 'BSPWDComponent' ##NO_TEXT.
ENDCLASS.



CLASS ZL_TEST_BSPWDCOMPONENT IMPLEMENTATION.


  method CONSTRUCTOR.


    super->constructor( ).
    controller_id = controller.


  endmethod.


  method WD_CREATE_CONTEXT.


*   create the context
    context = cl_bsp_wd_context=>get_instance(
          iv_controller = me
          iv_type = 'ZL_TEST_BSPWDCOMPONENT_CTXT' ).

    typed_context ?= context.


  endmethod.


  method WD_DESTROY_CONTEXT.


    CLEAR me->typed_context.
    super->wd_destroy_context( ).


  endmethod.


  method WD_USAGE_INITIALIZE.


    DATA lv_node_2_bind TYPE REF TO cl_bsp_wd_context_node.

    super->wd_usage_initialize(
      iv_usage = iv_usage
         ).

    CASE iv_usage->usage_name.
      WHEN 'DUMMY'.
    ENDCASE.


  endmethod.
ENDCLASS.
