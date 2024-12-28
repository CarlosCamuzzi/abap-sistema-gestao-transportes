
*& Include          SAPMZF01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form f_select_table
*&---------------------------------------------------------------------*
*& Selecionar tabela para criar o ID
*&---------------------------------------------------------------------*
FORM f_select_table USING p_tabname.

  DATA: lv_currid(5) TYPE c,
        lv_newid(5)  TYPE c.

  CASE p_tabname .
    WHEN 'ZTVEICULOS'.
      SELECT SINGLE MAX( veiculo_id )
       FROM ztveiculos
       INTO @lv_currid.

      PERFORM f_function_create_id
        USING lv_currid
        CHANGING lv_newid.

      w_ztveiculos-veiculo_id = lv_newid.

    WHEN 'ZTMOTORISTAS'.
      SELECT SINGLE MAX( motorista_id )
       FROM ztmotoristas
       INTO @lv_currid.

      PERFORM f_function_create_id
        USING lv_currid
        CHANGING lv_newid.

      w_ztmotoristas-motorista_id = lv_newid.

    WHEN 'ZTROTAS'.

      SELECT SINGLE MAX( rota_id )
       FROM ztrotas
       INTO @lv_currid.

      PERFORM f_function_create_id
        USING lv_currid
        CHANGING lv_newid.

      w_ztrotas-rota_id = lv_newid.

    WHEN 'ZTENTREGAS'.
      SELECT SINGLE MAX( entrega_id )
        FROM ztentregas
        INTO @lv_currid.

      PERFORM f_function_create_id
        USING lv_currid
        CHANGING lv_newid.

      w_ztentregas-entrega_id = lv_newid.

    WHEN 'ZTOCORRENCIAS'.

      SELECT SINGLE MAX( ocorrencia_id )
       FROM ztocorrencias
       INTO @lv_currid.

      PERFORM f_function_create_id
        USING lv_currid
        CHANGING lv_newid.

      w_ztocorrencias-ocorrencia_id = lv_newid.

    WHEN OTHERS.
  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_function_create_id
*&---------------------------------------------------------------------*
*& Chamando função que gera o ID
*&---------------------------------------------------------------------*
FORM f_function_create_id  USING VALUE(p_lv_currid)
                           CHANGING p_lv_newid.

  p_lv_currid = p_lv_currid + 1.
  " Essa função acrescenta zero à esquerda em strings numéricas
  IF strlen( p_lv_currid ) NE 0.
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = p_lv_currid
      IMPORTING
        output = p_lv_newid.

  ELSE.     " Primeiro ID
    p_lv_newid = '00001'.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_select_rota_data: SCREEN 0602
*&---------------------------------------------------------------------*
FORM f_select_rota_data .

  FREE t_ztrotas_aux.

  DATA: lv_where_clause TYPE string,
        lv_count        TYPE i VALUE 0,     " Contador para quantidade de AND
        lv_len          TYPE i VALUE 0.     " Verifica se há alguma string na lv_where_clause

  " Construir a cláusula WHERE dinamicamente
  IF v_pais IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | pais LIKE '{ v_pais }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_orige IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | uf_origem LIKE '{ v_orige }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_desti IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | uf_destino LIKE '{ v_desti }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  lv_len = strlen( lv_where_clause ) - 1.

  IF lv_len > 0.
    TRY.
        " Remover última AND, se existir
        lv_where_clause = substring_before( val = lv_where_clause  sub = ' AND' occ = lv_count ).

      CATCH cx_sy_range_out_of_bounds.
        MESSAGE: 'CX_SY_RANGE_OUT_OF_BOUNDS' TYPE 'E'.

      CATCH cx_sy_strg_par_val.
        MESSAGE: 'CX_SY_STRG_PAR_VAL' TYPE 'E'.

      CATCH cx_sy_regex_too_complex.
        MESSAGE: 'CX_SY_REGEX_TOO_COMPLEX' TYPE 'E'.

    ENDTRY.
  ENDIF.

  TRY.
      IF lv_where_clause IS NOT INITIAL. " Query dinâmica
        SELECT *
          FROM ztrotas
          INTO TABLE t_ztrotas_aux
            WHERE (lv_where_clause)
          ORDER BY rota_id.
      ELSE.                               " Todos registros
        SELECT *
          FROM ztrotas
          INTO TABLE t_ztrotas_aux
          ORDER BY rota_id.
      ENDIF.

    CATCH cx_sy_dynamic_osql_syntax.
      MESSAGE: 'CX_SY_DYNAMIC_OSQL_SYNTAX' TYPE 'E'.

    CATCH cx_sy_dynamic_osql_semantics.
      MESSAGE: 'CX_SY_DYNAMIC_OSQL_SEMANTICS' TYPE 'E'.

  ENDTRY.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_select_veiculo_data: SCREEN 0603
