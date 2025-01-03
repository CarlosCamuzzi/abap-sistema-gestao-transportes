*&---------------------------------------------------------------------*
*& Include          SAPMZI01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       Menu Principal
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  FREE: w_ztrotas,
        w_ztveiculos,
        w_ztmotoristas,
        w_ztentregas,
        w_ztocorrencias.

  CASE sy-ucomm.
    WHEN 'FCT_VEIC'.
      CALL SCREEN '0200'. " Menu Veículos

    WHEN 'FCT_MOTO'.
      CALL SCREEN '0300'. " Menu Motoristas

    WHEN 'FCT_ROTA'.
      CALL SCREEN '0400'. " Menu Rotas

    WHEN 'FCT_OCOR'.
      CALL SCREEN '0500'. " Menu Ocorrências

    WHEN 'FCT_ENTR'.
      CALL SCREEN '0600'. " Menu Entregas

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE exit_command_0100 INPUT.
  LEAVE PROGRAM.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       Menu Veículo
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_VEIC_CAD'.
      CALL SCREEN '0201'.

    WHEN 'FCT_VEIC_REL'.
      "CALL SCREEN '0202'.

    WHEN 'FCT_BACK'.
      LEAVE TO SCREEN '0100'.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
MODULE exit_command_0200 INPUT.
  CALL SCREEN '0100'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0201  INPUT
*&---------------------------------------------------------------------*
*       Cadastrar Veículo
*----------------------------------------------------------------------*
MODULE user_command_0201 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_BACK'.
      FREE w_ztveiculos.
      LEAVE TO SCREEN '0200'.

    WHEN 'FCT_MENU'.
      FREE w_ztveiculos.
      LEAVE TO SCREEN '0100'.

    WHEN 'FCT_CLEAN'.
      FREE w_ztveiculos.

    WHEN 'FCT_CANC'.
      FREE w_ztveiculos.
      LEAVE TO SCREEN '0200'.

    WHEN 'FCT_ADD'.
      PERFORM validate_veiculo_inputs CHANGING v_input .

      IF v_input EQ abap_false.
        PERFORM f_save_data_veiculo.
      ELSE.
        v_input = abap_false.
      ENDIF.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0201  INPUT
*&---------------------------------------------------------------------*
MODULE exit_command_0201 INPUT.
  CALL SCREEN '0200'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
*       Menu Motorista
*----------------------------------------------------------------------*
MODULE user_command_0300 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_MOTO_CAD'.
      CALL SCREEN '0301'.

    WHEN 'FCT_MOTO_REL'.
      " criar tela

    WHEN 'FCT_BACK'.
      LEAVE TO SCREEN '0100'.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*-*
MODULE exit_command_0300 INPUT.
  CALL SCREEN '0100'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0301  INPUT
*&---------------------------------------------------------------------*
*       Cadastrar Motorista
*----------------------------------------------------------------------*
MODULE user_command_0301 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_BACK'.
      FREE w_ztmotoristas.
      LEAVE TO SCREEN '0300'.

    WHEN 'FCT_MENU'  .
      FREE w_ztmotoristas.
      LEAVE TO SCREEN '0100'.

    WHEN 'FCT_CLEAN'.
      FREE w_ztmotoristas.

    WHEN 'FCT_CANC'.
      LEAVE TO SCREEN '0300'.

    WHEN 'FCT_ADD'.
      PERFORM validate_motorista_inputs CHANGING v_input.

      IF v_input EQ abap_false.
        PERFORM f_save_data_motorista.
      ELSE.
        v_input = abap_false.
      ENDIF.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0301  INPUT
*&---------------------------------------------------------------------*
MODULE exit_command_0301 INPUT.
  CALL SCREEN '0300'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0400  INPUT
*&---------------------------------------------------------------------*
*       Menu Rota
*----------------------------------------------------------------------*
MODULE user_command_0400 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_ROTA_CAD'.
      CALL SCREEN '0401'.

    WHEN 'FCT_ROTA_REL'.
      " CALL SCREEN '0402'.

    WHEN 'FCT_BACK'.
      LEAVE TO SCREEN '0100'.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0400  INPUT
*&---------------------------------------------------------------------*
MODULE exit_command_0400 INPUT.
  CALL SCREEN '0100'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0401  INPUT
