**/
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
* Clase base para la capa de lógica de negocio (COM).
*
* Esta clase sirve como una capa intermedia que expone una interfaz de alto
* nivel para la interacción con los datos. Delega las operaciones de acceso
* a los datos a un objeto DAO (Data Access Object) y maneja las conversiones
* entre DTO (Data Transfer Objects) y modelos de datos.
*
* Cada clase COM específica debe heredar de esta clase para encapsular la
* lógica de negocio de un modelo particular.
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
    * @var string Almacena el último mensaje de error ocurrido.
    */
    PROTECTED cUltimoError

    **/
    * No utilizar { DataSession = 2    && 2 – Private Data Session. }
    * Problema: Al llamar a la función create_dao(string tcModel), se devuelve
    * un objeto DAO. Este objeto, a su vez, tiene varios métodos, uno de los
    * cuales es obtener_todos([string tcCondicionFiltro], [string tcOrden]));
    * cuando se llama a este método sin argumentos, debería recuperar todos los
    * registros del modelo, pero no lo hace.
    * Solución: DataSession = 1    && 1 – Default Data Session.
    */
    DataSession = 1    && 1 – Default Data Session.

    **/
    * @section MÉTODOS PÚBLICOS
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
    * Verifica si un código ya existe en la tabla.
    *
    * @param int tnCodigo Código numérico a verificar.
    *
    * @return bool .T. si el código existe o si ocurre un error.
    */
    FUNCTION existe_codigo(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si existe el código u ocurre un error; de lo contrario, devuelve falso (.F.).'
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
    * Verifica si un registro está vigente.
    *
    * @param int tnCodigo Código numérico a verificar.
    *
    * @return bool .T. si el registro existe y su estado es vigente.
    *              .F. si el registro no existe, no está vigente o si ocurre un
    *              error.
    */
    FUNCTION esta_vigente(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si está vigente el código; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oDao.esta_vigente(tnCodigo)
    ENDFUNC

    **/
    * Verifica si un registro está relacionado con otras tablas.
    *
    * @param int tnCodigo Código numérico a verificar.
    *
    * @return bool .T. si el registro está relacionado o si ocurre un error.
    */
    FUNCTION esta_relacionado(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si está relacionado el registro u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oDao.esta_relacionado(tnCodigo)
    ENDFUNC

    **/
    * Cuenta el número de registros que cumplen con una condición de filtro.
    *
    * @param string [tcCondicionFiltro] La cláusula WHERE de la consulta, sin
    *                                   la palabra "WHERE".
    *
    * @return int Número de registros contados. Devuelve -1 si ocurre un error.
    */
    FUNCTION contar(tcCondicionFiltro AS String) AS Integer ;
        HELPSTRING 'Devuelve el número de registros en el repositorio actual.'
        RETURN THIS.oDao.contar(tcCondicionFiltro)
    ENDFUNC

    **/
    * Obtiene el siguiente código numérico secuencial disponible.
    *
    * Busca el primer hueco en la secuencia de códigos a partir de 1.
    *
    * @return int Número entero positivo que representa el siguiente código
    *             disponible. Devuelve -1 si ocurre un error.
    */
    FUNCTION obtener_nuevo_codigo() AS Integer ;
        HELPSTRING 'Devuelve un número que se utiliza como código para un nuevo registro. En caso de error, devuelve -1.'
        RETURN THIS.oDao.obtener_nuevo_codigo()
    ENDFUNC

    **/
    * Obtiene un registro, buscándolo por código.
    *
    * @param int tnCodigo Código del registro a obtener.
    *
    * @return mixed Object modelo si el registro fue encontrado.
    *               .F. si el registro no fue encuentrado o si ocurre un error.
    */
    FUNCTION obtener_por_codigo(tnCodigo AS Integer) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si existe el código; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oDao.obtener_por_codigo(tnCodigo)
    ENDFUNC

    **/
    * Obtiene un registro, buscándolo por nombre.
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
    * Obtiene una colección de registros en formato XML.
    *
    * @param string [tcCondicionFiltro] La cláusula WHERE de la consulta.
    * @param string [tcOrden] La cláusula ORDER BY de la consulta.
    *
    * @return string Cadena XML con el resultado de la búsqueda. Retorna una
    *                cadena vacía en caso de no encontrar registros o si ocurre
    *                un error.
    */
    FUNCTION obtener_todos(tcCondicionFiltro AS String, tcOrden AS String) ;
            AS String ;
        HELPSTRING 'Devuelve una cadena con formato XML que contiene el resultado de la búsqueda; de lo contrario, devuelve una cadena vacía. En caso de error, devuelve una cadena vacía.'

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
    *               .F. si ocurre un error en la creación.
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
    * Obtiene el último mensaje de error registrado en la clase.
    *
    * @return string Descripción del error. Cadena vacía si no hay error.
    */
    FUNCTION obtener_ultimo_error AS String ;
        HELPSTRING 'Devuelve una cadena con la descripción del último error. Si no hay ningún error, devuelve una cadena vacía.'
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
    * @param int tnCodigo Código numérico del registro a borrar.
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
    * @section MÉTODOS PROTEGIDOS
    * @method bool Init()
    * @method bool configurar()
    * @method void establecer_entorno()
    * @method bool establecer_dao()
    * @method mixed convertir_dto_a_modelo(object toDto)
    */

    **/
    * Constructor de la clase DAO.
    *
    * Este método se llama automáticamente al crear una instancia de la clase.
    * Delega la lógica de configuración al método 'configurar()'.
    *
    * @return bool .T. si la inicialización fue completada correctamente.
    */
    PROTECTED FUNCTION Init
        RETURN THIS.configurar()
    ENDFUNC

    **/
    * Configura la instancia de la clase COM.
    *
    * Llama a los métodos 'establecer_entorno' y 'establecer_dao' para
    * inicializar el entorno de datos y el objeto DAO. También establece la
    * propiedad '_oSCREEN' si no existe.
    *
    * @return bool .T. si la configuración fue completada correctamente.
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
    * @return bool .T. si el objeto DAO se creó correctamente.
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
    * @return mixed Object si la conversión fue completada correctamente.
    *               .F. si el parámetro de entrada no es un objeto válido.
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