*&---------------------------------------------------------------------*
FORM f_select_veiculo_data .

  FREE: t_ztveiculos_aux.

  DATA: lv_where_clause TYPE string,
        lv_count        TYPE i VALUE 0,     " Contador para quantidade de AND
        lv_len          TYPE i VALUE 0.     " Verifica se há alguma string na lv_where_clause

  " Construir a cláusula WHERE dinamicamente
  IF v_placa IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | placa LIKE '{ v_placa }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_marca IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | marca LIKE '{ v_marca }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_model IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | modelo LIKE '{ v_model }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  " dump aqui - ideal seria um range
  IF v_capac IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | capacidade LIKE '{ v_capac }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_stavei IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | status = '{ v_stavei }' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  lv_len = strlen( lv_where_clause ).

  IF lv_len > 0.
    TRY.
        " Remover última AND, se existir
        lv_where_clause = substring_before( val = lv_where_clause  sub = ' AND' occ = lv_count ).

      CATCH cx_sy_range_out_of_bounds.
        MESSAGE: 'CX_SY_RANGE_OUT_OF_BOUNDS' TYPE 'E'.

      CATCH cx_sy_strg_par_val.
        MESSAGE: 'CX_SY_STRG_PAR_VAL' TYPE 'E'.

      CATCH cx_sy_regex_too_complex.
        MESSAGE: 'CX_SY_REGEX_TOO_COMPLEX' TYPE 'E'.

    ENDTRY.
  ENDIF.

  TRY.
      IF lv_where_clause IS NOT INITIAL. " Query dinâmica
        SELECT *
          FROM ztveiculos
          INTO TABLE t_ztveiculos_aux
            WHERE (lv_where_clause)
          ORDER BY marca.
      ELSE.                               " Todos registros
        SELECT *
          FROM ztveiculos
          INTO TABLE t_ztveiculos_aux
          ORDER BY marca.
      ENDIF.

    CATCH cx_sy_dynamic_osql_syntax.
      MESSAGE: 'CX_SY_DYNAMIC_OSQL_SYNTAX' TYPE 'E'.

    CATCH cx_sy_dynamic_osql_semantics.
      MESSAGE: 'CX_SY_DYNAMIC_OSQL_SEMANTICS' TYPE 'E'.

  ENDTRY.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_select_motorista_data: SCREEN 0604
