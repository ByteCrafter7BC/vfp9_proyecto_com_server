DEFINE CLASS sifen_ciudad AS Custom
    PROTECTED nCodigo
    PROTECTED cNombre
    PROTECTED nDepartamento
    PROTECTED nDistrito

    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnDepartamento, tnDistrito

        IF !es_numero(tnCodigo) ;
                OR !es_cadena(tcNombre) ;
                OR !es_numero(tnDepartamento) ;
                OR !es_numero(tnDistrito) THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nCodigo = tnCodigo
            .cNombre = tcNombre
            .nDepartamento = tnDepartamento
            .nDistrito = tnDistrito
        ENDWITH
    ENDFUNC

    FUNCTION obtener_codigo
        RETURN THIS.nCodigo
    ENDFUNC

    FUNCTION obtener_nombre
        RETURN THIS.cNombre
    ENDFUNC

    FUNCTION obtener_departamento
        RETURN THIS.nDepartamento
    ENDFUNC

    FUNCTION obtener_distrito
        RETURN THIS.nDistrito
    ENDFUNC
ENDDEFINE

DEFINE CLASS sifen_ciudades_copia AS Custom
    PROTECTED oCiudades

    FUNCTION Init
        THIS.oCiudades = CREATEOBJECT('Collection')

        LOCAL loCiudad
        loCiudad = CREATEOBJECT('sifen_ciudad', 1, 'sss', 1, 1)


        MESSAGEBOX(vartype(loCiudad))
    ENDFUNC

    PROTECTED FUNCTION ciudad_agregar
        LPARAMETERS tnCodigo, tcNombre, tnDepartamento, tnDistrito

        LOCAL loCiudad
        loCiudad = CREATEOBJECT('sifen_ciudad', ;
            tnCodigo, tcNombre, tnDepartamento, tnDistrito)

        IF !es_objeto(loCiudad) OR campo_existe(tcNombre) THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCiudades.Add(loCiudad, tnCodigo)
    ENDFUNC

    PROTECTED FUNCTION ciudad_existe
        LPARAMETERS tnCodigo

        IF PARAMETERS() != 1 ;
                OR !es_numero(tnCodigo) ;
                OR !es_objeto(THIS.oCiudades) THEN
            RETURN .T.
        ENDIF

        RETURN THIS.oCiudades.GetKey(tnCodigo) > 0
    ENDFUNC

    PROTECTED FUNCTION ciudad_obtener
        LPARAMETERS tnCodigo

        IF PARAMETERS() != 1 OR !THIS.ciudad_existe(tnCodigo) THEN
            RETURN .F.
        ENDIF

        RETURN HIS.oCiudades.Item(tnCodigo)
    ENDFUNC
ENDDEFINE
