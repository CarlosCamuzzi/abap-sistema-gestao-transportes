PROCESS BEFORE OUTPUT.
  MODULE status_0502.

  LOOP AT t_busca_entrega WITH CONTROL tc_0502.
    MODULE scroll_tc_0502.
    "MODULE format_ocorrencia.
  ENDLOOP.

PROCESS AFTER INPUT.

  LOOP AT t_busca_entrega.
    CHAIN.
      FIELD t_busca_entrega-entrega_id.
      FIELD t_busca_entrega-nome.
      FIELD t_busca_entrega-cpf.
      FIELD t_busca_entrega-cnh.
      FIELD t_busca_entrega-pais.
      FIELD t_busca_entrega-uf_orig.
      FIELD t_busca_entrega-uf_dest.
      FIELD t_busca_entrega-placa.
      FIELD t_busca_entrega-ocorrencia_id.
    ENDCHAIN.
    FIELD t_busca_entrega-mark MODULE mark_busca_entrega ON REQUEST.
  ENDLOOP.

  MODULE user_command_0502.