*&---------------------------------------------------------------------*
FORM f_select_motorista_data .

  FREE: t_ztmotoristas_aux.

  DATA: lv_where_clause TYPE string,
        lv_count        TYPE i VALUE 0,
        lv_len          TYPE i VALUE 0.

  IF v_nome IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | nome LIKE '{ v_nome }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_cpf IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | cpf LIKE '{ v_cpf }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_cnh IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | cnh LIKE '{ v_cnh }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_stamot IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | status = '{ v_stamot }' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  lv_len = strlen( lv_where_clause ).

  IF lv_len > 0.
    TRY.
        lv_where_clause = substring_before( val = lv_where_clause sub = ` AND` occ = lv_count ).

      CATCH cx_sy_range_out_of_bounds.
        MESSAGE: 'CX_SY_RANGE_OUT_OF_BOUNDS' TYPE 'E'.

      CATCH cx_sy_strg_par_val.
        MESSAGE: 'CX_SY_STRG_PAR_VAL' TYPE 'E'.

      CATCH cx_sy_regex_too_complex.
        MESSAGE: 'CX_SY_REGEX_TOO_COMPLEX' TYPE 'E'.
    ENDTRY.
  ENDIF.

  TRY.
      IF lv_where_clause IS NOT INITIAL.
        SELECT * FROM ztmotoristas
          INTO TABLE t_ztmotoristas_aux
          WHERE (lv_where_clause)
          ORDER BY nome.
      ELSE.
        SELECT * FROM ztmotoristas
            INTO TABLE t_ztmotoristas_aux
            ORDER BY nome.
      ENDIF.
    CATCH cx_sy_dynamic_osql_syntax.
      MESSAGE: 'CX_SY_DYNAMIC_OSQL_SYNTAX' TYPE 'E'.

  ENDTRY.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_select_entrega_data: SCREEN 0502
*&---------------------------------------------------------------------*
FORM f_select_entrega_data .

  FREE: t_busca_entrega.

  DATA: lv_where_clause TYPE string,
        lv_count        TYPE i VALUE 0,
        lv_len          TYPE i VALUE 0.

  IF v_nome IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | UPPER( m~nome ) LIKE '{ v_nome }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_cpf IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | m~cpf LIKE '{ v_cpf }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_cnh IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | m~cnh LIKE '{ v_cnh }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_pais IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | r~pais LIKE '{ v_pais }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_orige IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | r~uf_origem LIKE '{ v_orige }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_desti IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | r~uf_destino LIKE '{ v_desti }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_placa IS NOT INITIAL.
    lv_where_clause = lv_where_clause && | UPPER( v~placa ) LIKE '{ v_placa }%' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_semoc EQ abap_true.
    lv_where_clause = lv_where_clause && | e~ocorrencia_id = '' AND |.
    lv_count = lv_count + 1.
  ENDIF.

  IF v_nofina EQ abap_true.
    lv_where_clause = lv_where_clause && | NOT e~status = 'FINALIZADA' AND |.
    lv_count = lv_count + 1.

  ELSE.
    lv_where_clause = lv_where_clause && | e~status LIKE '{ v_staten }%' AND |.
    lv_count = lv_count + 1.

  ENDIF.

  lv_len = strlen( lv_where_clause ).

  IF lv_len > 0.
    TRY.
        lv_where_clause = substring_before( val = lv_where_clause sub = ` AND` occ = lv_count ).

      CATCH cx_sy_range_out_of_bounds.
        MESSAGE: 'CX_SY_RANGE_OUT_OF_BOUNDS' TYPE 'E'.

      CATCH cx_sy_strg_par_val.
        MESSAGE: 'CX_SY_STRG_PAR_VAL' TYPE 'E'.

      CATCH cx_sy_regex_too_complex.
        MESSAGE: 'CX_SY_REGEX_TOO_COMPLEX' TYPE 'E'.
    ENDTRY.
  ENDIF.

  TRY.
      IF lv_where_clause IS NOT INITIAL.
        SELECT
          e~entrega_id, m~nome, m~cpf, m~cnh,
          r~pais, r~uf_origem, r~uf_destino,
          v~placa, e~status, e~ocorrencia_id
        FROM ztentregas AS e
         INNER JOIN ztmotoristas AS m ON e~motorista_id = m~motorista_id
         INNER JOIN ztveiculos AS v ON e~veiculo_id = v~veiculo_id
         INNER JOIN ztrotas AS r ON e~rota_id = r~rota_id
        WHERE (lv_where_clause)
        ORDER BY e~entrega_id
        INTO TABLE @t_busca_entrega.
      ENDIF.

    CATCH cx_sy_dynamic_osql_syntax.
      MESSAGE: 'CX_SY_DYNAMIC_OSQL_SYNTAX' TYPE 'E'.

    CATCH cx_sy_open_sql_db.
      MESSAGE: 'CX_SY_OPEN_SQL_D' TYPE 'E'.

  ENDTRY.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_save_data
