*&---------------------------------------------------------------------*
*& Include SAPMZTOP                                 - Module Pool      SAPMZTRANSPORTE
*&---------------------------------------------------------------------*

PROGRAM sapmztransporte MESSAGE-ID zmctransportes.

TABLES: ztveiculos,
        ztmotoristas,
        ztrotas,
        ztentregas,
        ztocorrencias.

**********************************************************************

TYPES: BEGIN OF ty_rotas.
  INCLUDE STRUCTURE: ztrotas.
  TYPES: land1      LIKE t005u-land1,  " País
         bland_orig LIKE t005u-bland,  " Estado origem
         bland_dest LIKE t005u-bland,  " Estado destino
         mark,
  END OF ty_rotas.

TYPES BEGIN OF ty_veiculos.
INCLUDE STRUCTURE: ztveiculos.
TYPES: mark,
  END OF ty_veiculos.

TYPES BEGIN OF ty_motoristas.
INCLUDE STRUCTURE: ztmotoristas.
TYPES: mark,
  END OF ty_motoristas.

TYPES BEGIN OF ty_entregas.
INCLUDE STRUCTURE: ztentregas.
TYPES: mark,
  END OF ty_entregas.

TYPES: BEGIN OF ty_busca_entrega,
         entrega_id    TYPE ztentregas-entrega_id,
         nome          TYPE ztmotoristas-nome,
         cpf           TYPE ztmotoristas-cpf,
         cnh           TYPE ztmotoristas-cnh,
         pais          TYPE ztrotas-pais,
         uf_orig       TYPE t005u-bland,
         uf_dest       TYPE t005u-bland,
         placa         TYPE ztveiculos-placa,
         status        TYPE zeentrega_002,
         ocorrencia_id TYPE ztocorrencias-ocorrencia_id,
         mark,
       END OF ty_busca_entrega.

**********************************************************************

" Tabela Interna
*DATA: t_ztveiculos    TYPE TABLE OF ztveiculos,
*      t_ztmotoristas  TYPE TABLE OF ztmotoristas,
*      t_ztrotas       TYPE TABLE OF ty_rotas,
*      t_ztentregas    TYPE TABLE OF ztentregas,
*      t_ztocorrencias TYPE TABLE OF ztocorrencias.

" Work Area
DATA: w_ztveiculos    TYPE ztveiculos,
      w_ztmotoristas  TYPE ztmotoristas,
      w_ztrotas       TYPE ty_rotas,
      w_ztentregas    TYPE ztentregas,
      w_ztocorrencias TYPE ztocorrencias.

" Tabela Interna - Auxiliar (Para busca no cadastro de entrega)
DATA: t_ztrotas_aux      TYPE TABLE OF ty_rotas         WITH HEADER LINE,
      t_ztveiculos_aux   TYPE TABLE OF ty_veiculos      WITH HEADER LINE,
      t_ztmotoristas_aux TYPE TABLE OF ty_motoristas    WITH HEADER LINE,
      t_ztentregas_aux   TYPE TABLE OF ty_entregas      WITH HEADER LINE,
      t_busca_entrega    TYPE TABLE OF ty_busca_entrega WITH HEADER LINE.

**********************************************************************

" Controle do loop 'DO ENDDO' no FORM de validação de inputs
DATA: v_input TYPE abap_bool VALUE abap_false.

" Telas de Busca: Cadastro de Entrega
" Rota: SCREEN 0600 => 0602
DATA: v_pais  TYPE t005u-land1,  " País
      v_orige TYPE t005u-bland,  " UF Origem
      v_desti TYPE t005u-bland.  " UF Destino

" Veículo: SCREEN 0600 => 0603
DATA: v_placa  TYPE zeveic_002,
      v_model  TYPE zeveic_003,
      v_marca  TYPE zeveic_004,
      v_capac  TYPE zeveic_006,
      v_stavei TYPE zeveic_005.

" Motorista: SCREEN 0600 => 0604 (ADICIONAR DATA)
DATA: v_nome   TYPE zemoto_002,
      v_cpf    TYPE zemoto_003,
      v_cnh    TYPE zemoto_004,
      v_stamot TYPE zemoto_005.

" Ocorrência: SCREEN 0500 => 0502
" Variáveis reaproveitadas: v_nome, v_cpf, v_cnh, v_pais, v_desti, v_orige, v_placa
DATA: v_staten TYPE zeentrega_002,              " Status Entrega
      v_semoc  TYPE abap_bool,                  " Checkbox sem ocorrência
      v_nofina TYPE abap_bool VALUE abap_true.  " Checkbox somente não finalizada

**********************************************************************

" Table Control
CONTROLS: tc_0602 TYPE TABLEVIEW USING SCREEN 0602, " Selecionar Rotas
          tc_0603 TYPE TABLEVIEW USING SCREEN 0603, " Selecionar Veículos
          tc_0604 TYPE TABLEVIEW USING SCREEN 0604, " Selecionar Motoristas
          tc_0502 TYPE TABLEVIEW USING SCREEN 0502. " Selecionar Entregas
