*----------------------------------------------------------------------*
*                             z_teste_ivonei                           *
*----------------------------------------------------------------------*
* Author.....: Ivonei Nunes                                            *
* Date.......: 13.03.2020                                              *
*----------------------------------------------------------------------*
REPORT z_teste_ivonei.

DATA:
  v1 TYPE i,
  v2 TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK 1 WITH FRAME TITLE TEXT-001.

PARAMETERS: p_v1 TYPE i OBLIGATORY,
            p_v2 TYPE i OBLIGATORY,
            c1   RADIOBUTTON GROUP g1,
            c2   RADIOBUTTON GROUP g1,
            c3   RADIOBUTTON GROUP g1,
            c4   RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK 1.

START-OF-SELECTION.

  v1 = p_v1.
  v2 = p_v2.

  IF c1 EQ sy-abcde+23(1).
    ADD v1 TO v2.
    WRITE: v2.
  ELSEIF c2 EQ sy-abcde+23(1).
    SUBTRACT v2 FROM v1.
    WRITE: v1.
  ELSEIF c3 EQ sy-abcde+23(1).
    MULTIPLY v1 BY v2.
    WRITE: v1.
  ELSEIF c4 EQ sy-abcde+23(1).
    DIVIDE v1 BY v2.
    WRITE: v1.
  ENDIF.
