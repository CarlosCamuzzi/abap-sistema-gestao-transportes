FUNCTION zfcreate_id.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(CURRENT_ID) TYPE  CHAR5
*"  EXPORTING
*"     VALUE(RESULT_ID) TYPE  CHAR5
*"----------------------------------------------------------------------


  IF strlen( current_id ) EQ 0. " Primeiro ID
    current_id = insert( val = current_id sub = '00001' off = 0 ).
    result_id = current_id.
    EXIT.
  ENDIF.

  DATA(v_segmen) = segment( val = current_id index = -1 sep = '0' ).  " Retorna valor, excluindo 0
  current_id = current_id + 1. " Incrementa

  IF strlen( v_segmen ) EQ 1.       " 00001
    current_id = insert( val = current_id sub = '0' off = 0 ).
    current_id = replace( val = current_id  off = 1 len = 3 with =  '000' ).
    result_id = current_id.

  ELSEIF strlen( v_segmen ) EQ 1.   " 00012
    current_id = insert( val = current_id sub = '0' off = 0 ).
    current_id = replace( val = current_id  off = 1 len = 2 with =  '00' ).
    result_id = current_id.

  ELSEIF strlen( v_segmen ) EQ 3.                                 " 00123
    current_id = insert( val = current_id sub = '0' off = 0 ).
    current_id = replace( val = current_id  off = 1 len = 1 with =  '0' ).
    result_id = current_id.

  ELSEIF strlen( v_segmen ) EQ 4.                                 " 01234
    current_id = insert( val = current_id sub = '0' off = 0 ).
    result_id = current_id.

  ENDIF.  " 12345 não faz nada no if


ENDFUNCTION.
