FUNCTION abrir_dbf
    LPARAMETERS tcTabla, tlModoEscritura

    * inicio { validaciones de parámetros }
    IF VARTYPE(tcTabla) != 'C' OR EMPTY(tcTabla) THEN
        RETURN .F.
    ENDIF

    IF VARTYPE(tlModoEscritura) != 'L' THEN
        tlModoEscritura = .F.
    ENDIF
    * fin { validaciones de parámetros }

    IF !USED(tcTabla) THEN
        IF !FILE(tcTabla + '.dbf') THEN
            MESSAGEBOX("Archivo '" + tcTabla + '.dbf' + "' no existe.", 0+16, ;
                'Ha ocurrido un error', 10000)
            RETURN .F.
        ENDIF

        IF !tlModoEscritura THEN
            USE (tcTabla) IN 0 SHARED NOUPDATE
        ELSE
            USE (tcTabla) IN 0 SHARED
        ENDIF
    ENDIF
ENDFUNC
