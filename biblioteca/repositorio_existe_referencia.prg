FUNCTION repositorio_existe_referencia
    LPARAMETERS tcModelo, tcCondicionFiltro

    IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
        RETURN .T.
    ENDIF

    IF VARTYPE(tcCondicionFiltro) != 'C' OR EMPTY(tcCondicionFiltro) THEN
        RETURN .T.
    ENDIF

    LOCAL loRepositorio
    loRepositorio = crear_repositorio(LOWER(ALLTRIM(tcModelo)))

    IF VARTYPE(loRepositorio) != 'O' THEN
        RETURN .T.
    ENDIF

    RETURN loRepositorio.contar(tcCondicionFiltro) != 0
ENDFUNC
