*&---------------------------------------------------------------------*
*& Report ZRESTUDO_TAB_ADRESSES
*&---------------------------------------------------------------------*
*& TABELA ADRC - Addresses (Business Address Services)
* CITY1 (AD_CITY1).........: City
* CITY2 (AD_CITY2).........: District
* CITY_CODE (AD_CITYNUM)...: City code for city/street file
* COUNTRY (LAND1)..........: Country/Region Key
* LANGU (SPRAS)............: Language Key
* REGION (REGIO)...........: Region (State, Province, County)
*&---------------------------------------------------------------------*

REPORT zrestudo_tab_adresses NO STANDARD PAGE HEADING.

TABLES: adrc.  " Addresses (Business Address Services)

TYPES: BEGIN OF ty_adrc,
         city1     LIKE adrc-city1,   " Nome da Cidade
         country   LIKE adrc-country, " LAND1/País
         region    LIKE adrc-region, " Estado
         langu     LIKE adrc-langu,
       END OF ty_adrc.

DATA: t_adrc TYPE TABLE OF ty_adrc,
      w_adrc TYPE ty_adrc.

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE TEXT-001.
  "SELECT-OPTIONS: s_countr FOR adrc-country.
SELECTION-SCREEN END OF BLOCK b01.

"PARAMETERS: p_spras LIKE adrc-langu DEFAULT 'PT'.

START-OF-SELECTION.
  PERFORM f_select_data.

*&---------------------------------------------------------------------*
*& Form f_select_data
*&---------------------------------------------------------------------*
FORM f_select_data .

  SELECT DISTINCT city1
         country
         region
         langu
    FROM adrc
    INTO TABLE t_adrc
    WHERE region = 'SP'.
    "WHERE country = 'BR'.


*    WHERE region = 'ES'
*    AND langu = p_spras.
  "AND country = s_countr.

  " IF sy-subrc IS INITIAL.
  LOOP AT t_adrc INTO w_adrc.
    WRITE:/ 'CITY1/CIDADE: ', w_adrc-city1,         " NOME DA CIDADE
            'COUNTRY/PAIS: ', w_adrc-country,      " PAIS
            'REGIO/ESTADO: ', w_adrc-region,       " ESTADO
            'LANGU/IDIOMA: ', w_adrc-langu.
  ENDLOOP.
  " ENDIF.

ENDFORM.
