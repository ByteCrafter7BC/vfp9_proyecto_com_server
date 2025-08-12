DEFINE CLASS com_base AS Session
    PROTECTED cModelo
    PROTECTED oRepositorio

    DataSession = 2    && 2 – Private data session.

    **--------------------------------------------------------------------------
    FUNCTION codigo_existe(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si el código existe u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.codigo_existe(tnCodigo)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION nombre_existe(tcNombre AS String) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si el nombre existe u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.nombre_existe(tcNombre)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION esta_vigente(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si el código está vigente; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.esta_vigente(tnCodigo)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION esta_relacionado(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si el registro está relacionado u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.esta_relacionado(tnCodigo)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_por_codigo(tnCodigo AS Integer) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si el código existe; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.obtener_por_codigo(tnCodigo)
    ENDFUNC

    **/
    * Métodos protegidos.
    */

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION Init
        RETURN THIS.configurar()
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION configurar
        THIS.establecer_entorno()

        IF VARTYPE(THIS.cModelo) != 'C' OR EMPTY(THIS.cModelo) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(_oSCREEN) != 'O' THEN
            PUBLIC _oSCREEN
            _oSCREEN = CREATEOBJECT('Empty')
        ENDIF

        RETURN THIS.establecer_repositorio()
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION establecer_entorno
        SET CPDIALOG OFF
        SET DELETED ON
        SET EXACT ON
        SET EXCLUSIVE ON
        SET REPROCESS TO 2 SECONDS
        SET RESOURCE OFF
        SET SAFETY OFF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION establecer_repositorio
        THIS.oRepositorio = crear_repositorio(THIS.cModelo)

        IF VARTYPE(THIS.oRepositorio) != 'O' THEN
            registrar_error('com_' + LOWER(ALLTRIM(THIS.cModelo)), ;
                'establecer_repositorio', ;
                STRTRAN(ERROR_INSTANCIA_CLASE, '{}', THIS.cModelo))
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
