PROCESS BEFORE OUTPUT.
  MODULE status_0401.

PROCESS AFTER INPUT.
  MODULE exit_command_0401 AT EXIT-COMMAND.

  " Ler SY_UCOMM e sair das telas sem validar campos
*  MODULE pai_exit_not_validate_data.
*
*  " Obs.: Campos do TYPES TY_ROTAS
** land1      LIKE t005u-land1,  " País
** bland_orig LIKE t005u-bland,  " Estado origem
** bland_dest LIKE t005u-bland,  " Estado destino
*
*  CHAIN.
*    FIELD w_ztrotas-land1 MODULE validate_rota_pais.
*  ENDCHAIN.
*
*  CHAIN.
*    FIELD w_ztrotas-bland_orig MODULE validate_rota_uf_origem.
*  ENDCHAIN.
*
*  CHAIN.
*    FIELD w_ztrotas-bland_dest  MODULE validate_rota_uf_destino.
*  ENDCHAIN.
*
*  CHAIN.
*    FIELD w_ztrotas-distancia MODULE validate_rota_distancia.
*  ENDCHAIN.
*
*  CHAIN.
*    FIELD w_ztrotas-unid_medida MODULE validate_rota_unid_medida.
*  ENDCHAIN.


  MODULE user_command_0401.