*&---------------------------------------------------------------------*
FORM f_save_data_veiculo .

  FREE ztveiculos.
  MOVE-CORRESPONDING w_ztveiculos TO ztveiculos.
  MODIFY ztveiculos.

  IF sy-subrc IS INITIAL.
    COMMIT WORK.
    MESSAGE s000.   " Dados salvos com sucesso
    FREE: w_ztveiculos.
  ELSE.
    ROLLBACK WORK.
    MESSAGE i001.   " Erro ao salvar dados
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_save_data_motorista
*&---------------------------------------------------------------------*
FORM f_save_data_motorista .

  FREE ztmotoristas.
  MOVE-CORRESPONDING w_ztmotoristas TO ztmotoristas.
  MODIFY ztmotoristas.

  IF sy-subrc IS INITIAL.
    COMMIT WORK.
    MESSAGE s000.   " Dados salvos com sucesso
    FREE: w_ztmotoristas.
  ELSE.
    ROLLBACK WORK.
    MESSAGE i001.   " Erro ao salvar dados
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_save_data_rota
*&---------------------------------------------------------------------*
FORM f_save_data_rota .

  FREE ztrotas.

  w_ztrotas-pais = w_ztrotas-land1.
  w_ztrotas-uf_origem = w_ztrotas-bland_orig.
  w_ztrotas-uf_destino = w_ztrotas-bland_dest.

  MOVE-CORRESPONDING w_ztrotas TO ztrotas.
  MODIFY ztrotas.

  IF sy-subrc IS INITIAL.
    COMMIT WORK.
    MESSAGE s000.   " Dados salvos com sucesso
    FREE: w_ztrotas.
  ELSE.
    ROLLBACK WORK.
    MESSAGE i001.   " Erro ao salvar dados
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_save_data_ocorrencia
*&---------------------------------------------------------------------*
FORM f_save_data_ocorrencia .

  FREE ztocorrencias.

  MOVE-CORRESPONDING w_ztocorrencias TO ztocorrencias.
  MODIFY ztocorrencias.

  IF sy-subrc IS INITIAL.

    " Atualizar ocorrência_id na tabela de entregas
    UPDATE ztentregas
      SET ocorrencia_id = w_ztocorrencias-ocorrencia_id
      WHERE entrega_id = w_ztocorrencias-entrega_id.

    IF sy-subrc IS INITIAL.
      COMMIT WORK.
      MESSAGE s000.   " Dados salvos com sucesso

      CLEAR: t_busca_entrega, t_busca_entrega[].
      FREE: w_ztocorrencias.

    ELSE.
      ROLLBACK WORK.
      MESSAGE i001.   " Erro ao salvar dados
    ENDIF.

  ELSE.
    ROLLBACK WORK.
    MESSAGE i001.   " Erro ao salvar dados
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_save_data_entrega
*&---------------------------------------------------------------------*
FORM f_save_data_entrega .

  FREE ztentregas.

  w_ztentregas-veiculo_id = w_ztveiculos-veiculo_id.
  w_ztentregas-motorista_id = w_ztmotoristas-motorista_id.
  w_ztentregas-rota_id = w_ztrotas-rota_id.

  MOVE-CORRESPONDING w_ztentregas TO ztentregas.
  MODIFY ztentregas.

  IF sy-subrc IS INITIAL.
    COMMIT WORK.
    MESSAGE s000.   " Dados salvos com sucesso
    FREE: w_ztentregas, w_ztrotas, w_ztveiculos, w_ztmotoristas.
  ELSE.
    ROLLBACK WORK.
    MESSAGE i001.   " Erro ao salvar dados
  ENDIF.