*&---------------------------------------------------------------------*
*       Cadastrar Rota
*----------------------------------------------------------------------*
MODULE user_command_0401 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_BACK'.
      FREE w_ztrotas.
      LEAVE TO SCREEN '0400'.

    WHEN 'FCT_MENU'.
      FREE w_ztrotas.
      LEAVE TO SCREEN '0100'.

    WHEN 'FCT_CLEAN'.
      FREE w_ztrotas.

    WHEN 'FCT_CANC'.
      FREE w_ztrotas.
      LEAVE TO SCREEN '0400'.

    WHEN 'FCT_ADD'.
      PERFORM validate_rota_inputs CHANGING v_input.

      IF v_input EQ abap_false.
        PERFORM f_save_data_rota.
      ELSE.
        v_input = abap_false.
      ENDIF.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0401  INPUT
*&---------------------------------------------------------------------*
MODULE exit_command_0401 INPUT.
  CALL SCREEN '0400'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0500  INPUT
*&---------------------------------------------------------------------*
*       Menu Ocorrência
*----------------------------------------------------------------------*
MODULE user_command_0500 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_OCOR_CAD'.
      CALL SCREEN '0501'.

    WHEN 'FCT_OCOR_REL'.
      " CALL SCREEN '0402'.

    WHEN 'FCT_BACK'.
      LEAVE TO SCREEN '0100'.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0500  INPUT
*&---------------------------------------------------------------------*
MODULE exit_command_0500 INPUT.
  CALL SCREEN '0100'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0501  INPUT
*&---------------------------------------------------------------------*
*       Cadastrar Ocorrência
*----------------------------------------------------------------------*
MODULE user_command_0501 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_BACK'.
      CLEAR: t_busca_entrega, t_busca_entrega[].
      FREE: w_ztocorrencias.
      LEAVE TO SCREEN '0500'.

    WHEN 'FCT_MENU'.
      CLEAR: t_busca_entrega, t_busca_entrega[].
      FREE: w_ztocorrencias.
      LEAVE TO SCREEN '0100'.

    WHEN 'FCT_CLEAN'.
      CLEAR: t_busca_entrega, t_busca_entrega[].
      FREE: w_ztocorrencias.

    WHEN 'FCT_ADD'.
      PERFORM validate_ocorrencia_inputs CHANGING v_input.

      IF v_input EQ abap_false.
        PERFORM f_save_data_ocorrencia.
      ELSE.
        v_input = abap_false.
      ENDIF.

    WHEN 'FCT_CANC'.
      CLEAR: t_busca_entrega, t_busca_entrega[].
      FREE: w_ztocorrencias.
      LEAVE TO SCREEN '0500'.

    WHEN 'FCT_SELECT_ENTR'.
      CALL SCREEN '0502' STARTING AT 20 2 ENDING AT 148 20.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0501  INPUT
*&---------------------------------------------------------------------*
MODULE exit_command_0501 INPUT.
  CALL SCREEN '0500'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0502  INPUT
*&---------------------------------------------------------------------*
*       Cadastrar Ocorrência => Selecionar Entrega
*&---------------------------------------------------------------------*
MODULE user_command_0502 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_BACK'.
      FREE: v_nome, v_placa, v_cpf, v_cnh,
            v_orige, v_desti, v_pais, v_staten.
      CLEAR: t_busca_entrega, t_busca_entrega[].

      CALL SCREEN '0501'.

    WHEN 'FCT_CLEAN'.
      FREE: t_busca_entrega, v_nome, v_placa, v_cpf, v_cnh,
            v_orige, v_desti, v_pais, v_staten.
      CLEAR: t_busca_entrega, t_busca_entrega[].

    WHEN 'FCT_SEARCH'.
      PERFORM f_select_entrega_data.

    WHEN 'FCT_ADD'.
      READ TABLE t_busca_entrega WITH KEY mark = 'X'.

      IF sy-subrc IS INITIAL.
        w_ztocorrencias-entrega_id = t_busca_entrega-entrega_id.
        CALL SCREEN '0501'.
      ENDIF.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  MARK_BUSCA_ENTREGA  INPUT
