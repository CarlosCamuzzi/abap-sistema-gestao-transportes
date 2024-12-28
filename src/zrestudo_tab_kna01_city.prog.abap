*&---------------------------------------------------------------------*
*& Report ZRESTUDO_TAB_KNA01_CITY
*&---------------------------------------------------------------------*
*&  Somente SP
*&---------------------------------------------------------------------*
REPORT zrestudo_tab_kna01_city NO STANDARD PAGE HEADING.

TABLES: kna1.

TYPES: BEGIN OF ty_kna1,
         land1 LIKE kna1-land1, " país
         regio LIKE kna1-regio, " estado
         ort01 LIKE kna1-ort01, " city
         adrnr LIKE kna1-adrnr,
       END OF ty_kna1.

DATA: t_kna1 TYPE TABLE OF ty_kna1,
      w_kna1 TYPE ty_kna1.

START-OF-SELECTION.
  PERFORM f_select_data.
  PERFORM f_get_data.

*&---------------------------------------------------------------------*
*& Form f_select_data
*&---------------------------------------------------------------------*
FORM f_select_data .
  SELECT land1
         regio
         ort01
         adrnr
    FROM kna1
    INTO TABLE t_kna1
    WHERE land1 = 'BR'.

  IF sy-subrc IS INITIAL.
    MESSAGE 'OK' TYPE 'S'.
  ELSE.
    MESSAGE 'NOT OK' TYPE 'E'.
    STOP.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_get_data
*&---------------------------------------------------------------------*
FORM f_get_data .
  LOOP AT t_kna1 INTO w_kna1.
    WRITE:/ 'PAIS: ', w_kna1-land1, '/',
            'ESTADO: ', w_kna1-regio, '/',
            'CIDADE: ', w_kna1-ort01, '/',
            'ENDEREÇO: ', w_kna1-adrnr.
  ENDLOOP.
ENDFORM.
