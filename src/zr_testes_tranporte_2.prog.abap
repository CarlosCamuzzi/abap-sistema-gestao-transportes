*&---------------------------------------------------------------------*
*& Report ZR_TESTES_TRANPORTE_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zr_testes_tranporte_2.

"START-OF-SELECTION.
*  UPDATE ztentregas
*    SET status = 'FINALIZADA'
*    WHERE status = 'FINALIZAD'.

"DELETE FROM ztentregas WHERE status = ''.
"DELETE FROM ztentregas WHERE VEICULO_ID = ''.

*  UPDATE ZTMOTORISTAS
*    SET STATUS = 'DISPONÍVEL',
*        NOME = UPPER( NOME )
*    WHERE MOTORISTA_ID = '00001'
*      OR MOTORISTA_ID = '00004'
*      OR MOTORISTA_ID = '00005'.


**********************************************************************
* ATUALIZANDO CNH E CPF
*DATA: t_ztmotoristas TYPE TABLE OF ztmotoristas,
*      w_ztmotoristas TYPE ztmotoristas.

*t_ztmotoristas = VALUE #(
*  ( motorista_id = '00001' cnh = '265449842' cpf = '12445858911' )
*  ( motorista_id = '00002' cnh = '348912345' cpf = '98765432100' )
*  ( motorista_id = '00003' cnh = '789456123' cpf = '45678912300' )
*  ( motorista_id = '00004' cnh = '987654321' cpf = '78912345600' )
*  ( motorista_id = '00005' cnh = '124246789' cpf = '32165498700' )
*)

" Loop para realizar as atualizações
*LOOP AT t_ztmotoristas INTO w_ztmotorista.
*  UPDATE ztmotoristas
*    SET cnh = w_ztmotorista-cnh
*    WHERE motorista_id = w_ztmotorista-motorista_id.
*ENDLOOP.


**********************************************************************
" CORRIGINDO DATA
*PARAMETERS: p_date TYPE erdat,
*            p_id   TYPE zemoto_001.
*
*START-OF-SELECTION.
*  UPDATE ztmotoristas
*    SET validade_cnh = p_date
*  WHERE motorista_id = p_id.

**********************************************************************
" ATUALIZANDO DADOS DE PLACA E STATUS
*  DATA: t_ztveiculos TYPE TABLE OF ztveiculos,
*        w_ztveiculos TYPE ztveiculos.
*
*  t_ztveiculos = VALUE #(
*     ( veiculo_id = '00004' placa = 'FFG2H33' status = 'EM ENTREGA' )
*     ( veiculo_id = '00005' placa = 'UOI5L66')
*     ( veiculo_id = '00006' placa = 'AFH8P55')
*  ).
*

"START-OF-SELECTION.
*  LOOP AT t_ztveiculos INTO w_ztveiculos.
*    UPDATE ztveiculos
*      SET placa = w_ztveiculos-placa
*          status = w_ztveiculos-status
*      WHERE veiculo_id = w_ztveiculos-veiculo_id.
*  ENDLOOP.

"DELETE FROM ZTVEICULOS WHERE VEICULO_ID = '00005' OR VEICULO_ID = '00006'.
"DELETE FROM ZTENTREGAS  WHERE VEICULO_ID = '00004' OR VEICULO_ID = '00006'.
*
*DELETE FROM ZTOCORRENCIAS.
*DELETE FROM ZTENTREGAS WHERE OCORRENCIA_ID = '00005'.


**********************************************************************


**********************************************************************

"START-OF-SELECTION.
*DELETE FROM ZTVEICULOS WHERE VEICULO_ID = '00004'
*                          OR VEICULO_ID = '00005'
*                          OR VEICULO_ID = '00006'.

*DELETE FROM ZTENTREGAS WHERE ENTREGA_ID = '00014'
*                          OR ENTREGA_ID = '00015'
*                          OR ENTREGA_ID = '00016'
*                          OR ENTREGA_ID = '00017'.

*UPDATE ZTENTREGAS
*  SET STATUS = 'FINALIZADA'
*  WHERE STATUS = 'FINALIZAD'.
*
*UPDATE ztmotoristas
*  SET status = 'DISPONIVEL'
*  where status = 'DISPONÍVEL'.

*UPDATE ZTVEICULOS
*    SET status = 'DISPONIVEL'
*  where status = 'DISPONÍVEL'.
*
*UPDATE ZTROTAS
*  SET MEINS = 'KM'
*  WHERE ROTA_ID = '00001'.
*
*UPDATE ZTROTAS
*  SET DISTANCIA = 1111
*  WHERE ROTA_ID = '00001'.
*
*UPDATE ZTROTAS
*  SET DISTANCIA = 432
*  WHERE ROTA_ID = '00002'.
*
*UPDATE ZTROTAS
*  SET DISTANCIA = 540
*  WHERE ROTA_ID = '00003'.

