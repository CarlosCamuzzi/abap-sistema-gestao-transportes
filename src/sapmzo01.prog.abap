*&---------------------------------------------------------------------*
*& Include          SAPMZO01
*&---------------------------------------------------------------------*
*&  Obs.: PERFORM f_select_table: Seleciona tabela para gerar o ID
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0100'.
  SET TITLEBAR 'PF-TITLE_0100'.  " Menu Principal

  FREE: w_ztrotas,
        w_ztveiculos,
        w_ztmotoristas,
        w_ztentregas,
        w_ztocorrencias.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0200'.
  SET TITLEBAR 'PF-TITLE_0200'.  " Menu Veículo

  FREE: w_ztveiculos.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0201 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0201 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0201'.
  SET TITLEBAR 'PF-TITLE_0201'.  " Cadastro de Veículo

  PERFORM f_select_table USING 'ZTVEICULOS'.

  LOOP AT SCREEN.

    IF screen-name EQ 'W_ZTVEICULOS-PLACA' AND w_ztveiculos-placa NE space.
      screen-input = 0.
    ENDIF.

    IF screen-name EQ 'W_ZTVEICULOS-MODELO' AND w_ztveiculos-modelo NE space.
      screen-input = 0.
    ENDIF.

    IF screen-name EQ 'W_ZTVEICULOS-MARCA' AND w_ztveiculos-marca NE space.
      screen-input = 0.
    ENDIF.

    IF screen-name EQ 'W_ZTVEICULOS-CAPACIDADE' AND w_ztveiculos-capacidade NE space.
      screen-input = 0.
    ENDIF.

    IF screen-name EQ 'W_ZTVEICULOS-MEINS' AND w_ztveiculos-meins EQ space. " Primeiro LOOP
      w_ztveiculos-meins = 'KG'.
    ENDIF.

    IF screen-name EQ 'W_ZTVEICULOS-STATUS' AND w_ztveiculos-placa NE space.
      screen-input = 0.
    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0300 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0300 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0300'.
  SET TITLEBAR 'PF-TITLE_0300'.  " Menu Motorista

  FREE w_ztmotoristas.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0301 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0301 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0301'.
  SET TITLEBAR 'PF-TITLE_0301'.  " Cadastro de Motorista

  PERFORM f_select_table USING 'ZTMOTORISTAS'.

  LOOP AT SCREEN.

    IF screen-name EQ 'W_ZTMOTORISTAS-NOME' AND w_ztmotoristas-nome NE space.
      screen-input = 0.
    ENDIF.

    IF screen-name EQ 'W_ZTMOTORISTAS-CPF' AND w_ztmotoristas-cpf NE space.
      screen-input = 0.
    ENDIF.

    IF screen-name EQ ' W_ZTMOTORISTAS-CNH' AND w_ztmotoristas-cnh NE space.
      screen-input = 0.
    ENDIF.

    IF screen-name EQ 'W_ZTMOTORISTAS-VALIDADE_CNH' AND w_ztmotoristas-validade_cnh NE 0.
      screen-input = 0.
    ENDIF.

    IF screen-name EQ 'W_ZTMOTORISTAS-STATUS' AND w_ztmotoristas-status NE space.
      screen-input = 0.
    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0400 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0400 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0400'.
  SET TITLEBAR 'PF-TITLE_0400'.  " Menu Rotas

  FREE w_ztrotas.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0401 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0401 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0401'.
  SET TITLEBAR 'PF-TITLE_0401'.  " Cadastrar Rota

  PERFORM f_select_table USING 'ZTROTAS'.

  LOOP AT SCREEN.

    IF screen-name EQ 'W_ZTROTAS-LAND1' AND w_ztrotas-land1 EQ space. " Primeiro LOOP
      w_ztrotas-land1 = 'BR'.
    ENDIF.

    IF screen-name EQ 'W_ZTROTAS-BLAND_ORIG' AND w_ztrotas-bland_orig NE space.
      screen-input = 0.
    ENDIF.

    IF screen-name EQ 'W_ZTROTAS-BLAND_DEST' AND w_ztrotas-bland_dest NE space.
      screen-input = 0.
    ENDIF.

    IF screen-name EQ 'W_ZTROTAS-DISTANCIA' AND w_ztrotas-distancia NE 0.
      screen-input = 0.
    ENDIF.

    IF screen-name EQ 'W_ZTROTAS-MEINS' AND w_ztrotas-meins EQ space. " Primeiro LOOP
      w_ztrotas-meins = 'KM'.
    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0500 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0500 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0500'.
  SET TITLEBAR 'PF-TITLE_0500'.  " Menu Ocorrência

  FREE: w_ztocorrencias,
        w_ztentregas.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0501 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0501 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0501'.
  SET TITLEBAR 'PF-TITLE_0501'.  " Registrar Ocorrência

  LOOP AT SCREEN.
    IF screen-name EQ 'W_ZTOCORRENCIAS-DATA_OCORRENCIA' AND w_ztocorrencias-data_ocorrencia EQ 0.
      w_ztocorrencias-data_ocorrencia = sy-datum.
    ENDIF.

    MODIFY SCREEN.
  ENDLOOP.

  PERFORM f_select_table USING 'ZTOCORRENCIAS'.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0600 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0600 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0600'.
  SET TITLEBAR 'PF-TITLE_0600'.  " Menu Entrega

  FREE: w_ztentregas,
        w_ztrotas,
        w_ztveiculos,
        w_ztmotoristas,
        w_ztocorrencias.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0601 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0601 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0601'.
  SET TITLEBAR 'PF-TITLE_0601'.  " Cadastrar Entrega

  LOOP AT SCREEN.
    IF screen-name EQ 'W_ZTENTREGAS-STATUS' AND w_ztentregas-status EQ space.
      w_ztentregas-status = 'GERADA'.
    ENDIF.

    MODIFY SCREEN.
  ENDLOOP.

  PERFORM f_select_table USING 'ZTENTREGAS'.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0602 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0602 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0602'.
  SET TITLEBAR 'PF-TITLE_0602'.   " Buscar Rota
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module SCROLL_TC_0602 OUTPUT
*&---------------------------------------------------------------------*
MODULE scroll_tc_0602 OUTPUT.
  IF sy-stepl = 1.
    tc_0602-lines = tc_0602-top_line + sy-loopc - 1.
  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0603 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0603 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0603'.
  SET TITLEBAR 'PF-TITLE_0603'.  " Buscar Veículo
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module SCROLL_TC_0603 OUTPUT
*&---------------------------------------------------------------------*
MODULE scroll_tc_0603 OUTPUT.
  IF sy-stepl = 1.
    tc_0603-lines = tc_0603-top_line + sy-loopc - 1.
  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0604 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0604 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0604'.
  SET TITLEBAR 'PF-TITLE_0604'.    " Buscar Motoristas
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module SCROLL_TC_0604 OUTPUT
*&---------------------------------------------------------------------*
MODULE scroll_tc_0604 OUTPUT.
  IF sy-stepl = 1.
    tc_0604-lines = tc_0604-top_line + sy-loopc - 1.
  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module STATUS_0502 OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0502 OUTPUT.
  SET PF-STATUS 'PF-STATUS_0502'.
  SET TITLEBAR 'PF-TITLE_0502'.  " Buscar Entrega

*  LOOP AT SCREEN.
*    IF screen-name EQ 'T_BUSCA_ENTREGA-OCORRENCIA_ID'
*
*      AND t_busca_entrega-ocorrencia_id NE space.
*
*    ENDLOOP.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module SCROLL_TC_0502 OUTPUT
*&---------------------------------------------------------------------*
MODULE scroll_tc_0502 OUTPUT.
  IF sy-stepl = 1.
    tc_0502-lines = tc_0502-top_line + sy-loopc - 1.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module FORMAT_OCORRENCIA OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*MODULE format_ocorrencia OUTPUT.
*
*  IF t_busca_entrega-ocorrencia_id NE space.
*    t_busca_entrega-color = 'C610'. " Fundo vermelho, texto branco
*  ENDIF.
*
*ENDMODULE.
