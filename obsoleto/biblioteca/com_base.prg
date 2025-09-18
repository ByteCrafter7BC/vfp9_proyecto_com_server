**/
* com_base.prg
*
* Derechos de autor (C) 2000-2025 ByteCrafter7BC <bytecrafter7bc@gmail.com>
*
* Este programa es software libre: puede redistribuirlo y/o modificarlo
* bajo los términos de la Licencia Pública General GNU publicada por
* la Free Software Foundation, ya sea la versión 3 de la Licencia, o
* (a su elección) cualquier versión posterior.
*
* Este programa se distribuye con la esperanza de que sea útil,
* pero SIN NINGUNA GARANTÍA; sin siquiera la garantía implícita de
* COMERCIABILIDAD o IDONEIDAD PARA UN PROPÓSITO PARTICULAR. Consulte la
* Licencia Pública General de GNU para obtener más detalles.
*
* Debería haber recibido una copia de la Licencia Pública General de GNU
* junto con este programa. Si no es así, consulte
* <https://www.gnu.org/licenses/>.
*/

#INCLUDE 'constantes.h'

DEFINE CLASS com_base AS Session
    PROTECTED cModelo
    PROTECTED oRepositorio
    PROTECTED cUltimoError

    DataSession = 2    && 2 – Private data session.

    **--------------------------------------------------------------------------
    FUNCTION existe_codigo(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si existe el código u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.existe_codigo(tnCodigo)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION existe_nombre(tcNombre AS String) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si existe el nombre u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.existe_nombre(tcNombre)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION esta_vigente(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si está vigente el código; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.esta_vigente(tnCodigo)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION esta_relacionado(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si está relacionado el registro u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.esta_relacionado(tnCodigo)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION contar(tcCondicionFiltro AS String) AS Integer ;
        HELPSTRING 'Devuelve el número de registros en el repositorio actual.'
        RETURN THIS.oRepositorio.contar(tcCondicionFiltro)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_nuevo_codigo() AS Integer ;
        HELPSTRING 'Devuelve un número que se utiliza como código para un nuevo registro. En caso de error, devuelve -1.'
        RETURN THIS.oRepositorio.obtener_nuevo_codigo()
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_por_codigo(tnCodigo AS Integer) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si existe el código; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.obtener_por_codigo(tnCodigo)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_por_nombre(tcNombre AS String) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si existe el nombre; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oRepositorio.obtener_por_nombre(tcNombre)
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_todos(tcCondicionFiltro AS String, tcOrden AS String) ;
            AS String ;
        HELPSTRING 'Devuelve una cadena con formato XML que contiene el resultado de la búsqueda; de lo contrario, devuelve una cadena vacía. En caso de error, devuelve una cadena vacía.'

        LOCAL lcCursor, lcXml
        lcCursor = 'tm_' + THIS.cModelo
        lcXml = ''

        IF THIS.oRepositorio.obtener_todos(tcCondicionFiltro, tcOrden) THEN
            IF USED(lcCursor) THEN
                CURSORTOXML(lcCursor, 'lcXml', 1, 0, 0, '1')
                USE IN (lcCursor)
            ENDIF
        ENDIF

        RETURN lcXml
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_dto() AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si puede crear el objeto; de lo contrario, devuelve falso (.F.).'

        LOCAL lcClase, loObjeto, loExcepcion
        lcClase = 'dto_' + LOWER(THIS.cModelo)

        TRY
            loObjeto = NEWOBJECT(lcClase, lcClase + '.prg')
        CATCH TO loExcepcion
            registrar_error(lcClase, 'obtener_dto', loExcepcion.Message)
        ENDTRY

        RETURN loObjeto
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_ultimo_error AS String ;
        HELPSTRING 'Devuelve una cadena con la descripción del último error. Si no hay ningún error, devuelve una cadena vacía.'
        RETURN IIF(VARTYPE(THIS.cUltimoError) == 'C', THIS.cUltimoError, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION agregar(toDto AS Object) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si puede agregar el registro; de lo contrario, devuelve falso (.F.).'

        IF !THIS.oRepositorio.agregar(THIS.convertir_dto_a_modelo(toDto)) THEN
            THIS.cUltimoError = THIS.oRepositorio.obtener_ultimo_error()
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION modificar(toDto AS Object) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si puede modificar el registro; de lo contrario, devuelve falso (.F.).'

        IF !THIS.oRepositorio.modificar(THIS.convertir_dto_a_modelo(toDto)) THEN
            THIS.cUltimoError = THIS.oRepositorio.obtener_ultimo_error()
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION borrar(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si puede borrar el registro; de lo contrario, devuelve falso (.F.).'

        IF !THIS.oRepositorio.borrar(tnCodigo) THEN
            THIS.cUltimoError = THIS.oRepositorio.obtener_ultimo_error()
            RETURN .F.
        ENDIF
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                            PROTECTED METHODS                            *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

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
            registrar_error('com_' + LOWER(THIS.cModelo), ;
                'establecer_repositorio', ;
                STRTRAN(ERROR_INSTANCIA_CLASE, '{}', THIS.cModelo))
            RETURN .F.
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION convertir_dto_a_modelo
        LPARAMETERS toDto

        IF VARTYPE(toDto) != 'O' THEN
            RETURN .F.
        ENDIF

        LOCAL lnCodigo, lcNombre, llVigente

        WITH toDto
            lnCodigo = .obtener_codigo()
            lcNombre = ALLTRIM(.obtener_nombre())
            llVigente = .esta_vigente()
        ENDWITH

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            lnCodigo, lcNombre, llVigente)
    ENDFUNC
ENDDEFINE
