FUNCTION repositorio_codigo_existe
    LPARAMETERS tcModelo, tnCodigo

    LOCAL loModelo
    loModelo = repositorio_obtener_por_codigo(tcModelo, tnCodigo)

    IF VARTYPE(loModelo) != 'O' THEN
        RETURN .F.
    ENDIF
ENDFUNC
