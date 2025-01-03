*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTENTREGAS......................................*
DATA:  BEGIN OF STATUS_ZTENTREGAS                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTENTREGAS                    .
CONTROLS: TCTRL_ZTENTREGAS
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZTMOTORISTAS....................................*
DATA:  BEGIN OF STATUS_ZTMOTORISTAS                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTMOTORISTAS                  .
CONTROLS: TCTRL_ZTMOTORISTAS
            TYPE TABLEVIEW USING SCREEN '0009'.
*...processing: ZTOCORRENCIAS...................................*
DATA:  BEGIN OF STATUS_ZTOCORRENCIAS                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTOCORRENCIAS                 .
CONTROLS: TCTRL_ZTOCORRENCIAS
            TYPE TABLEVIEW USING SCREEN '0007'.
*...processing: ZTROTAS.........................................*
DATA:  BEGIN OF STATUS_ZTROTAS                       .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTROTAS                       .
CONTROLS: TCTRL_ZTROTAS
            TYPE TABLEVIEW USING SCREEN '0013'.
*...processing: ZTVEICULOS......................................*
DATA:  BEGIN OF STATUS_ZTVEICULOS                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTVEICULOS                    .
CONTROLS: TCTRL_ZTVEICULOS
            TYPE TABLEVIEW USING SCREEN '0011'.
*.........table declarations:.................................*
TABLES: *ZTENTREGAS                    .
TABLES: *ZTMOTORISTAS                  .
TABLES: *ZTOCORRENCIAS                 .
TABLES: *ZTROTAS                       .
TABLES: *ZTVEICULOS                    .
TABLES: ZTENTREGAS                     .
TABLES: ZTMOTORISTAS                   .
TABLES: ZTOCORRENCIAS                  .
TABLES: ZTROTAS                        .
TABLES: ZTVEICULOS                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
