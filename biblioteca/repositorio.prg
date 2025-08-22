DEFINE CLASS repositorio AS Custom
    PROTECTED aRepositorio[1, 2]    && columna1 = modelo | columna2 = repositorio

    **--------------------------------------------------------------------------
    FUNCTION Init
        DIMENSION THIS.aRepositorio[12, 2]

        WITH THIS
            .aRepositorio[01, 1] = 'barrio'
            .aRepositorio[02, 1] = 'ciudad'
            .aRepositorio[03, 1] = 'depar'
            .aRepositorio[04, 1] = 'familias'
            .aRepositorio[05, 1] = 'maquinas'
            .aRepositorio[06, 1] = 'marcas1'
            .aRepositorio[07, 1] = 'marcas2'
            .aRepositorio[08, 1] = 'modelos'
            .aRepositorio[09, 1] = 'proceden'
            .aRepositorio[10, 1] = 'rubros1'
            .aRepositorio[11, 1] = 'rubros2'
            .aRepositorio[12, 1] = 'zona'
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener
        LPARAMETERS tcModelo

        IF VARTYPE(tcModelo) == 'C' AND !EMPTY(tcModelo) THEN
            tcModelo = LOWER(ALLTRIM(tcModelo))
        ELSE
            RETURN .F.
        ENDIF

        LOCAL lnFila
        lnFila = ASCAN(THIS.aRepositorio, tcModelo, -1, -1, 1, 14)

        IF lnFila <= 0 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.aRepositorio[lnFila, 2]) != 'O' THEN
            THIS.aRepositorio[lnFila, 2] = THIS.crear(tcModelo)
        ENDIF

        IF VARTYPE(THIS.aRepositorio[lnFila, 2]) != 'O' THEN
            RETURN .F.
        ENDIF

        RETURN THIS.aRepositorio[lnFila, 2]
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION crear
        LPARAMETERS tcModelo

        IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
            RETURN .F.
        ENDIF

        IF ASCAN(THIS.aRepositorio, tcModelo, -1, -1, 1, 14) <= 0 THEN
            RETURN .F.
        ENDIF

        LOCAL lcClase, loObjeto, loExcepcion, lcMensaje
        lcClase = 'repositorio_' + LOWER(ALLTRIM(tcModelo))

        TRY
            loObjeto = NEWOBJECT(lcClase, lcClase + '.prg')
        CATCH TO loExcepcion
            registrar_error('repositorio', 'crear', loExcepcion.Message)
        ENDTRY

        RETURN loObjeto
    ENDFUNC
ENDDEFINE
