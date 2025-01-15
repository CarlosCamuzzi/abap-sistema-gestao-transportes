*&---------------------------------------------------------------------*
*& Report ZRTRANSP_ALV_VEIC
*&---------------------------------------------------------------------*
* Relatório de rotas que um veículo fez durante um range de data
*&---------------------------------------------------------------------*
*   Estrutura: ZSTRUC_VEIC_ROTA
*&---------------------------------------------------------------------*

REPORT zrtransp_alv_veic NO STANDARD PAGE HEADING.

TABLES: ztveiculos, ztrotas, ztentregas.

DATA: lt_ztveiculos TYPE TABLE OF ztveiculos,
      lt_ztrotas    TYPE TABLE OF ztrotas,
      lt_ztentregas TYPE TABLE OF ztentregas,
      lt_saida      TYPE TABLE OF zstruc_veic_rota,    " Estrutura para FIELDCAT
      lt_fieldcat   TYPE slis_t_fieldcat_alv,          " Características das colunas
      lt_sort       TYPE slis_t_sortinfo_alv,          " Ordenação do relatório
      lt_header     TYPE slis_t_listheader.            " Cabeçalho do relatório

DATA: wa_ztveiculos TYPE ztveiculos,
      wa_ztrotas    TYPE ztrotas,
      wa_ztentregas TYPE ztentregas,
      wa_saida      TYPE zstruc_veic_rota,
      wa_fieldcat   TYPE slis_fieldcat_alv,
      wa_sort       TYPE slis_sortinfo_alv,
      wa_header     TYPE slis_listheader,
      wa_layout     TYPE slis_layout_alv,              " Definir Layout (não tem table)
      wa_variant    TYPE disvariant.                   " Para salvar variant

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_placa LIKE ztveiculos-placa.                      " Placa do Veículo

  SELECT-OPTIONS: s_id   FOR ztveiculos-veiculo_id,               " Range ID de veículos
                  s_date FOR ztentregas-data_entrega.             " Range Date
SELECTION-SCREEN END OF BLOCK b01.

**********************************************************************

START-OF-SELECTION.
  PERFORM f_select_data.
  PERFORM f_table_data.
*  PERFORM f_alv.

*&---------------------------------------------------------------------*
*& Form f_select_data
*&---------------------------------------------------------------------*
FORM f_select_data .

  SELECT * FROM ztveiculos
      INTO TABLE @lt_ztveiculos
      WHERE placa = @p_placa
         AND veiculo_id IN @s_id.

  IF sy-subrc EQ 0.
    SELECT * FROM ztentregas
      INTO TABLE lt_ztentregas
      FOR ALL ENTRIES IN lt_ztveiculos
      WHERE veiculo_id = lt_ztveiculos-veiculo_id
        AND data_entrega IN s_date.


    IF sy-subrc EQ 0.
      SELECT * FROM ztrotas
        INTO TABLE lt_ztrotas
        FOR ALL ENTRIES IN lt_ztentregas
        WHERE rota_id = lt_ztentregas-rota_id.

    ENDIF.

  ELSE.
    MESSAGE 'Nenhum registro encontrado' TYPE 'I'.

  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_table_data
*&---------------------------------------------------------------------*
FORM f_table_data .

  FIELD-SYMBOLS: <fs_line> TYPE ztentregas.



  LOOP AT lt_ztentregas INTO <fs_line>.

  ENDLOOP.

ENDFORM.
