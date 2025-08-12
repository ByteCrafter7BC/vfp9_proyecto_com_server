#INCLUDE 'constantes.h'

FUNCTION repositorio_obtener_por_codigo
    LPARAMETERS tcModelo, tnCodigo

    IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
        RETURN 'ERROR: ' + STRTRAN(PARAM_INVALIDO, '{}', 'tcModelo')
    ENDIF

    tcModelo = LOWER(ALLTRIM(tcModelo))

    IF VARTYPE(tnCodigo) != 'N' OR !BETWEEN(tnCodigo, 1, INT_MAX) THEN
        RETURN 'ERROR: ' + STRTRAN(PARAM_INVALIDO, '{}', 'tnCodigo')
    ENDIF

    LOCAL loRepositorio, lcRepositorio
    loRepositorio = crear_repositorio(tcModelo)

    IF VARTYPE(loRepositorio) != 'O' THEN
        lcRepositorio = 'repositorio_' + tcModelo

        IF VARTYPE(_SCREEN.oConexion) == 'O' THEN
            lcRepositorio = 'odbc_' + lcRepositorio
        ENDIF

        RETURN 'ERROR: ' + STRTRAN(ERROR_INSTANCIA_CLASE, '{}', lcRepositorio)
    ENDIF

    RETURN loRepositorio.obtener_por_codigo(tnCodigo)
ENDFUNC
