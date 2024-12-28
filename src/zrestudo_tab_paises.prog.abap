*&---------------------------------------------------------------------*
*& Report ZRESTUDO_TAB_PAISES
*&---------------------------------------------------------------------*
*&
*TABELA PAÍSES
*T005U - Taxes: Region Key: Texts
*land1 - PAIS   - DATA ELEMENT: LAND1
*bland - COD (UF)    - DATA ELEMENT: REGIO
*bezei - ESTADO - DATA ELEMENT: BEZEI20
*spras - LÍNGUA - DATA ELEMENT: SPRAS
*region - ESTADO - DATA ELEMENT: REGIO
*&---------------------------------------------------------------------*

REPORT zrestudo_tab_paises NO STANDARD PAGE HEADING.

TABLES: t005u.    " Tabela Regiões

TYPES: BEGIN OF ty_t005u,
         land1 LIKE t005u-land1,
         bland LIKE t005u-bland,
         bezei LIKE t005u-bezei,
       END OF ty_t005u.

DATA: t_t005u TYPE TABLE OF ty_t005u,
      w_t005u TYPE ty_t005u.

* Tela de Seleção -------------------------------------
SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_land1 FOR t005u-land1,
                  s_bland FOR t005u-bland.
SELECTION-SCREEN END OF BLOCK b01.

SELECTION-SCREEN BEGIN OF BLOCK b02 WITH FRAME TITLE TEXT-002.
  PARAMETERS: p_spras LIKE t005u-spras DEFAULT 'PT'.    " Idioma de retorno do nome do estado/pais
SELECTION-SCREEN END OF BLOCK b02.


START-OF-SELECTION.
  PERFORM f_select_data.

*&---------------------------------------------------------------------*
*& Form F_SELECT_DATA
*&---------------------------------------------------------------------*
FORM f_select_data .

  SELECT land1 bland bezei
  FROM t005u
  INTO TABLE t_t005u          " Tabela Interna
  WHERE land1 IN s_land1
    AND bland IN s_bland
   AND spras = p_spras.

  IF sy-subrc IS INITIAL.
    LOOP AT t_t005u INTO w_t005u.
      WRITE:/ "'SPRAS (LÍNGUA): ', w_t005u-spras,
              'BLAND (COD): ' ,w_t005u-bland,
              'LAND1 (PAIS): ' , w_t005u-land1,
              'BEZEI (ESTADO): ', w_t005u-bezei.
    ENDLOOP.
  ENDIF.

ENDFORM.
