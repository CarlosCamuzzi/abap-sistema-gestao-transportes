PROCESS BEFORE OUTPUT.
  MODULE status_0603.

  LOOP AT t_ztveiculos_aux WITH CONTROL tc_0603.
    MODULE scroll_tc_0603.
  ENDLOOP.

PROCESS AFTER INPUT.

  LOOP AT t_ztveiculos_aux.
    CHAIN.
      FIELD t_ztveiculos_aux-veiculo_id.
      FIELD t_ztveiculos_aux-placa.
      FIELD t_ztveiculos_aux-marca.
      FIELD t_ztveiculos_aux-modelo.
      FIELD t_ztveiculos_aux-capacidade.
      FIELD t_ztveiculos_aux-meins.
      FIELD t_ztveiculos_aux-status.
    ENDCHAIN.
    FIELD t_ztveiculos_aux-mark MODULE mark_veiculo ON REQUEST.
  ENDLOOP.

 MODULE user_command_0603.
