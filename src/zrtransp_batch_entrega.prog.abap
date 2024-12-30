*&---------------------------------------------------------------------*
*& Report ZRTRANSP_BATCH_ENTREGA
*&---------------------------------------------------------------------*
*& Carga Batch Input para dados de cadastro de entregas em massa
*&  - Tabela: ZTENTREGAS
*&  - Programa: SAPMZTRANSPORTE
*&  - Transaction: ZMTENTREGA
*&  - Mapeamento BDC: CAD_ENTREGA
*&---------------------------------------------------------------------*

REPORT zrtransp_batch_entrega NO STANDARD PAGE HEADING.

" Para salvar dados do arquivo CSV em linha
TYPES: BEGIN OF ty_csv,
         line(100) TYPE c,
       END OF ty_csv.

" Formatar de uma linha para os campos correspondentes
TYPES: BEGIN OF ty_format_file,
         entrega_id    TYPE ztentregas-entrega_id,
         veiculo_id    TYPE ztentregas-veiculo_id,
         rota_id       TYPE ztentregas-rota_id,
         motorista_id  TYPE ztentregas-motorista_id,
         ocorrencia_id TYPE ztentregas-ocorrencia_id,
         data_entrega(10)  TYPE c,
         status        TYPE ztentregas-status,
       END OF ty_format_file.

" lt_format_file para salvar os dados formatados
" Tabelas
DATA: lt_format_file TYPE TABLE OF ty_format_file,
      lt_csv         TYPE TABLE OF ty_csv,
      lt_bdcdata     TYPE TABLE OF bdcdata.

" Work Area
DATA: wa_format_file TYPE ty_format_file,
      wa_csv         TYPE ty_csv,
      wa_bdcdata     TYPE bdcdata.

" LOCALFILE: Elemento de dados utilizado para trabalhar com arquivos
PARAMETERS: p_file TYPE localfile.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM f_select_file.

START-OF-SELECTION.
  PERFORM f_upload_file.
  PERFORM f_create_bdc.

*&---------------------------------------------------------------------*
*& Form f_select_file
*&---------------------------------------------------------------------*
*& Função para seleção de arquivo
*&---------------------------------------------------------------------*
FORM f_select_file .
  TRY .
      CALL FUNCTION 'KD_GET_FILENAME_ON_F4'
        EXPORTING
          field_name    = p_file
        CHANGING
          file_name     = p_file
        EXCEPTIONS
          mask_too_long = 1
          OTHERS        = 2.

      IF sy-subrc IS NOT INITIAL.
        MESSAGE: 'Erro no seleção do arquivo' TYPE 'E'.
      ENDIF.

    CATCH cx_root INTO DATA(lx_exception).
      MESSAGE: lx_exception->get_text( ) TYPE 'E'.

  ENDTRY.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_upload_file
*&---------------------------------------------------------------------*
*& Função para upload de arquivo
*&---------------------------------------------------------------------*
FORM f_upload_file .

  TRY .
      " Campo FILENAME da função é do tipo STRING e o P_FILE é do tipo LOCALFILE
      DATA: vl_filename TYPE string.
      vl_filename = p_file.

      CALL FUNCTION 'GUI_UPLOAD'
        EXPORTING
          filename                = vl_filename
          filetype                = 'ASC'
        TABLES
          data_tab                = lt_csv
        EXCEPTIONS
          file_open_error         = 1
          file_read_error         = 2
          no_batch                = 3
          gui_refuse_filetransfer = 4
          invalid_type            = 5
          no_authority            = 6
          unknown_error           = 7
          bad_data_format_file    = 8
          header_not_allowed      = 9
          separator_not_allowed   = 10
          header_too_long         = 11
          unknown_dp_error        = 12
          access_denied           = 13
          dp_out_of_memory        = 14
          disk_full               = 15
          dp_timeout              = 16
          OTHERS                  = 17.

      IF sy-subrc IS INITIAL.
        " Formatando dados
        LOOP AT lt_csv INTO wa_csv.
          SPLIT wa_csv AT ';' INTO wa_format_file-entrega_id
                                   wa_format_file-veiculo_id
                                   wa_format_file-rota_id
                                   wa_format_file-motorista_id
                                   wa_format_file-ocorrencia_id
                                   wa_format_file-data_entrega
                                   wa_format_file-status.

          APPEND wa_format_file TO lt_format_file.

        ENDLOOP.

      ELSE.
        MESSAGE: 'Erro no upload do arquivo' TYPE 'E'.

      ENDIF.

    CATCH cx_root INTO DATA(lx_exception).
      MESSAGE: lx_exception->get_text( ) TYPE 'E'.

  ENDTRY.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_create_bdc