ENDFORM.


**********************************************************************
*  FORM validação de Inputs do usuário
**********************************************************************
*&---------------------------------------------------------------------*
*& Form validate_veiculo_inputs
*&---------------------------------------------------------------------**
FORM validate_veiculo_inputs  CHANGING p_v_input.

  DATA: vl_count TYPE i VALUE 1.

  DO.
    IF p_v_input EQ abap_true.
      EXIT.
    ENDIF.

    CASE vl_count.
      WHEN 1.
        PERFORM validate_veiculo_placa CHANGING p_v_input.
      WHEN 2.
        PERFORM validate_veiculo_modelo CHANGING p_v_input.
      WHEN 3.
        PERFORM validate_veiculo_marca CHANGING p_v_input.
      WHEN 4.
        PERFORM validate_veiculo_capacidade CHANGING p_v_input.
      WHEN 5.
        PERFORM validate_veiculo_status CHANGING p_v_input.
      WHEN OTHERS.
    ENDCASE.

    vl_count = vl_count + 1.

  ENDDO.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form validate_veiculo_placa
*&---------------------------------------------------------------------*
FORM validate_veiculo_placa CHANGING vl_input.
  IF w_ztveiculos-placa IS INITIAL.
    vl_input = abap_true.
    MESSAGE i007.   " É obrigatório informar a placa

  ELSE.
    SELECT SINGLE placa
      FROM ztveiculos
      INTO @DATA(vl_placa)
      WHERE placa = @w_ztveiculos-placa.

    IF sy-subrc IS INITIAL.
      vl_input = abap_true.
      MESSAGE i002 WITH vl_placa.   " A placa &1 já possui cadastro

    ENDIF.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_veiculo_modelo
*&---------------------------------------------------------------------*
FORM validate_veiculo_modelo CHANGING p_v_input.
  IF w_ztveiculos-modelo IS INITIAL.
    p_v_input = abap_true.
    MESSAGE: i003.    " É obrigatório informar o modelo
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_veiculo_marca
*&---------------------------------------------------------------------*
FORM validate_veiculo_marca CHANGING p_v_input.
  IF w_ztveiculos-marca IS INITIAL.
    p_v_input = abap_true.
    MESSAGE: i004.    " É obrigatório informar a marca
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_veiculo_capacidade
*&---------------------------------------------------------------------*
FORM validate_veiculo_capacidade CHANGING p_v_input.
  IF w_ztveiculos-capacidade IS INITIAL.
    p_v_input = abap_true.
    MESSAGE: i005.    " É obrigatório informar a capacidade
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_veiculo_status
*&---------------------------------------------------------------------*
FORM validate_veiculo_status CHANGING p_v_input.
  IF w_ztveiculos-status IS INITIAL.
    p_v_input = abap_true.
    MESSAGE: i006.    " É obrigatório informar o status
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_motorista_inputs
*&---------------------------------------------------------------------*
FORM validate_motorista_inputs  CHANGING p_v_input.

  DATA: vl_count TYPE i VALUE 1.

  DO.
    IF p_v_input EQ abap_true.
      EXIT.
    ENDIF.

    CASE vl_count.
      WHEN 1.
        PERFORM validate_motorista_nome CHANGING p_v_input.
      WHEN 2.
        PERFORM validate_motorista_cpf CHANGING p_v_input.
      WHEN 3.
        PERFORM validate_motorista_cnh CHANGING p_v_input.
      WHEN 4.
        PERFORM validate_motorista_valid_cnh CHANGING p_v_input.
      WHEN 5.
        PERFORM validate_motorista_status CHANGING p_v_input.
      WHEN OTHERS.
        EXIT.
    ENDCASE.

    vl_count = vl_count + 1.

  ENDDO.

