FUNCTION repositorio_obtener_nombre
    LPARAMETERS tcModelo, tnCodigo

    LOCAL loModelo
    loModelo = repositorio_obtener_por_codigo(tcModelo, tnCodigo)

    IF VARTYPE(loModelo) != 'O' THEN
        RETURN SPACE(0)
    ENDIF

    RETURN loModelo.obtener_nombre()
ENDFUNC
