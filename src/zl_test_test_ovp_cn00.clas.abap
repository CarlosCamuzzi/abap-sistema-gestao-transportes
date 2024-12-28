class ZL_TEST_TEST_OVP_CN00 definition
  public
  inheriting from CL_WCF_BSP_BASE_DEF_CN
  create public .

public section.

  constants BASE_ENTITY_NAME type CRMT_EXT_OBJ_NAME value 'IsuPerConHeader' ##NO_TEXT.

  methods CONSTRUCTOR .
protected section.
private section.
ENDCLASS.



CLASS ZL_TEST_TEST_OVP_CN00 IMPLEMENTATION.


  method CONSTRUCTOR.

    super->constructor( ).

  endmethod.
ENDCLASS.