ENDFORM.

*&---------------------------------------------------------------------*
*&      FORM VALIDATE_NOME
*&---------------------------------------------------------------------*
FORM validate_motorista_nome CHANGING p_v_input.
  IF w_ztmotoristas-nome IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i008.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      FORM  VALIDATE_CPF
*&---------------------------------------------------------------------*
FORM validate_motorista_cpf CHANGING p_v_input.

  IF w_ztmotoristas-cpf IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i009.   " É obrigatório informar o número do CPF

  ELSE.
    SELECT SINGLE cpf
      INTO @DATA(vl_cpf)
      FROM ztmotoristas
      WHERE cpf = @w_ztmotoristas-cpf.

    IF sy-subrc IS INITIAL.
      p_v_input = abap_true.
      MESSAGE i010 WITH vl_cpf.   " O CPF &1 já possui cadastro, verifique
    ENDIF.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      FORM VALIDATE_CNH
*&---------------------------------------------------------------------*
FORM validate_motorista_cnh CHANGING p_v_input.

  IF w_ztmotoristas-cnh IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i011.   " É obrigatório informar o número da CNH

  ELSE.
    SELECT SINGLE cnh
      INTO @DATA(vl_cnh)
      FROM ztmotoristas
      WHERE cnh = @w_ztmotoristas-cnh.

    IF sy-subrc IS INITIAL.
      p_v_input = abap_true.
      MESSAGE i012 WITH vl_cnh.   " A CNH &1 já possui cadastro, verifique
    ENDIF.

  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      FORM VALIDATE_VALIDADE_CNH
*&---------------------------------------------------------------------*
FORM validate_motorista_valid_cnh CHANGING p_v_input.
  IF w_ztmotoristas-validade_cnh IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i013.   " É obrigatório informar a data de validade da CNH
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      FORM VALIDATE_STATUS_MOTORISTA
*&---------------------------------------------------------------------*
FORM validate_motorista_status CHANGING p_v_input.
  IF w_ztmotoristas-status IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i006.   " É obrigatório informar o status
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_rota_inputs
*&---------------------------------------------------------------------*
FORM validate_rota_inputs  CHANGING p_v_input.

  DATA: vl_count TYPE i VALUE 1.

  DO.
    IF p_v_input EQ abap_true.
      EXIT.
    ENDIF.

    CASE vl_count.
      WHEN 1.
        PERFORM validate_rota_pais CHANGING p_v_input.
      WHEN 2.
        PERFORM validate_rota_uf_origem CHANGING p_v_input.
      WHEN 3.
        PERFORM validate_motorista_cnh CHANGING p_v_input.
      WHEN 4.
        PERFORM validate_rota_uf_destino CHANGING p_v_input.
      WHEN 5.
        PERFORM validate_rota_distancia CHANGING p_v_input.
      WHEN 6.
        PERFORM validate_rota_unid_medida CHANGING p_v_input.
      WHEN OTHERS.
        EXIT.
    ENDCASE.

    vl_count = vl_count + 1.

  ENDDO.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  VALIDATE_ROTA_PAIS
