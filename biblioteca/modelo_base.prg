DEFINE CLASS modelo_base AS Custom
    PROTECTED nCodigo
    PROTECTED cNombre
    PROTECTED lVigente

    **--------------------------------------------------------------------------
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tlVigente

        IF VARTYPE(tnCodigo) != 'N' ;
                OR VARTYPE(tcNombre) != 'C' ;
                OR VARTYPE(tlVigente) != 'L' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nCodigo = tnCodigo
            .cNombre = tcNombre
            .lVigente = tlVigente
        ENDWITH
    ENDFUNC

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

    **--------------------------------------------------------------------------
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF VARTYPE(toModelo) != 'O' ;
                OR LOWER(toModelo.Class) != LOWER(THIS.Name) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_codigo() != THIS.nCodigo ;
                OR toModelo.obtener_nombre() != THIS.cNombre ;
                OR toModelo.esta_vigente() != THIS.lVigente THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
