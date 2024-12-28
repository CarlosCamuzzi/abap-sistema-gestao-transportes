FUNCTION z_build_dynamic_query.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_FIELD) TYPE  STRING
*"     VALUE(IT_VALUES) TYPE  STRING
*"     VALUE(IT_TEMPLATE) TYPE  STRING
*"  EXPORTING
*"     VALUE(RV_WHERE_CLAUSE) TYPE  STRING
*"----------------------------------------------------------------------

  DATA: lt_conditions TYPE TABLE OF string,
        ls_condicion  TYPE string.

  LOOP AT it_field INTO DATA(field).

  ENDLOOP.



ENDFUNCTION.
