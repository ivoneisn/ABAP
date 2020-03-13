*----------------------------------------------------------------------*
*                             z_clientes_kna1                          *
*----------------------------------------------------------------------*
* Author.....: Ivonei Nunes                                            *
* Date.......: 13.03.2020                                              *
*----------------------------------------------------------------------*
REPORT z_clientes_kna1.

TABLES: kna1.

TYPES:
  BEGIN OF ty_kna1,
    kunnr TYPE kna1-kunnr,
    stcd1 TYPE kna1-stcd1,
    stcd2 TYPE kna1-stcd2,
    name1 TYPE kna1-name1,
    land1 TYPE kna1-land1,
    regio TYPE kna1-regio,
    telf1 TYPE kna1-telf1,
  END OF ty_kna1.

DATA:
  it_kna1  TYPE TABLE OF ty_kna1,
  alv      TYPE REF TO cl_salv_table,
  ref_func TYPE REF TO cl_salv_functions.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS:
    s_kunnr FOR kna1-kunnr,
    s_stcd1 FOR kna1-stcd1 NO INTERVALS,
    s_stcd2 FOR kna1-stcd2 NO INTERVALS,
    s_land1 FOR kna1-land1 NO INTERVALS,
    s_regio FOR kna1-regio NO INTERVALS,
    s_telf1 FOR kna1-telf1 NO INTERVALS.
  PARAMETERS:
    p_name1 TYPE kna1-name1.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  p_name1 = '%' && p_name1 && '%'.

  PERFORM f_carrega_dados.
  FORM f_carrega_dados.
    SELECT
      kunnr
      stcd1
      stcd2
      name1
      land1
      regio
      telf1
    FROM kna1
    INTO TABLE it_kna1
    WHERE
      kunnr IN s_kunnr AND
      ( stcd1 = s_stcd1 OR stcd2 = s_stcd2 ) AND
      name1 LIKE p_name1 AND
      land1 IN s_land1 AND
      regio IN s_regio AND
      telf1 IN s_telf1.

    TRY.
      CALL METHOD cl_salv_table=>factory
        IMPORTING
          r_salv_table = alv
        CHANGING
          t_table      = it_kna1.

      ref_func = alv->get_functions( ).
      ref_func->set_all( abap_true ).
    CATCH cx_salv_msg.
    ENDTRY.

  alv->display( ).

  ENDFORM.
