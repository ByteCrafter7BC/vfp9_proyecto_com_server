DEFINE CLASS dto_familias AS dto_base OF dto_base.prg
    PROTECTED nP1
    PROTECTED nP2
    PROTECTED nP3
    PROTECTED nP4
    PROTECTED nP5

    **--------------------------------------------------------------------------
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnP1, tnP2, tnP3, tnP4, tnP5, tlVigente

        IF PARAMETERS() != 8 THEN
            tnCodigo = 0
            tcNombre = ''
            tnP1 = 0
            tnP2 = 0
            tnP3 = 0
            tnP4 = 0
            tnP5 = 0
            tlVigente = .F.
        ENDIF

        IF !dto_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF !THIS.establecer_p1(tnP1) ;
                OR !THIS.establecer_p2(tnP2) ;
                OR !THIS.establecer_p3(tnP3) ;
                OR !THIS.establecer_p4(tnP4) ;
                OR !THIS.establecer_p5(tnP5) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                              GETTER SECTION                             *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    FUNCTION obtener_p1
        RETURN THIS.nP1
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_p2
        RETURN THIS.nP2
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_p3
        RETURN THIS.nP3
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_p4
        RETURN THIS.nP4
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_p5
        RETURN THIS.nP5
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                              SETTER SECTION                             *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    FUNCTION establecer_p1
        LPARAMETERS tnP1

        IF VARTYPE(tnP1) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nP1 = tnP1
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION establecer_p2
        LPARAMETERS tnP2

        IF VARTYPE(tnP2) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nP2 = tnP2
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION establecer_p3
        LPARAMETERS tnP3

        IF VARTYPE(tnP3) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nP3 = tnP3
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION establecer_p4
        LPARAMETERS tnP4

        IF VARTYPE(tnP4) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nP4 = tnP4
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION establecer_p5
        LPARAMETERS tnP5

        IF VARTYPE(tnP5) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nP5 = tnP5
    ENDFUNC
ENDDEFINE
