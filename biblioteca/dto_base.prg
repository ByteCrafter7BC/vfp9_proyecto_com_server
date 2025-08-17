DEFINE CLASS dto_base AS Custom
    PROTECTED nCodigo
    PROTECTED cNombre
    PROTECTED lVigente

    **--------------------------------------------------------------------------
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tlVigente

        IF PARAMETERS() != 3 THEN
            tnCodigo = 0
            tcNombre = ''
            tlVigente = .F.
        ENDIF

        IF !THIS.establecer_codigo(tnCodigo) ;
                OR !THIS.establecer_nombre(tcNombre) ;
                OR !THIS.establecer_vigente(tlVigente) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                              GETTER SECTION                             *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    FUNCTION obtener_codigo
        RETURN THIS.nCodigo
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_nombre
        RETURN THIS.cNombre
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION esta_vigente
        RETURN THIS.lVigente
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                              SETTER SECTION                             *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    FUNCTION establecer_codigo
        LPARAMETERS tnCodigo

        IF VARTYPE(tnCodigo) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nCodigo = tnCodigo
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION establecer_nombre
        LPARAMETERS tcNombre

        IF VARTYPE(tcNombre) != 'C' THEN
            RETURN .F.
        ENDIF

        THIS.cNombre = ALLTRIM(tcNombre)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION establecer_vigente
        LPARAMETERS tlVigente

        IF VARTYPE(tlVigente) != 'L' THEN
            RETURN .F.
        ENDIF

        THIS.lVigente = tlVigente
    ENDFUNC
ENDDEFINE
