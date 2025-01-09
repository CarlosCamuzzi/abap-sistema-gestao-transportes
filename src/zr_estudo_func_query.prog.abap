*&---------------------------------------------------------------------*
*& Report ZR_ESTUDO_FUNC_QUERY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zr_estudo_func_query.

DATA: v_nome    TYPE string VALUE 'Carlos',
      v_cpf(11) TYPE c      VALUE '1234567894',
      v_cnh(9)  TYPE c,
      lv_query  TYPE string.


DATA(lt_where_clause) = VALUE ztstructure_query( " Ref ao data type
    ( clause = |nome LIKE '{ v_nome }%' AND|
    exist = COND #( WHEN v_nome IS INITIAL THEN abap_false ELSE abap_true )  )

    ( clause = |cpf LIKE '{ v_cpf }%' AND|
    exist = COND #( WHEN v_cpf IS INITIAL THEN abap_false ELSE abap_true )   )

   ( clause = |cnh LIKE '{ v_cnh }%' AND|
     exist = COND #( WHEN v_cnh IS INITIAL THEN abap_false ELSE abap_true ) )
).


START-OF-SELECTION.

  CALL FUNCTION 'ZBUILD_DYNAMIC_QUERY'
    EXPORTING
      it_table = lt_where_clause
    IMPORTING
      query    = lv_query.

  WRITE: lv_query.
