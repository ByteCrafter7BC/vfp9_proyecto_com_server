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
* Implementa el patr�n de dise�o Data Access Object para proporcionar una
* interfaz gen�rica y reutilizable para las operaciones CRUD (Crear, Leer,
* Actualizar, Borrar) en tablas de base de datos relacionales.
*
* Esta clase est� dise�ada para ser implementada por clases DAO espec�ficas de
* cada tabla a gestionar.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao AS interfaz_dao OF interfaz_dao.prg
    **/
    * @var string Nombre de la clase que representa el modelo de datos.
    */
    PROTECTED cModelo

    **
    * @var string Sentencia SQL para la cl�usula ORDER BY.
    */
    PROTECTED cSqlOrder

    **
    * @var string Sentencia SQL para la cl�usula SELECT.
    */
    PROTECTED cSqlSelect

    **
    * @var string Almacena el �ltimo mensaje de error ocurrido.
    */
    PROTECTED cUltimoError

    **/
    * @section M�TODOS P�BLICOS
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
    * -- M�TODO ESPEC�FICO DE ESTA CLASE --
    * @method string obtener_ultimo_error()
    */

    **/
    * Devuelve el �ltimo mensaje de error registrado.
    *
    * @return string Descripci�n del mensaje de error.
    */
    FUNCTION obtener_ultimo_error
        RETURN IIF(es_cadena(THIS.cUltimoError, 0, 254), THIS.cUltimoError, '')
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool configurar()
    * @method mixed obtener_modelo()
    * @method bool conectar(bool [tlModoEscritura])
    * @method bool desconectar()
    * -- M�TODO ESPEC�FICO DE ESTA CLASE --
    * @method bool Init()
    */

    **/
    * Constructor de la clase DAO.
    *
    * Este m�todo se llama autom�ticamente al crear una instancia de la clase.
    * Delega la l�gica de configuraci�n al m�todo protegido 'configurar()'.
    *
    * @return bool .T. si la inicializaci�n se completa correctamente;
    *              .F. si ocurre un error.
    */
    PROTECTED FUNCTION Init
        RETURN THIS.configurar()
    ENDFUNC
ENDDEFINE
