class ZL_TEST_MAINWINDOW_CTXT definition
  public
  inheriting from CL_BSP_WD_CONTEXT
  create public .

public section.
protected section.

  methods CREATE_CONTEXT_NODES
    redefinition .
  methods CONNECT_NODES
    redefinition .
private section.
ENDCLASS.



CLASS ZL_TEST_MAINWINDOW_CTXT IMPLEMENTATION.


  method CONNECT_NODES.
 "#EC NEEDED
    DATA: coll_wrapper TYPE REF TO cl_bsp_wd_collection_wrapper. "#EC NEEDED




  endmethod.


  method CREATE_CONTEXT_NODES.
 "#EC NEEDED

* create context nodes



  endmethod.
ENDCLASS.
