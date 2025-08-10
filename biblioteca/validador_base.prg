#INCLUDE 'constantes.h'

DEFINE CLASS validador_base AS Custom
    PROTECTED cModelo
    PROTECTED nAnchoCodigo
    PROTECTED nAnchoNombre

    PROTECTED nBandera
    PROTECTED oModelo
    PROTECTED oRepositorio

    PROTECTED cErrorCodigo
    PROTECTED cErrorNombre
    PROTECTED cErrorVigente

    **--------------------------------------------------------------------------
    FUNCTION Init
        LPARAMETERS tnBandera, toModelo, toRepositorio

        IF VARTYPE(tnBandera) != 'N' ;
                OR !BETWEEN(tnBandera, 1, 3) ;
                OR VARTYPE(toModelo) != 'O' ;
                OR VARTYPE(toRepositorio) != 'O' ;
                OR !THIS.configurar() THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nBandera = tnBandera
            .oModelo = toModelo
            .oRepositorio = toRepositorio
        ENDWITH

        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            THIS.validar()
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            IF !EMPTY(THIS.cErrorCodigo) ;
                    OR !EMPTY(THIS.cErrorNombre) ;
                    OR !EMPTY(THIS.cErrorVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN !THIS.oRepositorio.esta_relacionado( ;
                THIS.oModelo.obtener_codigo())
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_codigo
        RETURN IIF(VARTYPE(THIS.cErrorCodigo) == 'C', THIS.cErrorCodigo, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_nombre
        RETURN IIF(VARTYPE(THIS.cErrorNombre) == 'C', THIS.cErrorNombre, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_vigente
        RETURN IIF(VARTYPE(THIS.cErrorVigente) == 'C', THIS.cErrorVigente, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION configurar
        IF VARTYPE(THIS.cModelo) != 'C' OR EMPTY(THIS.cModelo) THEN
            IF ATC('validador_', THIS.Name) == 0 THEN
                RETURN .F.
            ENDIF

            THIS.cModelo = SUBSTR(LOWER(THIS.Name), 11)
        ENDIF

        IF VARTYPE(THIS.nAnchoCodigo) != 'N' OR THIS.nAnchoCodigo <= 0 THEN
            THIS.nAnchoCodigo = 9999
        ENDIF

        IF VARTYPE(THIS.nAnchoNombre) != 'N' OR THIS.nAnchoNombre <= 0 THEN
            THIS.nAnchoNombre = 30
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar
        WITH THIS
            .cErrorCodigo = .validar_codigo()
            .cErrorNombre = .validar_nombre()
            .cErrorVigente = .validar_vigente()
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_codigo
        LOCAL lcEtiqueta, lnCodigo, loModelo
        lcEtiqueta = 'Código: '
        lnCodigo = THIS.oModelo.obtener_codigo()

        IF lnCodigo <= 0 THEN
            RETURN lcEtiqueta + MAYOR_QUE_CERO
        ENDIF

        IF lnCodigo > THIS.nAnchoCodigo THEN
            RETURN lcEtiqueta + ;
                STRTRAN(MENOR_QUE, '{}', ALLTRIM(STR(THIS.nAnchoCodigo + 1)))
        ENDIF

        loModelo = THIS.oRepositorio.obtener_por_codigo(lnCodigo)

        IF THIS.nBandera == 1 THEN    && Agregar
            IF !EMPTY(THIS.oRepositorio.obtener_ultimo_error()) THEN
                RETURN lcEtiqueta + THIS.oRepositorio.obtener_ultimo_error()
            ENDIF

            IF VARTYPE(loModelo) == 'O' THEN
                RETURN lcEtiqueta + YA_EXISTE
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF !EMPTY(THIS.oRepositorio.obtener_ultimo_error()) THEN
                    RETURN lcEtiqueta + THIS.oRepositorio.obtener_ultimo_error()
                ENDIF

                IF VARTYPE(loModelo) != 'O' THEN
                    RETURN lcEtiqueta + NO_EXISTE
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_nombre
        LOCAL lcEtiqueta, lcNombre, loModelo
        lcEtiqueta = 'Nombre: '
        lcNombre = THIS.oModelo.obtener_nombre()

        IF !EMPTY(THIS.cErrorCodigo) THEN
            RETURN THIS.cErrorCodigo
        ENDIF

        IF EMPTY(lcNombre) THEN
            RETURN lcEtiqueta + NO_BLANCO
        ENDIF

        IF LEN(lcNombre) > THIS.nAnchoNombre THEN
            RETURN lcEtiqueta + ;
                STRTRAN(LONGITUD_MAXIMA, '{}', ALLTRIM(STR(THIS.nAnchoNombre)))
        ENDIF

        loModelo = THIS.oRepositorio.obtener_por_nombre(lcNombre)

        IF THIS.nBandera == 1 THEN    && Agregar
            IF !EMPTY(THIS.oRepositorio.obtener_ultimo_error()) THEN
                RETURN lcEtiqueta + THIS.oRepositorio.obtener_ultimo_error()
            ENDIF

            IF VARTYPE(loModelo) == 'O' THEN
                RETURN lcEtiqueta + YA_EXISTE
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF !EMPTY(THIS.oRepositorio.obtener_ultimo_error()) THEN
                    RETURN lcEtiqueta + THIS.oRepositorio.obtener_ultimo_error()
                ENDIF

                IF VARTYPE(loModelo) == 'O' ;
                        AND loModelo.obtener_codigo() != ;
                            THIS.oModelo.obtener_codigo() THEN
                    RETURN lcEtiqueta + YA_EXISTE
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_vigente
        IF VARTYPE(THIS.oModelo.esta_vigente()) != 'L' THEN
            RETURN 'Vigente: ' + TIPO_LOGICO
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
