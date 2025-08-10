DEFINE CLASS repositorio_marcas1 AS repositorio_base OF repositorio_base.prg
    **--------------------------------------------------------------------------
    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        LOCAL llRelacionado, lcCondicionFiltro
        llRelacionado = .F.
        lcCondicionFiltro = 'marca == ' + ALLTRIM(STR(tnCodigo))

        IF VARTYPE(_oSCREEN.oConexion) == 'O' THEN
            lcCondicionFiltro = STRTRAN(lcCondicionFiltro, '==', '=')
        ENDIF

        IF !llRelacionado THEN
            llRelacionado = ;
                repositorio_existe_referencia('modelo', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC
ENDDEFINE
