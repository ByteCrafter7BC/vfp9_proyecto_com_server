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
* Interfaz de acceso a datos (DAO).
*
* Implementa el patr�n de dise�o Data Access Object para proporcionar una
* interfaz gen�rica y reutilizable para las operaciones CRUD (Crear, Leer,
* Actualizar, Borrar) en tablas de base de datos relacionales.
*
* Esta clase est� dise�ada para ser implementada por clases DAO espec�ficas de
* cada tabla a gestionar.
*
* @file interfaz_dao.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class interfaz_dao
* @extends Custom
*/
DEFINE CLASS interfaz_dao AS Custom
    **/
    * @section M�TODOS P�BLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool existe_nombre(string tcNombre)
    * @method bool esta_vigente(int tnCodigo)
    * @method bool esta_relacionado(int tnCodigo)
    * @method int contar()
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo()
    * @method mixed obtener_por_nombre()
    * @method bool obtener_todos([string tcCondicionFiltro], [string tcOrden])
    * @method string obtener_ultimo_error()
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    * @method bool borrar(int tnCodigo)
    */

    **/
    * Verifica si un c�digo ya existe en la tabla.
    *
    * @param int tnCodigo C�digo num�rico a verificar.
    *
    * @return bool .T. si el c�digo existe o si ocurre un error.
    */
    FUNCTION existe_codigo
        LPARAMETERS tnCodigo
        RETURN .T.
    ENDFUNC

    **/
    * Verifica si un nombre ya existe en la tabla.
    *
    * @param string tcNombre Nombre a verificar.
    *
    * @return bool .T. si el nombre existe o si ocurre un error.
    */
    FUNCTION existe_nombre
        LPARAMETERS tcNombre
        RETURN .T.
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
    FUNCTION esta_vigente
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/
    * Verifica si un registro est� relacionado con otras tablas.
    *
    * @param int tnCodigo C�digo num�rico a verificar.
    *
    * @return bool .T. si el registro est� relacionado o si ocurre un error.
    */
    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo
        RETURN .T.
    ENDFUNC

    **/
    * Cuenta el n�mero de registros que cumplen con una condici�n de filtro.
    *
    * @param string [tcCondicionFiltro] La cl�usula WHERE de la consulta, sin
    *                                   la palabra "WHERE".
    *
    * @return int N�mero de registros contados. Devuelve -1 si ocurre un error.
    */
    FUNCTION contar
        LPARAMETERS tcCondicionFiltro
        RETURN -1
    ENDFUNC

    **/
    * Obtiene el siguiente c�digo num�rico secuencial disponible.
    *
    * Busca el primer hueco en la secuencia de c�digos a partir de 1.
    *
    * @return int N�mero entero positivo que representa el siguiente c�digo
    *             disponible. Devuelve -1 si ocurre un error.
    */
    FUNCTION obtener_nuevo_codigo
        RETURN -1
    ENDFUNC

    **/
    * Obtiene un registro, busc�ndolo por c�digo.
    *
    * @param int tnCodigo C�digo del registro a obtener.
    *
    * @return mixed Object modelo si el registro fue encontrado.
    *               .F. si no fue encuentrado el registro o si ocurre un error.
    */
    FUNCTION obtener_por_codigo
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/
    * Obtiene un registro, busc�ndolo por nombre.
    *
    * @param string tcNombre Nombre del registro a obtener.
    *
    * @return mixed Object modelo si el registro fue encontrado.
    *               .F. si no fue encuentrado el registro o si ocurre un error.
    */
    FUNCTION obtener_por_nombre
        LPARAMETERS tcNombre
        RETURN .F.
    ENDFUNC

    **/
    * Obtiene una colecci�n de registros en un cursor temporal.
    *
    * Ejecuta una consulta SELECT sobre la tabla y deja el resultado en un
    * cursor llamado 'tm_' + THIS.cModelo
    *
    * @param string [tcCondicionFiltro] La cl�usula WHERE de la consulta.
    * @param string [tcOrden] La cl�usula ORDER BY de la consulta.
    *
    * @return bool .T. si la consulta fue ejecutada correctamente.
    */
    FUNCTION obtener_todos
        LPARAMETERS tcCondicionFiltro, tcOrden
        RETURN .F.
    ENDFUNC

    **/
    * Obtiene el �ltimo mensaje de error registrado.
    *
    * @return string Descripci�n del mensaje de error.
    */
    FUNCTION obtener_ultimo_error
        RETURN 'No implementado.'
    ENDFUNC

    **/
    * Agrega un nuevo registro a la tabla.
    *
    * @param object toModelo Modelo que contiene los datos del registro.
    *
    * @return bool .T. si el registro fue agregado correctamente.
    */
    FUNCTION agregar
        LPARAMETERS toModelo
        RETURN .F.
    ENDFUNC

    **/
    * Modifica un registro existente en la tabla.
    *
    * @param object toModelo Modelo con los datos actualizados del registro.
    *
    * @return bool .T. si el registro fue modificado correctamente.
    */
    FUNCTION modificar
        LPARAMETERS toModelo
        RETURN .F.
    ENDFUNC

    **/
    * Borra un registro de la tabla.
    *
    * @param int tnCodigo C�digo num�rico del registro a borrar.
    *
    * @return bool .T. si el registro fue borrado correctamente.
    */
    FUNCTION borrar
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool configurar()
    * @method mixed obtener_modelo()
    * @method bool conectar()
    * @method bool desconectar()
    */

    **/
    * Configura las propiedades por defecto del DAO.
    *
    * Infiere el nombre del modelo y establece valores predeterminados para las
    * cl�usulas SQL si no se han especificado.
    *
    * @return bool .T. si la configuraci�n fue completada correctamente.
    */
    PROTECTED FUNCTION configurar
        RETURN .F.
    ENDFUNC

    **/
    * Crea un objeto a partir del registro actual de la tabla.
    *
    * @return mixed Object Instancia de la clase modelo si la operaci�n
    *               completada correctamente.
    *              .F. si ocurre un error.
    */
    PROTECTED FUNCTION obtener_modelo
        RETURN .F.
    ENDFUNC

    **/
    * Establece conexi�n con la base de datos.
    *
    * @return bool .T. si la conexi�n fue establecida correctamente.
    */
    PROTECTED FUNCTION conectar
        RETURN .F.
    ENDFUNC

    **/
    * Cierra la conexi�n con la base de datos.
    *
    * @return bool .T. si la conexi�n fue cerrada exitosamente.
    */
    PROTECTED FUNCTION desconectar
        RETURN .F.
    ENDFUNC
ENDDEFINE
