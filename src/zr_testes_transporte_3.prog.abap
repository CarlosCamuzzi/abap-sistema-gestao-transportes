*&---------------------------------------------------------------------*
*& Report ZR_TESTES_TRANsPORTE_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zr_testes_transporte_3.

*data: lv_length type i,
*      lv_cast type string.
*
*  SELECT SINGLE distancia
*    INTO @DATA(lv_value)
*    FROM  ztrotas
*    WHERE rota_id = '00001'.
*
*  WRITE:/ lv_value.
*
*  lv_cast = lv_value.
*
*  lv_length  = strlen( lv_cast ). " 9 com ponto e vírgula
*  WRITE:/ lv_length.
*
*  FREE: lv_cast, lv_length.

**********************************************************************


*DATA: lt_fixed  TYPE TABLE OF ztrotas,
*      "wa_fixed  TYPE ztrotas,
*      "lv_dist  TYPE string,
*      lt_rotas  TYPE TABLE OF ztrotas.
*      "lv_cast   TYPE string,
*      "lv_number TYPE zerota_003.
*
*TRY .
*    SELECT * FROM ztrotas
*        INTO TABLE lt_rotas
*        WHERE rota_id = '00059'.
*
*    " Com erro de tipo - conversão
**    LOOP AT lt_rotas INTO DATA(wa_rotas).
**      lv_cast = wa_rotas-distancia.
**
**      IF strlen( lv_cast ) EQ 9.
**        CONDENSE lv_cast NO-GAPS.
**        REPLACE '.' WITH ',' INTO lv_cast.
**        lv_number = lv_cast.             " erro de tipo / conversão
**        wa_rotas-distancia = lv_number.
**        APPEND wa_rotas TO lt_rotas.
**      ENDIF.
**
**    ENDLOOP.
*
*    " Com erro de tipo - conversão
**    LOOP AT lt_rotas ASSIGNING FIELD-SYMBOL(<fs_rota>)
**        WHERE distancia > 1000.
**
**      lv_dist = <fs_rota>-distancia.
**      REPLACE '.' WITH ',' INTO lv_dist.
**      <fs_rota>-distancia = lv_dist.
**
**    ENDLOOP.
*
*    " Com erro de tipo - conversão
**    lt_fixed = VALUE #(
**      FOR ls_rota IN lt_rotas WHERE ( distancia > 1000 )
**        LET lv_fixed = CONV string( ls_rota-distancia )
**          IN ( distancia = CONV zerota_003( replace( val = lv_fixed sub = '.' with = ',' ) ) )
**    ).
*
*  CATCH cx_sy_conversion_no_number.
*    MESSAGE: 'CX_SY_CONVERSION_NO_NUMBER' TYPE 'E'.
*
*ENDTRY.


DATA: lt_rotas TYPE TABLE OF ztrotas,
      wa_rotas TYPE ztrotas.

START-OF-SELECTION.

  DELETE FROM ztrotas WHERE rota_id = '00064'.
  "DELETE FROM ztrotas WHERE distancia = 2400.

  SELECT * FROM ztrotas
    INTO TABLE lt_rotas.

  LOOP AT lt_rotas INTO wa_rotas.
    WRITE:/ wa_rotas-rota_id,
            wa_rotas-pais,
            wa_rotas-uf_origem,
            wa_rotas-uf_destino,
            wa_rotas-distancia,
            wa_rotas-meins.
  ENDLOOP.
