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
* @file dao.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @abstract
* @class dao
* @extends interfaz_dao
* @uses constantes.h
*/

**/
* Clase abstracta que implementa la interfaz de acceso a datos (DAO).
*
* Implementa el patrón de diseño Data Access Object para proporcionar una
* interfaz genérica y reutilizable para las operaciones CRUD (Crear, Leer,
* Actualizar, Borrar) en tablas de base de datos relacionales.
*
* Esta clase está diseñada para ser implementada por clases DAO específicas de
* cada tabla a gestionar.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao AS interfaz_dao OF interfaz_dao.prg
    **/
    * @var string Nombre de la clase que representa el modelo de datos.
    */
    PROTECTED cModelo

    **
    * @var string Sentencia SQL para la cláusula ORDER BY.
    */
    PROTECTED cSqlOrder

    **
    * @var string Sentencia SQL para la cláusula SELECT.
    */
    PROTECTED cSqlSelect

    **
    * @var string Almacena el último mensaje de error ocurrido.
    */
    PROTECTED cUltimoError

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool existe_nombre(string tcNombre)
    * @method bool esta_vigente(int tnCodigo)
    * @method bool esta_relacionado(int tnCodigo)
    * @method int contar(string [tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre)
    * @method bool obtener_todos(string [tcCondicionFiltro], string [tcOrden])
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    * @method bool borrar(int tnCodigo)
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
    * @method string obtener_ultimo_error()
    */

    **/
    * Devuelve el último mensaje de error registrado.
    *
    * @return string Descripción del mensaje de error.
    */
    FUNCTION obtener_ultimo_error
        RETURN IIF(es_cadena(THIS.cUltimoError, 0, 254), THIS.cUltimoError, '')
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool configurar()
    * @method mixed obtener_modelo()
    * @method bool conectar(bool [tlModoEscritura])
    * @method bool desconectar()
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
    * @method bool Init()
    */

    **/
    * Constructor de la clase DAO.
    *
    * Este método se llama automáticamente al crear una instancia de la clase.
    * Delega la lógica de configuración al método protegido 'configurar()'.
    *
    * @return bool .T. si la inicialización se completa correctamente;
    *              .F. si ocurre un error.
    */
    PROTECTED FUNCTION Init
        RETURN THIS.configurar()
    ENDFUNC
ENDDEFINE
