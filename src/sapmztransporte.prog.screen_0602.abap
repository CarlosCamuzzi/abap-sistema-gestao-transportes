PROCESS BEFORE OUTPUT.
  MODULE status_0602.

  LOOP AT t_ztrotas_aux WITH CONTROL tc_0602.
    MODULE scroll_tc_0602.
  ENDLOOP.

PROCESS AFTER INPUT.

  LOOP AT t_ztrotas_aux.
    CHAIN.
      FIELD t_ztrotas_aux-rota_id.
      FIELD t_ztrotas_aux-pais.
      FIELD t_ztrotas_aux-uf_origem.
      FIELD t_ztrotas_aux-uf_destino.
      FIELD t_ztrotas_aux-distancia.
      FIELD t_ztrotas_aux-meins.
    ENDCHAIN.
    FIELD t_ztrotas_aux-mark MODULE mark_rota ON REQUEST.
  ENDLOOP.

  MODULE user_command_0602.