*&---------------------------------------------------------------------*
MODULE mark_busca_entrega INPUT.
  IF t_busca_entrega-mark = 'X'.
    LOOP AT t_busca_entrega WHERE mark = 'X'.  " Limpa mark
      FREE t_busca_entrega-mark.
      MODIFY t_busca_entrega INDEX sy-tabix TRANSPORTING mark.
    ENDLOOP.

    READ TABLE t_busca_entrega INDEX tc_0502-current_line.
    IF sy-subrc IS INITIAL.   " Selecionando mark
      t_busca_entrega-mark = 'X'.
      MODIFY t_busca_entrega INDEX sy-tabix TRANSPORTING mark.
    ENDIF.
  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0600  INPUT
*&---------------------------------------------------------------------*
*       Menu Entrega
*----------------------------------------------------------------------*
MODULE user_command_0600 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_ENTR_CAD'.
      CALL SCREEN '0601'.

    WHEN 'FCT_ENTR_REL'.
      " CALL SCREEN '0402'.

    WHEN 'FCT_BACK'.
      LEAVE TO SCREEN '0100'.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0600  INPUT
*&---------------------------------------------------------------------*
MODULE exit_command_0600 INPUT.
  CALL SCREEN '0100'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0601  INPUT
*&---------------------------------------------------------------------*
*       Cadastro de Entrega
*----------------------------------------------------------------------*
MODULE user_command_0601 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_SELECT_ROTA'.
      FREE: t_ztrotas_aux.
      CALL SCREEN '0602' STARTING AT 20 2 ENDING AT 78 20.

    WHEN 'FCT_SELECT_VEIC'.
      FREE: t_ztveiculos_aux.
      CALL SCREEN '0603' STARTING AT 20 2 ENDING AT 134 23.

    WHEN 'FCT_SELECT_MOTO'.
      FREE: t_ztmotoristas_aux.
      CALL SCREEN '0604' STARTING AT 20 2 ENDING AT 131 22. " Top, left, right, bottom

    WHEN 'FCT_BACK'.
      FREE: w_ztentregas, w_ztmotoristas, w_ztveiculos, w_ztrotas.
      LEAVE TO SCREEN '0600'.

    WHEN 'FCT_MENU'.
      FREE: w_ztentregas, w_ztmotoristas, w_ztveiculos, w_ztrotas.
      LEAVE TO SCREEN '0100'.

    WHEN 'FCT_CLEAN'.
      FREE: w_ztentregas, w_ztmotoristas, w_ztveiculos, w_ztrotas.

    WHEN 'FCT_ADD'.
      PERFORM validate_entrega_inputs CHANGING v_input.

      IF v_input EQ abap_false.
        PERFORM f_save_data_entrega.
      ELSE.
        v_input = abap_false.
      ENDIF.

    WHEN 'FCT_CANC'.
      FREE: w_ztentregas, w_ztmotoristas, w_ztveiculos, w_ztrotas.
      LEAVE TO SCREEN '600'.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0601  INPUT
*&---------------------------------------------------------------------*
MODULE exit_command_0601 INPUT.
  CALL SCREEN '0100'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0602  INPUT
*&---------------------------------------------------------------------*
*       Cadastrar Entrega => Selecionar Rota
*----------------------------------------------------------------------*
MODULE user_command_0602 INPUT.
  CASE sy-ucomm.

    WHEN 'FCT_BACK'.
      FREE: t_ztrotas_aux, v_desti, v_orige, v_pais.
      CALL SCREEN '0601'.

    WHEN 'FCT_CLEAN'.
      FREE: t_ztrotas_aux, v_desti, v_orige, v_pais.

    WHEN 'FCT_SEARCH'.
      PERFORM f_select_rota_data.

    WHEN: 'FCT_ADD'.
      READ TABLE t_ztrotas_aux WITH KEY mark = 'X'.

      IF sy-subrc IS INITIAL.
        MOVE-CORRESPONDING t_ztrotas_aux TO w_ztrotas.
        CALL SCREEN '0601'.
      ENDIF.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  MARK_ROTA  INPUT: SCREEN 0602
