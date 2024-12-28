*&---------------------------------------------------------------------*
*& Report ZESTUDO_ROTAS_TEST01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zestudo_rotas_test01 NO STANDARD PAGE HEADING.

DATA: t_ztrotas TYPE TABLE OF ztrotas,
      w_ztrotas TYPE ztrotas.

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_rotaid LIKE ztrotas-rota_id,
              p_descri LIKE ztrotas-descricao,
              p_pais   LIKE t005u-land1 DEFAULT 'BR',
              p_uforig LIKE t005u-bland,     " origem
              p_ufdest LIKE t005u-bland,     " destino
              p_distan LIKE ztrotas-distancia,
              p_undmed LIKE ztrotas-unid_medida DEFAULT 'KM'.
SELECTION-SCREEN END OF BLOCK b01.

START-OF-SELECTION.
  PERFORM f_set_data.
  PERFORM f_get_data.

*&---------------------------------------------------------------------*
*& Form F_INCLUDE_DATA
*&---------------------------------------------------------------------*
FORM f_set_data .
  w_ztrotas-rota_id = p_rotaid.
  w_ztrotas-descricao = p_descri.
  w_ztrotas-pais = p_pais.
  w_ztrotas-uf_origem = p_uforig.
  w_ztrotas-uf_destino = p_ufdest.
  w_ztrotas-distancia = p_distan.
  w_ztrotas-unid_medida = p_undmed.
  APPEND w_ztrotas TO t_ztrotas.
  "INSERT ZTROTAS.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_get_data
*&---------------------------------------------------------------------*
FORM f_get_data .
  LOOP AT t_ztrotas INTO w_ztrotas.
    WRITE:/ w_ztrotas-rota_id, /,
            w_ztrotas-descricao, /,
            w_ztrotas-pais, /,
            w_ztrotas-uf_origem, /,
            w_ztrotas-uf_destino, /,
            w_ztrotas-distancia, /,
            w_ztrotas-unid_medida.
  ENDLOOP.
ENDFORM.
