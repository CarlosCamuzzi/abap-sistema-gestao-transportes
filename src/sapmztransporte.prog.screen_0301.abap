PROCESS BEFORE OUTPUT.
  MODULE status_0301.

PROCESS AFTER INPUT.
  MODULE exit_command_0301 AT EXIT-COMMAND.


  " Ler SY_UCOMM e sair das telas sem validar campos
*  MODULE pai_exit_not_validate_data.
*
*  CHAIN.
*    FIELD w_ztmotoristas-nome MODULE validate_motorista_nome.
*  ENDCHAIN.
*
*  CHAIN.
*    FIELD w_ztmotoristas-cpf MODULE validate_motorista_cpf.
*  ENDCHAIN.
*
*  CHAIN.
*    FIELD w_ztmotoristas-cnh MODULE validate_motorista_cnh.
*  ENDCHAIN.
*
*  CHAIN.
*    FIELD w_ztmotoristas-validade_cnh
*     MODULE validate_motorista_valid_cnh.
*  ENDCHAIN.
*
*  CHAIN.
*    FIELD w_ztmotoristas-status MODULE validate_motorista_status.
*  ENDCHAIN.

MODULE user_command_0301.
