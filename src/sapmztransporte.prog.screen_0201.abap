PROCESS BEFORE OUTPUT.
  MODULE status_0201.

PROCESS AFTER INPUT.
  MODULE exit_command_0201 AT EXIT-COMMAND.

*  CHAIN.
*    FIELD w_ztveiculos-placa MODULE validate_veiculo_placa.
*
*
*
*    FIELD w_ztveiculos-modelo MODULE validate_veiculo_modelo.
*
*
*
*    FIELD w_ztveiculos-marca MODULE validate_veiculo_marca.
*
*
*
*    FIELD w_ztveiculos-capacidade MODULE validate_veiculo_capacidade.
*
*
*
*    FIELD w_ztveiculos-status MODULE validate_veiculo_status.
*  ENDCHAIN.

  MODULE user_command_0201.
