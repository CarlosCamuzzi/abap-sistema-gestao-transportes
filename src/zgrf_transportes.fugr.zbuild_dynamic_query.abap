FUNCTION zbuild_dynamic_query.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_TABLE) TYPE  ZTSTRUCTURE_QUERY
*"  EXPORTING
*"     VALUE(QUERY) TYPE  STRING
*"----------------------------------------------------------------------

  DATA: lv_len   TYPE i,
        lv_lines TYPE i.

  LOOP AT it_table INTO DATA(wa_table) WHERE exist EQ abap_true.
    lv_lines = lv_lines + 1.
  ENDLOOP.

  query = REDUCE string(
    INIT text = `` sep = ``
    FOR ls_table IN it_table WHERE ( exist = abap_true )
    NEXT text = |{ text }{ sep }{ ls_table-clause }|
         sep = ` `
  ).

  IF strlen( query ) > 0.
    TRY.
        query = substring_before( val = query sub = ` AND` occ = lv_lines ).

      CATCH cx_sy_range_out_of_bounds.
        MESSAGE: 'CX_SY_RANGE_OUT_OF_BOUNDS' TYPE 'E'.

      CATCH cx_sy_strg_par_val.
        MESSAGE: 'CX_SY_STRG_PAR_VAL' TYPE 'E'.

      CATCH cx_sy_regex_too_complex.
        MESSAGE: 'CX_SY_REGEX_TOO_COMPLEX' TYPE 'E'.
    ENDTRY.
  ENDIF.

ENDFUNCTION.