*&---------------------------------------------------------------------*
FORM validate_rota_pais CHANGING p_v_input.
  IF w_ztrotas-land1 IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i014.   " É obrigatório informar o país
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  VALIDATE_ROTA_UF_ORIGEM
*&---------------------------------------------------------------------*
FORM validate_rota_uf_origem CHANGING p_v_input.
  IF w_ztrotas-bland_orig IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i015.   " É obrigatório informar o estado (UF) de origem
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  VALIDATE_ROTA_UF_DESTINO
*&---------------------------------------------------------------------*
FORM validate_rota_uf_destino CHANGING p_v_input.
  IF w_ztrotas-bland_dest IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i016.   " É obrigatório informar o estado (UF) de destino
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  VALIDATE_ROTA_DISTANCIA
*&---------------------------------------------------------------------*
FORM validate_rota_distancia CHANGING p_v_input.
  IF w_ztrotas-distancia IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i017.   " É obrigatório informar a distância
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  VALIDATE_ROTA_UNID_MEDIDA
*&---------------------------------------------------------------------*
FORM validate_rota_unid_medida CHANGING p_v_input.
  IF w_ztrotas-pais EQ space.
    p_v_input = abap_true.
    MESSAGE i018.   " É obrigatório informar a unidadade de medida
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_ocorrencia_inputs
*&---------------------------------------------------------------------*
FORM validate_ocorrencia_inputs  CHANGING p_v_input.

  DATA: vl_count TYPE i VALUE 1.

  DO.
    IF p_v_input EQ abap_true.
      EXIT.
    ENDIF.

    CASE vl_count.
      WHEN 1.
        PERFORM validate_ocorrencia_entrega_id CHANGING p_v_input.
      WHEN 2.
        PERFORM validate_ocorrencia_desc CHANGING p_v_input.
      WHEN OTHERS.
        EXIT.
    ENDCASE.

    vl_count = vl_count + 1.

  ENDDO.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form validate_ocorrencia_entrega_id
*&---------------------------------------------------------------------*
FORM validate_ocorrencia_entrega_id  CHANGING p_v_input.
  IF w_ztocorrencias-entrega_id IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i019.   " É obrigatório informar a entrega
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_ocorrencia_desc
*&---------------------------------------------------------------------*
FORM validate_ocorrencia_desc  CHANGING p_v_input.
  IF w_ztocorrencias-descricao IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i020.   " É obrigatório informar a descrição
  ENDIF.
ENDFORM.


*&---------------------------------------------------------------------*
*& FORM validate_entrega_inputs
*&---------------------------------------------------------------------*
FORM validate_entrega_inputs  CHANGING p_v_input.


  DATA: vl_count TYPE i VALUE 1.

  DO.
    IF p_v_input EQ abap_true.
      EXIT.
    ENDIF.

    CASE vl_count.
      WHEN 1.
        PERFORM validate_entrega_veiculo_id CHANGING p_v_input.
      WHEN 2.
        PERFORM validate_entrega_rota_id CHANGING p_v_input.
      WHEN 3.
        PERFORM validate_entrega_motorista_id CHANGING p_v_input.
      WHEN 4.
        PERFORM validate_entrega_status CHANGING p_v_input.
      WHEN 5.
        PERFORM validate_entrega_data_entrega CHANGING p_v_input.
      WHEN OTHERS.
        EXIT.
    ENDCASE.

    vl_count = vl_count + 1.

  ENDDO.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_entrega_veiculo_id
*&---------------------------------------------------------------------*
FORM validate_entrega_veiculo_id  CHANGING p_v_input.
  IF w_ztveiculos-veiculo_id IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i021.   " É obrigatório informar o veículo
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_entrega_rota_id
*&---------------------------------------------------------------------*
FORM validate_entrega_rota_id  CHANGING p_v_input.
  IF w_ztrotas-rota_id IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i025.   " É obrigatório informar a rota
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_entrega_motorista_id
*&---------------------------------------------------------------------*
FORM validate_entrega_motorista_id  CHANGING p_v_input.
  IF w_ztmotoristas-motorista_id IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i022.   " É obrigatório informar o motorista
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form validate_entrega_status
*&---------------------------------------------------------------------*
FORM validate_entrega_status  CHANGING p_v_input.
  IF w_ztentregas-status IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i006.   " É obrigatório informar o status
  ENDIF.
ENDFORM.

FORM validate_entrega_data_entrega  CHANGING p_v_input.
  IF w_ztentregas-data_entrega IS INITIAL.
    p_v_input = abap_true.
    MESSAGE i024.   " É obrigatório informar a data prevista
  ENDIF.
ENDFORM.
