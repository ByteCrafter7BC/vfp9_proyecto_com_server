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
* @file com_marcas1.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class com_marcas1
* @extends com_base
*/

**/
* Clase de l�gica de negocio para la gesti�n de marcas.
*
* Esta clase hereda la funcionalidad b�sica de la capa COM para la interacci�n
* con los datos y la l�gica de negocio.
*
* Su prop�sito principal es especializar la clase 'com_base' para manejar las
* operaciones del modelo 'marcas1' sin necesidad de reescribir la l�gica
* gen�rica. Al establecer la propiedad 'cModelo', la clase padre 'com_base'
* se encarga de instanciar el objeto DAO y DTO correspondientes.
*/
DEFINE CLASS com_marcas1 AS com_base OF com_base.prg OLEPUBLIC
    **/
    * @var string Nombre del modelo de datos asociado a la clase.
    */
    cModelo = 'marcas1'

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
    * @section M�TODOS PROTEGIDOS
    * @method bool Init()
    * @method bool configurar()
    * @method bool establecer_entorno()
    * @method bool establecer_dao()
    * @method mixed convertir_dto_a_modelo(object toDto)
    */
ENDDEFINE
