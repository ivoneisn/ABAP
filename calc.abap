*----------------------------------------------------------------------*
*                             z_calculadora                            *
*----------------------------------------------------------------------*
* Author.....: Ivonei Nunes                                            *
* Date.......: 13.03.2020                                              *
*----------------------------------------------------------------------*
REPORT z_calculadora.

DATA:
  ty_valor1 TYPE i,
  ty_valor2 TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK 1 WITH FRAME TITLE TEXT-001.

PARAMETERS: p_v1  TYPE i OBLIGATORY,
            p_v2  TYPE i OBLIGATORY,
            p_r1  RADIOBUTTON GROUP g1,
            p_r2  RADIOBUTTON GROUP g1,
            p_r3  RADIOBUTTON GROUP g1,
            p_r4  RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK 1.

START-OF-SELECTION.

  ty_valor1 = p_v1.
  ty_valor2 = p_v2.

  IF p_r1 EQ sy-abcde+23(1).
    ADD ty_valor1 TO ty_valor2.
    WRITE: ty_valor2.
  ELSEIF p_r2 EQ sy-abcde+23(1).
    SUBTRACT ty_valor2 FROM ty_valor1.
    WRITE: ty_valor1.
  ELSEIF p_r3 EQ sy-abcde+23(1).
    MULTIPLY ty_valor1 BY ty_valor2.
    WRITE: ty_valor1.
  ELSEIF p_r4 EQ sy-abcde+23(1).
    DIVIDE ty_valor1 BY ty_valor2.
    WRITE: ty_valor1.
  ENDIF.
