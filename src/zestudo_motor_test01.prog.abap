*&---------------------------------------------------------------------*
*& Report ZESTUDO_MOTOR_TEST01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zestudo_motor_test01 NO STANDARD PAGE HEADING.

DATA: t_ztmotoristas TYPE TABLE OF ztmotoristas,
      w_ztmotoristas TYPE ztmotoristas.

SELECTION-SCREEN BEGIN OF BLOCK b01.
  PARAMETERS: p_id   LIKE ztmotoristas-motorista_id,
              p_nome LIKE ztmotoristas-nome,
              p_valc LIKE ztmotoristas-validade_cnh.
SELECTION-SCREEN END OF BLOCK b01.

START-OF-SELECTION.
  PERFORM f_set_data.
  PERFORM f_get_data.

*&---------------------------------------------------------------------*
*& Form F_SET_DATA
*&---------------------------------------------------------------------*
FORM f_set_data .
  w_ztmotoristas-motorista_id = p_id.
  w_ztmotoristas-nome = p_nome.
  w_ztmotoristas-validade_cnh = p_valc.
  APPEND w_ztmotoristas TO t_ztmotoristas.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_GET_DATA
*&---------------------------------------------------------------------*
FORM f_get_data .
  LOOP AT t_ztmotoristas INTO w_ztmotoristas.
    WRITE:/ w_ztmotoristas-motorista_id, ' - ',
            w_ztmotoristas-nome, ' - ' ,
            w_ztmotoristas-validade_cnh.
  ENDLOOP.
ENDFORM.
