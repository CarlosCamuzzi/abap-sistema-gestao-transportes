PROCESS BEFORE OUTPUT.
 MODULE detail_init.
*
PROCESS AFTER INPUT.
 MODULE DETAIL_EXIT_COMMAND AT EXIT-COMMAND.
 MODULE DETAIL_SET_PFSTATUS.
 CHAIN.
    FIELD ZTENTREGAS-ENTREGA_ID .
    FIELD ZTENTREGAS-VEICULO_ID .
    FIELD ZTENTREGAS-ROTA_ID .
    FIELD ZTENTREGAS-MOTORISTA_ID .
    FIELD ZTENTREGAS-OCORRENCIA_ID .
    FIELD ZTENTREGAS-DATA_ENTREGA .
    FIELD ZTENTREGAS-STATUS .
  MODULE SET_UPDATE_FLAG ON CHAIN-REQUEST.
 endchain.
 chain.
    FIELD ZTENTREGAS-ENTREGA_ID .
  module detail_pai.
 endchain.