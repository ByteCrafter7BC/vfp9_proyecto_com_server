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
* Interfaz de acceso a datos (DAO).
*
* Implementa el patrón de diseño Data Access Object para proporcionar una
* interfaz genérica y reutilizable para las operaciones CRUD (Crear, Leer,
* Actualizar, Borrar) en tablas de base de datos relacionales.
*
* Esta clase está diseñada para ser implementada por clases DAO específicas de
* cada tabla a gestionar.
*
* @file        interfaz_dao.prg
* @package     biblioteca
* @author      ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version     1.0.0
* @since       1.0.0
* @class       interfaz_dao
* @extends     Custom
* @method bool existe_codigo(int tnCodigo)
* @method bool existe_nombre(string tcNombre)
* @method bool esta_vigente(int tnCodigo)
* @method bool esta_relacionado(int tnCodigo)
* @method int contar()
* @method int obtener_nuevo_codigo()
* @method mixed obtener_por_codigo()
* @method mixed obtener_por_nombre()
* @method bool obtener_todos([[string tcCondicionFiltro], [string tcOrden]])
* @method string obtener_ultimo_error()
* @method bool agregar(object toModelo)
* @method bool modificar(object toModelo)
* @method bool borrar(int tnCodigo)
*/
DEFINE CLASS interfaz_dao AS Custom
    **/
    * Verifica si un código ya existe en la tabla.
    *
    * @param int tnCodigo Código numérico a verificar.
    * @return bool .T. si el código existe u ocurre un error.
    *              .F. únicamente si el código no existe.
    * @access public
    */
    FUNCTION existe_codigo
        LPARAMETERS tnCodigo
        RETURN .T.
    ENDFUNC

    **/
    * Verifica si un nombre ya existe en la tabla.
    *
    * @param string tcNombre Nombre a verificar.
    * @return bool .T. si el nombre existe u ocurre un error.
    *              .F. únicamente si el nombre no existe.
    * @access public
    */
    FUNCTION existe_nombre
        LPARAMETERS tcNombre
        RETURN .T.
    ENDFUNC

    **/
    * Verifica si un registro está vigente.
    *
    * @param int tnCodigo Código numérico a verificar.
    * @return bool .T. si el registro existe y está vigente.
    *              .F. si no existe, no está vigente u ocurre un error.
    * @access public
    */
    FUNCTION esta_vigente
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/
    * Verifica si un registro está relacionado con otras tablas.
    *
    * @param int tnCodigo Código numérico a verificar.
    * @return bool .T. si el registro está relacionado u ocurre un error.
    *              .F. únicamente si no está relacionado.
    * @access public
    */
    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo
        RETURN .T.
    ENDFUNC

    **/
    * Cuenta la cantidad de registros que cumplen con la condición de filtrado.
    *
    * @param string tcCondicionFiltro (Opcional) Condición de filtrado válida.
    * @return int Número mayor o igual que cero si la operación es exitosa.
    *             -1 si ocurre un error.
    * @access public
    */
    FUNCTION contar
        LPARAMETERS tcCondicionFiltro
        RETURN -1
    ENDFUNC

    **/
    * Obtiene el siguiente código numérico secuencial disponible.
    *
    * Busca el primer hueco en la secuencia de códigos a partir de 1.
    *
    * @return int Número positivo si la operación es exitosa.
    *             -1 si ocurre un error.
    * @access public
    */
    FUNCTION obtener_nuevo_codigo
        RETURN -1
    ENDFUNC

    **/
    * Obtiene un registro, buscándolo por código.
    *
    * @param int tnCodigo Código del registro a obtener.
    * @return mixed Object modelo si encuentra el registro.
    *               .F. si no lo encuentra u ocurre un error.
    * @access public
    */
    FUNCTION obtener_por_codigo
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/
    * Obtiene un registro, buscándolo por nombre.
    *
    * @param string tcNombre Nombre del registro a obtener.
    * @return mixed Object modelo si encuentra el registro,
    *               .F. si no lo encuentra u ocurre un error.
    * @access public
    */
    FUNCTION obtener_por_nombre
        LPARAMETERS tcNombre
        RETURN .F.
    ENDFUNC

    **/
    * Obtiene una colección de registros en un cursor temporal.
    *
    * Ejecuta una consulta SELECT sobre la tabla y deja el resultado en un
    * cursor llamado 'tm_' + THIS.cModelo
    *
    * @param string tcCondicionFiltro (Opcional) La cláusula WHERE de la
    *                                            consulta.
    * @param string tcOrden (Opcional) La cláusula ORDER BY de la consulta.
    * @return bool .T. si la operación fue exitosa.
    *              .F. si ocurre un error.
    * @access public
    */
    FUNCTION obtener_todos
        LPARAMETERS tcCondicionFiltro, tcOrden
        RETURN .F.
    ENDFUNC

    **/
    * Obtiene el último mensaje de error registrado.
    *
    * @return string Descripción del mensaje de error.
    * @access public
    */
    FUNCTION obtener_ultimo_error
        RETURN 'No implementado.'
    ENDFUNC

    **/
    * Agrega un nuevo registro a la tabla.
    *
    * @param object toModelo Modelo con los datos a agregar.
    * @return bool .T. si el agregado fue exitoso.
    *              .F. si ocurre un error.
    * @access public
    */
    FUNCTION agregar
        LPARAMETERS toModelo
        RETURN .F.
    ENDFUNC

    **/
    * Modifica un registro existente en la tabla.
    *
    * @param object toModelo Modelo con los datos a modificar.
    * @return bool .T. si la modificación fue exitosa.
    *              .F. si ocurre un error.
    * @access public
    */
    FUNCTION modificar
        LPARAMETERS toModelo
        RETURN .F.
    ENDFUNC

    **/
    * Borra un registro de la tabla.
    *
    * @param int tnCodigo Código del registro a borrar.
    * @return bool .T. si el borrado fue exitoso.
    *              .F. si ocurre un error.
    * @access public
    */
    FUNCTION borrar
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                            PROTECTED METHODS                            *
    *                            ~~~~~~~~~~~~~~~~~                            *
    * @method bool configurar()                                               *
    * @method mixed obtener_modelo()                                          *
    * @method bool conectar()                                                 *
    * @method bool desconectar()                                              *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **/
    * Configura las propiedades por defecto del DAO.
    *
    * Infiere el nombre del modelo y establece valores predeterminados para las
    * cláusulas SQL si no se han especificado.
    *
    * @return bool .T. si la configuración fue exitosa.
    *              .F. si ocurre un error.
    * @access protected
    */
    PROTECTED FUNCTION configurar
        RETURN .F.
    ENDFUNC

    **/
    * Crea un objeto a partir del registro actual de la tabla.
    *
    * @return mixed Object Instancia de la clase modelo (ej: 'ciudades.prg').
    *              .F. si ocurre un error.
    * @access protected
    */
    PROTECTED FUNCTION obtener_modelo
        RETURN .F.
    ENDFUNC

    **/
    * Establece conexión con la base de datos.
    *
    * @return bool .T. si la conexión fue exitosa.
    *              .F. si ocurre un error.
    * @access protected
    */
    PROTECTED FUNCTION conectar
        RETURN .F.
    ENDFUNC

    **/
    * Cierra la conexión con la base de datos.
    *
    * @return bool .T. (valor por defecto).
    * @access protected
    */
    PROTECTED FUNCTION desconectar
        RETURN .F.
    ENDFUNC
ENDDEFINE
