PROCESS BEFORE OUTPUT.
 MODULE detail_init.
*
PROCESS AFTER INPUT.
 MODULE DETAIL_EXIT_COMMAND AT EXIT-COMMAND.
 MODULE DETAIL_SET_PFSTATUS.
 CHAIN.
    FIELD ZTVEICULOS-VEICULO_ID .
    FIELD ZTVEICULOS-PLACA .
    FIELD ZTVEICULOS-MODELO .
    FIELD ZTVEICULOS-MARCA .
    FIELD ZTVEICULOS-CAPACIDADE .
    FIELD ZTVEICULOS-MEINS .
    FIELD ZTVEICULOS-STATUS .
  MODULE SET_UPDATE_FLAG ON CHAIN-REQUEST.
 endchain.
 chain.
    FIELD ZTVEICULOS-VEICULO_ID .
  module detail_pai.
 endchain.
