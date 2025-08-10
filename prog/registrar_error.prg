FUNCTION registrar_error
    LPARAMETERS tcClase, tcMetodo, tcMensaje

    * inicio { validaciones de parámetros }
    IF VARTYPE(tcClase) != 'C' OR VARTYPE(tcMetodo) != 'C' ;
            OR VARTYPE(tcMensaje) != 'C' THEN
        RETURN .F.
    ENDIF

    IF EMPTY(tcClase) OR EMPTY(tcMetodo) OR EMPTY(tcMensaje) THEN
        RETURN .F.
    ENDIF
    * fin { validaciones de parámetros }

    IF !abrir_conexion() THEN
        RETURN .F.
    ENDIF

    INSERT INTO regerror VALUES (DATETIME(), tcClase, tcMetodo, tcMensaje)

    cerrar_conexion()
ENDFUNC

**------------------------------------------------------------------------------
FUNCTION abrir_conexion
    IF !FILE('regerror.dbf') THEN
        IF !crear_tabla() THEN
            RETURN .F.
        ENDIF
    ENDIF

    USE regerror IN 0 SHARED
ENDFUNC

**------------------------------------------------------------------------------
FUNCTION cerrar_conexion
    IF USED('regerror') THEN
        USE IN regerror
    ENDIF
ENDFUNC

**------------------------------------------------------------------------------
FUNCTION crear_tabla
    IF FILE('regerror.dbf') THEN
        RETURN .F.
    ENDIF

    CREATE TABLE regerror ( ;
        fecha T(10), ;
        clase V(254), ;
        metodo V(254), ;
        mensaje V(254) ;
    )
    USE
ENDFUNC
