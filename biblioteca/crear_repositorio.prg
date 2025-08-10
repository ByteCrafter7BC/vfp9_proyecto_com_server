FUNCTION crear_repositorio
    LPARAMETERS tcModelo

    IF VARTYPE(tcModelo) == 'C' AND !EMPTY(tcModelo) THEN
        tcModelo = LOWER(ALLTRIM(tcModelo))
    ELSE
        RETURN .F.
    ENDIF

    IF VARTYPE(_oSCREEN.oRepositorio) != 'O' THEN
        LOCAL loRepositorio
        loRepositorio = NEWOBJECT('repositorio', 'repositorio.prg')

        IF VARTYPE(loRepositorio) != 'O' THEN
            RETURN .F.
        ENDIF

        ADDPROPERTY(_oSCREEN, 'oRepositorio', loRepositorio)
    ENDIF

    RETURN _oSCREEN.oRepositorio.obtener(tcModelo)
ENDFUNC
