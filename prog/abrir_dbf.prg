#DEFINE CARPETA_DATOS    'C:\turtle\aya\integrad.000\'

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

    LOCAL lcDbf
    lcDbf = ADDBS(CARPETA_DATOS) + tcTabla + '.dbf'

    IF !USED(tcTabla) THEN
        IF !FILE(lcDbf) THEN
            registrar_error('abrir_dbf', 'abrir_dbf', ;
                "Archivo '" + lcDbf + "' no existe.")
            RETURN .F.
        ENDIF

        IF !tlModoEscritura THEN
            USE (lcDbf) IN 0 SHARED NOUPDATE
        ELSE
            USE (lcDbf) IN 0 SHARED
        ENDIF
    ENDIF
ENDFUNC