*&---------------------------------------------------------------------*
*& Monta BDC baseado no mapeamento feito na Transaction SHDB
*&
*&  - PERFORM f_mount_screen: utilizado para as informações que tem
*&      PROGRAM E SCREEN lá no mapeamento.
*&  - PERFOM f_mount_data: utilizado para passarmos os outros campos do mapeamento
*&  - PERFORM f_insert_bdc: indica a transação que o mapeamento se refere
*&---------------------------------------------------------------------*
FORM f_create_bdc .

  PERFORM f_open_folder.  " Abre pasta BATCH

  LOOP AT lt_format_file INTO wa_format_file.
    " FALTA OCORRENCIAS
    PERFORM f_mount_screen USING 'SAPLZGRF_TRANSPORTES' '0001'.
    PERFORM f_mount_data   USING 'BDC_CURSOR'           'VIM_POSITION_INFO'.
    PERFORM f_mount_data   USING 'BDC_OKCODE'           '=NEWL'.

    PERFORM f_mount_screen USING 'SAPLZGRF_TRANSPORTES' '0002'.
    PERFORM f_mount_data   USING 'BDC_CURSOR'           'ZTENTREGAS-STATUS'.
    PERFORM f_mount_data   USING 'BDC_OKCODE'           '=SAVE'.
    PERFORM f_mount_data   USING 'ZTENTREGAS-ENTREGA_ID'    wa_format_file-entrega_id.
    PERFORM f_mount_data   USING 'ZTENTREGAS-VEICULO_ID'    wa_format_file-veiculo_id.
    PERFORM f_mount_data   USING 'ZTENTREGAS-ROTA_ID'       wa_format_file-rota_id.
    PERFORM f_mount_data   USING 'ZTENTREGAS-MOTORISTA_ID'  wa_format_file-motorista_id.
    PERFORM f_mount_data   USING 'ZTENTREGAS-OCORRENCIA_ID' wa_format_file-ocorrencia_id.
    PERFORM f_mount_data   USING 'ZTENTREGAS-DATA_ENTREGA'  wa_format_file-data_entrega.
    PERFORM f_mount_data   USING 'ZTENTREGAS-STATUS'        wa_format_file-status.


    PERFORM f_mount_screen USING 'SAPLZGRF_TRANSPORTES' '0002'.
    PERFORM f_mount_data   USING 'BDC_CURSOR'           'ZTENTREGAS-VEICULO_ID'.
    PERFORM f_mount_data   USING 'BDC_OKCODE'           '=ENDE'.

    PERFORM f_insert_bdc.

  ENDLOOP.

  PERFORM f_close_folder.  " Fecha pasta BATCH

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_OPEN_FOLDER
*&---------------------------------------------------------------------*
*& Função par abrir a pasta BATCH
*&---------------------------------------------------------------------*
FORM f_open_folder .

  TRY .
      CALL FUNCTION 'BDC_OPEN_GROUP'
        EXPORTING
          client              = sy-mandt
          group               = 'CARGA_ENTR'   " Nome da pasta
          keep                = 'X'            " Manter histórico
          user                = sy-uname       " User
        EXCEPTIONS
          client_invalid      = 1
          destination_invalid = 2
          group_invalid       = 3
          group_is_locked     = 4
          holddate_invalid    = 5
          internal_error      = 6
          queue_error         = 7
          running             = 8
          system_lock_error   = 9
          user_invalid        = 10
          OTHERS              = 11.

      IF sy-subrc IS NOT INITIAL.
        MESSAGE: 'Erro ao abrir pasta batch' TYPE 'E'.
      ENDIF.

    CATCH cx_root INTO DATA(lx_exception).
      MESSAGE: lx_exception->get_text( ) TYPE 'E'.

  ENDTRY.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_mount_screen
*& program, dynpro e dynbegin: estrutura da tabela BDCDATA
*&---------------------------------------------------------------------*
FORM f_mount_screen  USING    VALUE(p_program)
                              VALUE(p_screen).

  FREE wa_bdcdata.

  wa_bdcdata-program = p_program.
  wa_bdcdata-dynpro = p_screen.
  wa_bdcdata-dynbegin = 'X'.
  APPEND wa_bdcdata TO lt_bdcdata.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_mount_data
*&---------------------------------------------------------------------*
FORM f_mount_data  USING    VALUE(p_name)
                            VALUE(p_value).

  FREE wa_bdcdata.

  wa_bdcdata-fnam = p_name.
  wa_bdcdata-fval = p_value.
  APPEND wa_bdcdata TO lt_bdcdata.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form f_insert_bdc
*&---------------------------------------------------------------------*
*& Função para inserir a BDC a partir da transaction e tabela
*&---------------------------------------------------------------------*

FORM f_insert_bdc .

  TRY .
      CALL FUNCTION 'BDC_INSERT'
        EXPORTING
          tcode            = 'ZMTENTREGA'  " Código da transaction
        TABLES
          dynprotab        = lt_bdcdata    " Tabela BDC
        EXCEPTIONS
          internal_error   = 1
          not_open         = 2
          queue_error      = 3
          tcode_invalid    = 4
          printing_invalid = 5
          posting_invalid  = 6
          OTHERS           = 7.

      IF sy-subrc IS NOT INITIAL.
        MESSAGE: 'Erro ao inserir BDC' TYPE 'E'.
        STOP.

      ELSE.
        MESSAGE: 'Operação realizada com sucesso' TYPE 'S'.
        CLEAR lt_bdcdata.

      ENDIF.

    CATCH cx_root INTO DATA(lx_exception).
      MESSAGE: lx_exception->get_text( ) TYPE 'E'.

  ENDTRY.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_CLOSE_FOLDER
*&---------------------------------------------------------------------*
*&  Função para fechar pasta BATCH
*&---------------------------------------------------------------------*
FORM f_close_folder .

  TRY .
      CALL FUNCTION 'BDC_CLOSE_GROUP'
        EXCEPTIONS
          not_open    = 1
          queue_error = 2
          OTHERS      = 3.

      IF sy-subrc IS NOT INITIAL.
        MESSAGE: 'Erro ao fechar pasta batch' TYPE 'E'.

      ENDIF.

    CATCH cx_root INTO DATA(lx_exception).
      MESSAGE: lx_exception->get_text( ) TYPE 'E'.

  ENDTRY.

ENDFORM.
