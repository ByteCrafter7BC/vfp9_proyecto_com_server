FUNCTION cerrar_dbf
    LPARAMETERS tcTabla

    IF VARTYPE(tcTabla) != 'C' OR EMPTY(tcTabla) THEN
        RETURN .F.
    ENDIF

    IF USED(tcTabla) THEN
        USE IN (tcTabla)
    ENDIF
ENDFUNC