"DELETE FROM ZTVEICULOS WHERE STATUS = ''.

**********************************************************************
*DATA: lv_length TYPE DDLENG.
*
*START-OF-SELECTION.
*SELECT SINGLE leng
*  INTO lv_length
*  FROM dd03l
*  WHERE tabname = 'ZTROTAS'
*    AND fieldname = 'DISTANCIA'.
*
*IF sy-subrc = 0.
*  WRITE: / 'Tamanho do campo:', lv_length.
*ELSE.
*  WRITE: / 'Campo não encontrado.'.
*ENDIF.

**********************************************************************
*DATA: lv_length TYPE i,
*      lv_cast   TYPE string,
*      lv_quan   TYPE zerota_003 .
*
*START-OF-SELECTION.
*  SELECT SINGLE distancia
*    INTO @DATA(lv_value)
*    FROM  ztrotas
*    WHERE rota_id = '00001'.
*
*  WRITE:/ lv_value.
*
*  lv_cast = lv_value.
*  lv_length  = strlen( lv_cast ). " 9 com ponto e vírgula
*
*  WRITE:/ lv_length.
*
*  TRY .
*
*      CONDENSE lv_cast NO-GAPS.
*      REPLACE '.' WITH ',' INTO lv_cast.
*
*  " Erro ocorre na conversão, após o replace muda  de . para ,
*      lv_quan = CONV zerota_003( lv_cast ).
*      WRITE:/ lv_quan.
*
*    CATCH cx_sy_conversion_no_number.
*      MESSAGE: 'CX_SY_CONVERSION_NO_NUMBER' TYPE 'E'.
*
*  ENDTRY.


"FREE: lv_cast, lv_length.

**********************************************************************

*  TYPES: BEGIN OF ty_rotas.
*    INCLUDE STRUCTURE: ztrotas.
*    TYPES: dist_length TYPE i,
*    END OF ty_rotas.
*
*  DATA: lt_fixed  TYPE TABLE OF ztrotas,
*        wa_fixed  TYPE ztrotas,
*        lt_rotas  TYPE TABLE OF ty_rotas,
*        lv_cast   TYPE string,
*        lv_number TYPE ZEROTA_003.
*
*  TRY .
*      SELECT * FROM ztrotas
*          INTO TABLE lt_rotas
*          WHERE rota_id = '00059'.
*
*      LOOP AT lt_rotas INTO DATA(wa_rotas).
*        lv_cast = wa_rotas-distancia.
*
*        IF strlen( lv_cast ) EQ 9.
*          CONDENSE lv_cast NO-GAPS.
*          REPLACE '.' WITH ',' INTO lv_cast.
*          lv_number = lv_cast.
*          wa_rotas-distancia = lv_number.
*          APPEND wa_rotas TO lt_rotas.
*        ENDIF.
*
*      ENDLOOP.
*    CATCH cx_sy_conversion_no_number.
*
*      MESSAGE: 'CX_SY_CONVERSION_NO_NUMBER' TYPE 'E'.
*  ENDTRY.

**********************************************************************

START-OF-SELECTION.
  "delete from ztentregas.
*delete from ztocorrencias.

*  SELECT * FROM ztentregas
*    INTO TABLE @DATA(lt_entregas).
*
*  cl_demo_output=>write_data( lt_entregas ).
*  cl_demo_output=>display(  ).
*

  TYPES: BEGIN OF ty_busca,
           entrega_id    TYPE ztentregas-entrega_id,
           ocorrencia_id TYPE ztocorrencias-ocorrencia_id,
           descricao     TYPE ztocorrencias-descricao,
         END OF ty_busca.

  DATA: lt_busca TYPE TABLE OF ty_busca.

  " Somente entregas com ocorrencia
*  SELECT e~entrega_id,
*         o~ocorrencia_id,
*         o~descricao
*  FROM ztocorrencias AS o
*    INNER JOIN ztentregas AS e
*      ON e~entrega_id = o~entrega_id
*     INTO TABLE @lt_busca.

  " Entregas com ou sem ocorrência
*  SELECT e~entrega_id,
*         o~ocorrencia_id,
*         o~descricao
*  FROM ztocorrencias AS o
*   RIGHT JOIN ztentregas AS e
*    ON e~entrega_id = o~entrega_id
*    INTO TABLE @lt_busca.

  SELECT e~entrega_id,
         o~ocorrencia_id,
         o~descricao
  FROM ztocorrencias AS o
    RIGHT JOIN ztentregas AS e
      ON e~entrega_id = o~entrega_id
     "WHERE o~ocorrencia_id IS NULL
    where COALESCE( o~ocorrencia_id, ' ' ) = ' '
    INTO TABLE @lt_busca.

  cl_demo_output=>write_data( lt_busca ).
  cl_demo_output=>display(  ).
