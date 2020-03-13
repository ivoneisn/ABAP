*----------------------------------------------------------------------*
*                             z_voo                                    *
*----------------------------------------------------------------------*
* Author.....: Ivonei Nunes                                            *
* Date.......: 13.03.2020                                              *
*----------------------------------------------------------------------*
REPORT z_voo.

TABLES: sflight,spfli.

TYPES:
  BEGIN OF ty_flight,
    carrid   TYPE sflight-carrid,
    connid   TYPE sflight-connid,
    fldate   TYPE sflight-fldate,
    price    TYPE sflight-price,
    cityfrom TYPE spfli-cityfrom,
    cityto   TYPE spfli-cityto,
    airpfrom TYPE spfli-airpfrom,
    airpto   TYPE spfli-airpto,
  END OF ty_flight.

DATA:
  r_grid      TYPE REF TO cl_gui_alv_grid,
  wa_fieldcat TYPE slis_fieldcat_alv,
  wa_layout   TYPE slis_layout_alv,
  it_fieldcat TYPE slis_t_fieldcat_alv,
  it_flight   TYPE TABLE OF ty_flight.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS:
  s_carrid FOR sflight-carrid,
  s_connid FOR sflight-connid,
  s_fldate FOR sflight-fldate.
PARAMETERS:
  p_cfrom TYPE spfli-cityfrom,
  p_cto   TYPE spfli-cityto,
  p_afrom TYPE spfli-airpfrom,
  p_ato   TYPE spfli-airpto.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  p_cfrom   = '%' && p_cfrom && '%'.
  p_cto     = '%' && p_cto && '%'.
  p_afrom   = '%' && p_afrom && '%'.
  p_ato     = '%' && p_ato && '%'.

  SELECT
    sflight~carrid
    sflight~connid
    sflight~fldate
    sflight~price
    spfli~cityfrom
    spfli~airpfrom
    spfli~airpfrom
    spfli~airpto
  INTO TABLE it_flight
  FROM sflight INNER JOIN spfli ON sflight~carrid = spfli~carrid AND sflight~connid = spfli~connid
  WHERE
    sflight~carrid IN s_carrid AND
    sflight~connid IN s_connid AND
    spfli~cityfrom   LIKE p_cfrom  AND
    spfli~cityto     LIKE p_cto    AND
    spfli~airpfrom   LIKE p_afrom  AND
    spfli~airpto     LIKE p_ato.

  PERFORM montar_campos.
  PERFORM montar_layout.
  PERFORM exibir_alv.

FORM montar_campos.

  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname = 'CARRID'.
  wa_fieldcat-tabname = 'SFLIGHT'.
  wa_fieldcat-seltext_m = 'Companhia'.
  APPEND wa_fieldcat TO it_fieldcat.

  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname = 'CONNID'.
  wa_fieldcat-tabname = 'SFLIGHT'.
  wa_fieldcat-seltext_m = 'Cod. do Voo'.
  APPEND wa_fieldcat TO it_fieldcat.

  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname = 'FLDATE'.
  wa_fieldcat-tabname = 'SFLIGHT'.
  wa_fieldcat-seltext_m = 'Data do Voo'.
  APPEND wa_fieldcat TO it_fieldcat.

  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname = 'PRICE'.
  wa_fieldcat-tabname = 'SFLIGHT'.
  wa_fieldcat-seltext_m = 'Preço'.
  APPEND wa_fieldcat TO it_fieldcat.

  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname = 'CITYFROM'.
  wa_fieldcat-tabname = 'SFLIGHT'.
  wa_fieldcat-seltext_m = 'Cidade de partida'.
  APPEND wa_fieldcat TO it_fieldcat.

  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname = 'CITYTO'.
  wa_fieldcat-tabname = 'SFLIGHT'.
  wa_fieldcat-seltext_m = 'Cidade de destino'.
  APPEND wa_fieldcat TO it_fieldcat.

  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname = 'AIRPFROM'.
  wa_fieldcat-tabname = 'SFLIGHT'.
  wa_fieldcat-seltext_m = 'Aeroporto de partida'.
  APPEND wa_fieldcat TO it_fieldcat.

  CLEAR wa_fieldcat.
  wa_fieldcat-fieldname = 'AIRPTO'.
  wa_fieldcat-tabname = 'SFLIGHT'.
  wa_fieldcat-seltext_m = 'Aeroporto de destino'.
  APPEND wa_fieldcat TO it_fieldcat.

ENDFORM.

FORM montar_layout.
  wa_layout-zebra = 'X'.
  wa_layout-colwidth_optimize = 'X'.
ENDFORM.

FORM exibir_alv.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      i_grid_title       = 'Dados dos Voos'
      is_layout          = wa_layout
      it_fieldcat        = it_fieldcat
    TABLES
      t_outtab           = it_flight.
  .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
ENDFORM.
