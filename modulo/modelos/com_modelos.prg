DEFINE CLASS com_modelos AS com_base OF com_base.prg OLEPUBLIC
    cModelo = 'modelos'

    **--------------------------------------------------------------------------
    FUNCTION nombre_existe(tcNombre AS String, tnMaquina AS Integer, ;
            tnMarca AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si el nombre existe ' + ;
            'u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.nombre_existe(tcNombre, tnMaquina, tnMarca)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_por_nombre(tcNombre AS String, tnMaquina AS Integer, ;
            tnMarca AS Integer) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si el nombre existe; ' + ;
            'de lo contrario, devuelve falso (.F.). En caso de error, ' + ;
            'devuelve falso (.F.).'
        RETURN THIS.oRepositorio.obtener_por_nombre(tcNombre, tnMaquina, ;
            tnMarca)
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                            PROTECTED METHODS                            *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION convertir_dto_a_modelo
        LPARAMETERS toDto

        IF VARTYPE(toDto) != 'O' THEN
            RETURN .F.
        ENDIF

        LOCAL lnCodigo, lcNombre, lnMaquina, lnMarca, llVigente

        WITH toDto
            lnCodigo = .obtener_codigo()
            lcNombre = ALLTRIM(.obtener_nombre())
            lnMaquina = .obtener_maquina()
            lnMarca = .obtener_marca()
            llVigente = .esta_vigente()
        ENDWITH

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            lnCodigo, lcNombre, lnMaquina, lnMarca, llVigente)
    ENDFUNC
ENDDEFINE
