DEFINE CLASS modelos AS modelo_base OF modelo_base.prg
    PROTECTED nMaquina
    PROTECTED nMarca

    **--------------------------------------------------------------------------
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnMaquina, tnMarca, tlVigente

        IF !modelo_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnMaquina) != 'N' THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnMarca) != 'N' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nMaquina = tnMaquina
            .nMarca = tnMarca
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_maquina
        RETURN THIS.nMaquina
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_marca
        RETURN THIS.nMarca
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF !modelo_base::es_igual(toModelo) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_maquina() != THIS.nMaquina ;
                OR toModelo.obtener_marca() != THIS.nMarca THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
