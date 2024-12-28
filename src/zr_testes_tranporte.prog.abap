*&---------------------------------------------------------------------*
*& Report ZR_TESTES_TRANPORTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT zr_testes_tranporte.

"DATA: result_id  TYPE char5.
"PARAMETERS: curr_id TYPE char5.

DATA: v_text TYPE string VALUE ' 10'.
DATA: v_res TYPE string.



START-OF-SELECTION.

*V_RES = insert( val = V_TEXT sub = '0' off = 0 ).
*WRITE:/ V_RES.
*V_RES = REPLACE( VAL = V_RES OFF = 1 LEN = 1 WITH = 'ZZ' ).
*WRITE:/ V_RES.
*


*" OK NA FUNC
* IF strlen( curr_id ) EQ 0. " Primeiro ID
*    curr_id = insert( val = curr_id sub = '00001' off = 0 ).
*    result_id = curr_id.
*    EXIT.
*  ENDIF.
*
*
*DATA(v_segmen) = segment( val = curr_id index = -1 sep = '0' ).  " Retorna valor, excluindo 0
*curr_id = curr_id + 1. " Incrementa
*
*DATA: V_LEN TYPE I.
*
*V_LEN = STRLEN( curr_id ).



*" OK ATÉ 0008
*IF strlen( v_segmen ) EQ 1.       " 00001
*  curr_id = insert( val = curr_id sub = '0' off = 0 ).
*  curr_id = replace( val = curr_id  off = 1 len = 2 with =  '000' ).
*  result_id = curr_id.
*
*ELSEIF strlen( v_segmen ) EQ 2.   " 00012
*  curr_id = insert( val = curr_id sub = '0' off = 0 ).
*  curr_id = replace( val = curr_id  off = 1 len = 2 with =  '00' ).
*  result_id = curr_id.
*
*ELSEIF strlen( v_segmen ) EQ 3.                             " 00123
*  curr_id = insert( val = curr_id sub = '0' off = 0 ).
*  curr_id = replace( val = curr_id  off = 1 len = 1 with =  '0' ).
*  result_id = curr_id.
*
*ELSEIF strlen( v_segmen ) EQ 4.                             " 01234
*  curr_id = insert( val = curr_id sub = '0' off = 0 ).
*  result_id = curr_id.
*
*ENDIF.  " 12345 não faz nada no if
*
*WRITE:/ 'CURRENT_ID: ', curr_id,
*        'RESULT_ID:', result_id.


*PARAMETERS: P_ID LIKE ZTVEICULOS-VEICULO_ID.
*
*START-OF-SELECTION.
*DELETE FROM ZTVEICULOS WHERE VEICULO_ID = P_ID.



  " marca = 'MERCEDES-BENZ' AND
  DATA lv_where_clause TYPE string VALUE 'marca'.
  DATA lv_final TYPE string.

**********************************************************************

*  CONCATENATE lv_where_clause `= 'MERCEDES-BENZ' AND` INTO lv_final SEPARATED BY space.
*
*  " marca = 'MERCEDES-BENZ' AND
*  WRITE:/ lv_final.
*  WRITE:/ 'Tamanho: ', strlen( lv_final ), /.  " 27
*
***********************************************************************
*  FREE: lv_where_clause, lv_final.
*  lv_where_clause = 'marca'.
*
*  CONCATENATE lv_where_clause `= 'MERCEDES-BENZ'` INTO lv_final SEPARATED BY space.
*
*  " marca = 'MERCEDES-BENZ'
*  WRITE:/ lv_final.
*  WRITE:/ 'Tamanho: ', strlen( lv_final ), /.  " 23
*  ULINE.

**********************************************************************

*  FREE: lv_where_clause, lv_final.
*  lv_where_clause = 'marca'.
*
*  CONCATENATE lv_where_clause `= 'MERCEDES-BENZ' AND` INTO lv_final SEPARATED BY space.

  " Não aceita negativo no lengh
  "lv_final = substring( val = 'ABCDEF'  off = 2  len = -1 ).

**********************************************************************
**********************************************************************
  " FUNCIONA
  " Obs.: Precisa passar no OCC do substring_before a quantidade de AND
  TRY.
      " TESTE PARA UM AND
      FREE: lv_where_clause, lv_final.
      lv_where_clause = 'marca'.

      CONCATENATE lv_where_clause `= 'MERCEDES-BENZ' AND` INTO lv_final SEPARATED BY space.
*
      "lv_final = segment( val = lv_final index = -1 sep = '' ).    " Pega o AND, mas não vai servir
      "lv_final = match( val = lv_final pcre = '.AND' occ = 1  ).   " NÃO: retorna mas não vai servir

      lv_final = substring_before( val = lv_final sub = ' AND' ). " Funciona para 1 and
      "      lv_final = condense( val = lv_final del = space ). " Não entendi

      WRITE:/ lv_final.
      WRITE:/ 'Tamanho: ', strlen( lv_final ), /.  " 23
      ULINE.

**********************************************************************

      " TESTE PARA DOIS AND
      " Esse é o correto - precisa passar para o OCC a quantidade de
      FREE: lv_where_clause, lv_final.
      lv_where_clause = 'marca'.

      CONCATENATE lv_where_clause `= 'MERCEDES-BENZ' AND modelo = 'xtz1' AND` INTO lv_final SEPARATED BY space.

      WRITE:/ lv_final.
      WRITE:/ 'Tamanho: ', strlen( lv_final ), /.  " 46

      lv_final = substring_before( val = lv_final sub = ' AND' occ = 2 ).
      WRITE:/ lv_final.
      WRITE:/ 'Tamanho: ', strlen( lv_final ), /.  " 43
      ULINE.

      " Verificar espaço

      DATA(vl_check) = strlen( | modelo = 'A' AND | ).
      WRITE:/ vl_check.

      vl_check = strlen( `modelo = 'A' AND`  ).
      WRITE:/ vl_check.

    CATCH cx_sy_range_out_of_bounds.
      WRITE: 'CX_SY_RANGE_OUT_OF_BOUNDS'.

    CATCH cx_sy_strg_par_val .
      WRITE: 'CX_SY_STRG_PAR_VAL'.

    CATCH cx_sy_regex_too_complex.
      WRITE: 'CX_SY_REGEX_TOO_COMPLEX'.

  ENDTRY.

  ULINE.
  DATA v_tam TYPE i VALUE 0.
  DATA(v_1) = |status = A|.
  DATA(v_2) = | status = A |.

  v_tam = strlen( v_1 ).
  WRITE:/ v_tam.

  v_tam = strlen( v_2 ).
  WRITE:/ v_tam.

***********************************************************************

" Gera ID
  DATA(lv_log_id) = cl_system_uuid=>if_system_uuid_static~create_uuid_x16( ).
  SKIP.
  ULINE.
  WRITE:/ lv_log_id.


  DELETE FROM ZTROTAS.
