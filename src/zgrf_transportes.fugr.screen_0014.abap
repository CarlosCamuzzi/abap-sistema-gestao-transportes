PROCESS BEFORE OUTPUT.
 MODULE detail_init.
*
PROCESS AFTER INPUT.
 MODULE DETAIL_EXIT_COMMAND AT EXIT-COMMAND.
 MODULE DETAIL_SET_PFSTATUS.
 CHAIN.
    FIELD ZTROTAS-ROTA_ID .
    FIELD ZTROTAS-PAIS .
    FIELD ZTROTAS-UF_ORIGEM .
    FIELD ZTROTAS-UF_DESTINO .
    FIELD ZTROTAS-DISTANCIA .
    FIELD ZTROTAS-MEINS .
  MODULE SET_UPDATE_FLAG ON CHAIN-REQUEST.
 endchain.
 chain.
    FIELD ZTROTAS-ROTA_ID .
  module detail_pai.
 endchain.
