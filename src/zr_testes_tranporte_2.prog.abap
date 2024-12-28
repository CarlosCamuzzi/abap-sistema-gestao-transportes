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

START-OF-SELECTION.
*DELETE FROM ZTVEICULOS WHERE VEICULO_ID = '00004'
*                          OR VEICULO_ID = '00005'
*                          OR VEICULO_ID = '00006'.

*DELETE FROM ZTENTREGAS WHERE ENTREGA_ID = '00014'
*                          OR ENTREGA_ID = '00015'
*                          OR ENTREGA_ID = '00016'
*                          OR ENTREGA_ID = '00017'.

UPDATE ZTENTREGAS
  SET STATUS = 'FINALIZADA'
  WHERE STATUS = 'FINALIZAD'.
