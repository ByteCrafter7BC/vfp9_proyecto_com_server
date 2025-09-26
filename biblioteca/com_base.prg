**/
* Derechos de autor (C) 2000-2025 ByteCrafter7BC <bytecrafter7bc@gmail.com>
*
* Este programa es software libre: puede redistribuirlo y/o modificarlo
* bajo los t�rminos de la Licencia P�blica General GNU publicada por
* la Free Software Foundation, ya sea la versi�n 3 de la Licencia, o
* (a su elecci�n) cualquier versi�n posterior.
*
* Este programa se distribuye con la esperanza de que sea �til,
* pero SIN NINGUNA GARANT�A; sin siquiera la garant�a impl�cita de
* COMERCIABILIDAD o IDONEIDAD PARA UN PROP�SITO PARTICULAR. Consulte la
* Licencia P�blica General de GNU para obtener m�s detalles.
*
* Deber�a haber recibido una copia de la Licencia P�blica General de GNU
* junto con este programa. Si no es as�, consulte
* <https://www.gnu.org/licenses/>.
*/

**/
* @file com_base.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @abstract
* @class com_base
* @extends Session
* @uses constantes.h
*/

**/
* Clase base para la capa de l�gica de negocio (COM).
*
* Esta clase sirve como una capa intermedia que expone una interfaz de alto
* nivel para la interacci�n con los datos. Delega las operaciones de acceso
* a los datos a un objeto DAO (Data Access Object) y maneja las conversiones
* entre DTO (Data Transfer Objects) y modelos de datos.
*
* Cada clase COM espec�fica debe heredar de esta clase para encapsular la
* l�gica de negocio de un modelo particular.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS com_base AS Session
    **/
    * @var string Nombre del modelo de datos asociado a la clase.
    */
    PROTECTED cModelo

    **
    * @var object DAO (Data Access Object) que maneja las operaciones de
    *             persistencia.
    */
    PROTECTED oDao

    **/
    * @var string Almacena el �ltimo mensaje de error ocurrido.
    */
    PROTECTED cUltimoError

    **/
    * No utilizar { DataSession = 2    && 2 � Private Data Session. }
    * Problema: Al llamar a la funci�n create_dao(string tcModel), se devuelve
    * un objeto DAO. Este objeto, a su vez, tiene varios m�todos, uno de los
    * cuales es obtener_todos([string tcCondicionFiltro], [string tcOrden]));
    * cuando se llama a este m�todo sin argumentos, deber�a recuperar todos los
    * registros del modelo, pero no lo hace.
    * Soluci�n: DataSession = 1    && 1 � Default Data Session.
    */
    DataSession = 1    && 1 � Default Data Session.

    **/
    * @section M�TODOS P�BLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool existe_nombre(string tcNombre)
    * @method bool esta_vigente(int tnCodigo)
    * @method bool esta_relacionado(int tnCodigo)
    * @method int contar([string tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre)
    * @method string obtener_todos([string tcCondicionFiltro], [string tcOrden])
    * @method mixed obtener_dto()
    * @method string obtener_ultimo_error()
    * @method bool agregar(object toDto)
    * @method bool modificar(object toDto)
    * @method bool borrar(int tnCodigo)
    */

    **/
    * Verifica si un c�digo ya existe en la tabla.
    *
    * @param int tnCodigo C�digo num�rico a verificar.
    *
    * @return bool .T. si el c�digo existe o si ocurre un error.
    */
    FUNCTION existe_codigo(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si existe el c�digo u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oDao.existe_codigo(tnCodigo)
    ENDFUNC

    **/
    * Verifica si un nombre ya existe en la tabla.
    *
    * @param string tcNombre Nombre a verificar.
    *
    * @return bool .T. si el nombre existe o si ocurre un error.
    */
    FUNCTION existe_nombre(tcNombre AS String) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si existe el nombre u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oDao.existe_nombre(tcNombre)
    ENDFUNC

    **/
    * Verifica si un registro est� vigente.
    *
    * @param int tnCodigo C�digo num�rico a verificar.
    *
    * @return bool .T. si el registro existe y su estado es vigente.
    *              .F. si el registro no existe, no est� vigente o si ocurre un
    *              error.
    */
    FUNCTION esta_vigente(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si est� vigente el c�digo; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oDao.esta_vigente(tnCodigo)
    ENDFUNC

    **/
    * Verifica si un registro est� relacionado con otras tablas.
    *
    * @param int tnCodigo C�digo num�rico a verificar.
    *
    * @return bool .T. si el registro est� relacionado o si ocurre un error.
    */
    FUNCTION esta_relacionado(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si est� relacionado el registro u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oDao.esta_relacionado(tnCodigo)
    ENDFUNC

    **/
    * Cuenta el n�mero de registros que cumplen con una condici�n de filtro.
    *
    * @param string [tcCondicionFiltro] La cl�usula WHERE de la consulta, sin
    *                                   la palabra "WHERE".
    *
    * @return int N�mero de registros contados. Devuelve -1 si ocurre un error.
    */
    FUNCTION contar(tcCondicionFiltro AS String) AS Integer ;
        HELPSTRING 'Devuelve el n�mero de registros en el repositorio actual.'
        RETURN THIS.oDao.contar(tcCondicionFiltro)
    ENDFUNC

    **/
    * Obtiene el siguiente c�digo num�rico secuencial disponible.
    *
    * Busca el primer hueco en la secuencia de c�digos a partir de 1.
    *
    * @return int N�mero entero positivo que representa el siguiente c�digo
    *             disponible. Devuelve -1 si ocurre un error.
    */
    FUNCTION obtener_nuevo_codigo() AS Integer ;
        HELPSTRING 'Devuelve un n�mero que se utiliza como c�digo para un nuevo registro. En caso de error, devuelve -1.'
        RETURN THIS.oDao.obtener_nuevo_codigo()
    ENDFUNC

    **/
    * Obtiene un registro, busc�ndolo por c�digo.
    *
    * @param int tnCodigo C�digo del registro a obtener.
    *
    * @return mixed Object modelo si el registro fue encontrado.
    *               .F. si el registro no fue encuentrado o si ocurre un error.
    */
    FUNCTION obtener_por_codigo(tnCodigo AS Integer) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si existe el c�digo; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oDao.obtener_por_codigo(tnCodigo)
    ENDFUNC

    **/
    * Obtiene un registro, busc�ndolo por nombre.
    *
    * @param string tcNombre Nombre del registro a obtener.
    *
    * @return mixed Object modelo si el registro fue encontrado.
    *               .F. si el registro no fue encuentrado o si ocurre un error.
    */
    FUNCTION obtener_por_nombre(tcNombre AS String) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si existe el nombre; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oDao.obtener_por_nombre(tcNombre)
    ENDFUNC

    **/
    * Obtiene una colecci�n de registros en formato XML.
    *
    * @param string [tcCondicionFiltro] La cl�usula WHERE de la consulta.
    * @param string [tcOrden] La cl�usula ORDER BY de la consulta.
    *
    * @return string Cadena XML con el resultado de la b�squeda. Retorna una
    *                cadena vac�a en caso de no encontrar registros o si ocurre
    *                un error.
    */
    FUNCTION obtener_todos(tcCondicionFiltro AS String, tcOrden AS String) ;
            AS String ;
        HELPSTRING 'Devuelve una cadena con formato XML que contiene el resultado de la b�squeda; de lo contrario, devuelve una cadena vac�a. En caso de error, devuelve una cadena vac�a.'

        LOCAL lcCursor, lcXml
        lcCursor = 'tm_' + THIS.cModelo
        lcXml = ''

        IF THIS.oDao.obtener_todos(tcCondicionFiltro, tcOrden) THEN
            IF USED(lcCursor) THEN
                CURSORTOXML(lcCursor, 'lcXml', 1, 0, 0, '1')
                USE IN (lcCursor)
            ENDIF
        ENDIF

        RETURN lcXml
    ENDFUNC

    **/
    * Crea y devuelve un objeto DTO del modelo asociado.
    *
    * @return mixed Object DTO si se puede crear.
    *               .F. si ocurre un error en la creaci�n.
    */
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

    **/
    * Obtiene el �ltimo mensaje de error registrado en la clase.
    *
    * @return string Descripci�n del error. Cadena vac�a si no hay error.
    */
    FUNCTION obtener_ultimo_error AS String ;
        HELPSTRING 'Devuelve una cadena con la descripci�n del �ltimo error. Si no hay ning�n error, devuelve una cadena vac�a.'
        RETURN IIF(VARTYPE(THIS.cUltimoError) == 'C', THIS.cUltimoError, '')
    ENDFUNC

    **/
    * Agrega un nuevo registro a la tabla.
    *
    * @param object toDto DTO que contiene los datos del registro.
    *
    * @return bool .T. si el registro fue agregado correctamente.
    */
    FUNCTION agregar(toDto AS Object) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si puede agregar el registro; de lo contrario, devuelve falso (.F.).'

        IF !THIS.oDao.agregar(THIS.convertir_dto_a_modelo(toDto)) THEN
            THIS.cUltimoError = THIS.oDao.obtener_ultimo_error()
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Modifica un registro existente en la tabla.
    *
    * @param object toDto DTO con los datos actualizados del registro.
    *
    * @return bool .T. si el registro fue modificado correctamente.
    */
    FUNCTION modificar(toDto AS Object) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si puede modificar el registro; de lo contrario, devuelve falso (.F.).'

        IF !THIS.oDao.modificar(THIS.convertir_dto_a_modelo(toDto)) THEN
            THIS.cUltimoError = THIS.oDao.obtener_ultimo_error()
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Borra un registro de la tabla.
    *
    * @param int tnCodigo C�digo num�rico del registro a borrar.
    *
    * @return bool .T. si el registro fue borrado correctamente.
    */
    FUNCTION borrar(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si puede borrar el registro; de lo contrario, devuelve falso (.F.).'

        IF !THIS.oDao.borrar(tnCodigo) THEN
            THIS.cUltimoError = THIS.oDao.obtener_ultimo_error()
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool Init()
    * @method bool configurar()
    * @method void establecer_entorno()
    * @method bool establecer_dao()
    * @method mixed convertir_dto_a_modelo(object toDto)
    */

    **/
    * Constructor de la clase DAO.
    *
    * Este m�todo se llama autom�ticamente al crear una instancia de la clase.
    * Delega la l�gica de configuraci�n al m�todo 'configurar()'.
    *
    * @return bool .T. si la inicializaci�n fue completada correctamente.
    */
    PROTECTED FUNCTION Init
        RETURN THIS.configurar()
    ENDFUNC

    **/
    * Configura la instancia de la clase COM.
    *
    * Llama a los m�todos 'establecer_entorno' y 'establecer_dao' para
    * inicializar el entorno de datos y el objeto DAO. Tambi�n establece la
    * propiedad '_oSCREEN' si no existe.
    *
    * @return bool .T. si la configuraci�n fue completada correctamente.
    */
    PROTECTED FUNCTION configurar
        THIS.establecer_entorno()

        IF VARTYPE(THIS.cModelo) != 'C' OR EMPTY(THIS.cModelo) THEN
            RETURN .F.
        ENDIF

        RETURN THIS.establecer_dao()
    ENDFUNC

    **/
    * Establece las configuraciones de entorno de Visual FoxPro para la clase.
    */
    PROTECTED PROCEDURE establecer_entorno
        SET CPDIALOG OFF
        SET DELETED ON
        SET EXACT ON
        SET EXCLUSIVE ON
        SET REPROCESS TO 2 SECONDS
        SET RESOURCE OFF
        SET SAFETY OFF
    ENDPROC

    **/
    * Crea una instancia del objeto DAO y la asigna a la propiedad 'oDao'.
    *
    * @return bool .T. si el objeto DAO se cre� correctamente.
    */
    PROTECTED FUNCTION establecer_dao
        THIS.oDao = crear_dao(THIS.cModelo)

        IF VARTYPE(THIS.oDao) != 'O' THEN
            registrar_error('com_' + LOWER(THIS.cModelo), ;
                'establecer_dao', ;
                STRTRAN(MSG_ERROR_INSTANCIA_CLASE, '{}', THIS.cModelo))
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Convierte un objeto DTO (Data Transfer Object) a su objeto modelo
    * correspondiente.
    *
    * Extrae los datos de un DTO para instanciar y devolver un nuevo objeto del
    * modelo.
    *
    * @param object toDto DTO que se va a convertir.
    * @return mixed Object si la conversi�n fue completada correctamente.
    *               .F. si el par�metro de entrada no es un objeto v�lido.
    */
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
