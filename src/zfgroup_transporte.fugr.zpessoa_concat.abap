FUNCTION ZPESSOA_CONCAT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IT_PESSOA) TYPE  ZTTPESSOA_01
*"  EXPORTING
*"     VALUE(LV_CONCAT) TYPE  STRING
*"----------------------------------------------------------------------

" Função para estudo de como importar tabela interna para a função
" -> Essa função concatena o nome das pessoas e devolve uma string

" 1 - Foi criada uma tabela transparente
"   ZTPESSOA_01: MANDT, ID_PESSOA, NOME, SOBRENOME

" 2 - Na SE11 foi criado um DATA TYPE ZTTPESSOA_01 que se baseia
"       na tabela ZTPESSOA_01, incluída em LINE TYPE

" 3 - Após isso, referenciar o campo criado no data type no tipo
"       associado ao campo que desejamos que seja a tabela:
"     no caso: IT_PESSOA TYPE  ZTTPESSOA_01

" Assim conseguimos referenciar a tabela


data: lv_count type i.

*LOOP AT it_pessoa into data(wa_pessoa).
*  lv_count = lv_count + 1.
*ENDLOOP.

lv_concat = REDUCE string(
  INIT text = `` sep = ``
  for ls_pessoa in it_pessoa
  NEXT text = |{ text }{ sep }{ ls_pessoa-nome }| sep = ` `
).

ENDFUNCTION.