*&---------------------------------------------------------------------*
MODULE mark_rota INPUT.
  IF t_ztrotas_aux-mark = 'X'.
    LOOP AT t_ztrotas_aux WHERE mark = 'X'.  " Limpa mark
      FREE t_ztrotas_aux-mark.
      MODIFY t_ztrotas_aux INDEX sy-tabix TRANSPORTING mark.
    ENDLOOP.

    READ TABLE t_ztrotas_aux INDEX tc_0602-current_line.
    IF sy-subrc IS INITIAL.   " Selecinando mark
      t_ztrotas_aux-mark = 'X'.
      MODIFY t_ztrotas_aux INDEX sy-tabix TRANSPORTING mark.
    ENDIF.
  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0603  INPUT
*&---------------------------------------------------------------------*
*       Cadastrar Entrega => Selecionar Veículo
*&---------------------------------------------------------------------*
MODULE user_command_0603 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_BACK'.
      FREE: t_ztveiculos_aux, v_capac, v_placa, v_marca, v_model.
      CALL SCREEN '0601'.

    WHEN 'FCT_CLEAN'.
      FREE: t_ztveiculos_aux, v_capac, v_placa, v_marca, v_model.

    WHEN 'FCT_SEARCH'.
      PERFORM f_select_veiculo_data.

    WHEN 'FCT_ADD'.
      READ TABLE t_ztveiculos_aux WITH KEY mark = 'X'.

      IF sy-subrc IS INITIAL.
        MOVE-CORRESPONDING t_ztveiculos_aux TO w_ztveiculos.
        CALL SCREEN '0601'.
      ENDIF.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  MARK_VEICULO  INPUT: SCREEN 0603
*&---------------------------------------------------------------------*
MODULE mark_veiculo INPUT.
  IF t_ztveiculos_aux-mark = 'X'.
    LOOP AT t_ztveiculos_aux WHERE mark = 'X'.  " Limpa mark
      FREE t_ztveiculos_aux-mark.
      MODIFY t_ztveiculos_aux INDEX sy-tabix TRANSPORTING mark.
    ENDLOOP.

    READ TABLE t_ztveiculos_aux INDEX tc_0603-current_line.
    IF sy-subrc IS INITIAL.   " Selecinando mark
      t_ztveiculos_aux-mark = 'X'.
      MODIFY t_ztveiculos_aux INDEX sy-tabix TRANSPORTING mark.
    ENDIF.
  ENDIF.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0604  INPUT
*&---------------------------------------------------------------------*
*       Cadastrar Entrega => Selecionar Motorista
*&---------------------------------------------------------------------*
MODULE user_command_0604 INPUT.
  CASE sy-ucomm.
    WHEN 'FCT_BACK'.
      FREE: t_ztmotoristas_aux, v_cnh, v_cpf, v_nome, v_stamot.
      CALL SCREEN '0601'.

    WHEN 'FCT_CLEAN'.
      FREE: t_ztmotoristas_aux, v_cnh, v_cpf, v_nome, v_stamot.

    WHEN 'FCT_SEARCH'.
      PERFORM f_select_motorista_data.

    WHEN 'FCT_ADD'.
      READ TABLE t_ztmotoristas_aux WITH KEY mark = 'X'.

      IF sy-subrc IS INITIAL.
        MOVE-CORRESPONDING t_ztmotoristas_aux TO w_ztmotoristas.
        CALL SCREEN '0601'.
      ENDIF.

    WHEN OTHERS.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  MARK_MOTORISTA  INPUT: SCREEN 0604
*&---------------------------------------------------------------------*
MODULE mark_motorista INPUT.
  IF t_ztmotoristas_aux-mark = 'X'.
    LOOP AT t_ztmotoristas_aux WHERE mark = 'X'.  " Limpa mark
      FREE t_ztmotoristas_aux-mark.
      MODIFY t_ztmotoristas_aux INDEX sy-tabix TRANSPORTING mark.
    ENDLOOP.

    READ TABLE t_ztmotoristas_aux INDEX tc_0604-current_line.
    IF sy-subrc IS INITIAL.   " Selecinando mark
      t_ztmotoristas_aux-mark = 'X'.
      MODIFY t_ztmotoristas_aux INDEX sy-tabix TRANSPORTING mark.
    ENDIF.
  ENDIF.
ENDMODULE.
