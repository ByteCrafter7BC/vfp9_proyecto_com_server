#INCLUDE 'constantes.h'

DEFINE CLASS validador_modelos AS validador_base OF validador_base.prg
    PROTECTED cErrorMaquina
    PROTECTED cErrorMarca

    **--------------------------------------------------------------------------
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            IF !EMPTY(THIS.cErrorCodigo) ;
                    OR !EMPTY(THIS.cErrorNombre) ;
                    OR !EMPTY(THIS.cErrorMaquina) ;
                    OR !EMPTY(THIS.cErrorMarca) ;
                    OR !EMPTY(THIS.cErrorVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN !THIS.oRepositorio.esta_relacionado( ;
                THIS.oModelo.obtener_codigo())
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_maquina
        RETURN IIF(VARTYPE(THIS.cErrorMaquina) == 'C', THIS.cErrorMaquina, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_marca
        RETURN IIF(VARTYPE(THIS.cErrorMarca) == 'C', THIS.cErrorMarca, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar
        validador_base::validar()

        WITH THIS
            .cErrorMaquina = .validar_maquina()
            .cErrorMarca = .validar_marca()
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_nombre
        LOCAL lcEtiqueta, lcNombre, loModelo
        lcEtiqueta = 'Nombre: '
        lcNombre = THIS.oModelo.obtener_nombre()

        IF EMPTY(lcNombre) THEN
            RETURN lcEtiqueta + NO_BLANCO
        ENDIF

        IF LEN(lcNombre) > THIS.nAnchoNombre THEN
            RETURN lcEtiqueta + ;
                STRTRAN(LONGITUD_MAXIMA, '{}', ALLTRIM(STR(THIS.nAnchoNombre)))
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_maquina
        LOCAL lcEtiqueta, lnMaquina, loModelo
        lcEtiqueta = 'Máquina: '

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        lnMaquina = THIS.oModelo.obtener_maquina()

        IF lnMaquina < 0 THEN
            RETURN lcEtiqueta + MAYOR_O_IGUAL_A_CERO
        ENDIF

        IF lnMaquina > 9999 THEN
            RETURN lcEtiqueta + STRTRAN(MENOR_QUE, '{}', ALLTRIM(STR(9999 + 1)))
        ENDIF

        IF lnMaquina > 0 THEN
            loModelo = repositorio_obtener_por_codigo('maquinas', lnMaquina)

            IF VARTYPE(loModelo) != 'O' THEN
                RETURN lcEtiqueta + ;
                    STRTRAN(NO_EXISTE, '{}', ALLTRIM(STR(lnMaquina)))
            ENDIF

            IF !loModelo.esta_vigente() THEN
                RETURN lcEtiqueta + ;
                    STRTRAN(NO_VIGENTE, '{}', ALLTRIM(STR(lnMaquina)))
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_marca
        LOCAL lcEtiqueta, lcNombre, lnMaquina, lnMarca, loModelo
        lcEtiqueta = 'Marca: '

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        IF !EMPTY(THIS.cErrorMaquina) THEN
            RETURN THIS.cErrorMaquina
        ENDIF

        WITH THIS.oModelo
            lcNombre = .obtener_nombre()
            lnMaquina = .obtener_maquina()
            lnMarca = .obtener_marca()
        ENDWITH

        IF lnMarca < 0 THEN
            RETURN lcEtiqueta + MAYOR_O_IGUAL_A_CERO
        ENDIF

        IF lnMarca > 9999 THEN
            RETURN lcEtiqueta + STRTRAN(MENOR_QUE, '{}', ALLTRIM(STR(9999 + 1)))
        ENDIF

        IF lnMarca > 0 THEN
            loModelo = repositorio_obtener_por_codigo('marcas2', lnMarca)

            IF VARTYPE(loModelo) != 'O' THEN
                RETURN lcEtiqueta + ;
                    STRTRAN(NO_EXISTE, '{}', ALLTRIM(STR(lnMarca)))
            ENDIF

            IF !loModelo.esta_vigente() THEN
                RETURN lcEtiqueta + ;
                    STRTRAN(NO_VIGENTE, '{}', ALLTRIM(STR(lnMarca)))
            ENDIF
        ENDIF

        loModelo = THIS.oRepositorio.obtener_por_nombre( ;
            lcNombre, lnMaquina, lnMarca)

        IF THIS.nBandera == 1 THEN    && Agregar
            IF VARTYPE(loModelo) == 'O' THEN
                RETURN 'Nombre: ' + YA_EXISTE
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF VARTYPE(loModelo) == 'O' ;
                        AND loModelo.obtener_codigo() != ;
                            THIS.oModelo.obtener_codigo() THEN
                    RETURN 'Nombre: ' + YA_EXISTE
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
