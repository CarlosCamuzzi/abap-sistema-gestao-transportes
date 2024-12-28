PROCESS BEFORE OUTPUT.
  MODULE status_0604.

  LOOP AT t_ztmotoristas_aux WITH CONTROL tc_0604.
    MODULE scroll_tc_0604.
  ENDLOOP.

PROCESS AFTER INPUT.

  LOOP AT t_ztmotoristas_aux.
    CHAIN.
      FIELD t_ztmotoristas_aux-motorista_id.
      FIELD t_ztmotoristas_aux-nome.
      FIELD t_ztmotoristas_aux-cpf.
      FIELD t_ztmotoristas_aux-cnh.
      FIELD t_ztmotoristas_aux-validade_cnh.
      FIELD t_ztmotoristas_aux-status.
    ENDCHAIN.
    FIELD t_ztmotoristas_aux-mark MODULE mark_motorista ON REQUEST.
  ENDLOOP.

  MODULE user_command_0604.
