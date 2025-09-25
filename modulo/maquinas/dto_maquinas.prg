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
* @file dto_maquinas.prg
* @package modulo\maquinas
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dto_maquinas
* @extends biblioteca\dto_base
*/

**/
* Objeto de Transferencia de Datos (DTO) para la tabla de máquinas.
*
* Esta clase hereda la estructura de la clase base 'dto_base', que proporciona
* las propiedades y métodos para manejar datos de código, nombre y estado de
* vigencia.
*
* Su propósito es servir como un DTO especializado para la entidad 'maquinas',
* permitiendo una clara distinción y organización en la capa de transferencia
* de datos sin la necesidad de añadir una lógica adicional. Actúa como un
* contenedor de datos para la transferencia entre las diferentes capas de la
* aplicación.
*/
DEFINE CLASS dto_maquinas AS dto_base OF dto_base.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init([int tnCodigo], [string tcNombre], [bool tlVigente])
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool establecer_codigo(int tnCodigo)
    * @method bool establecer_nombre(string tcNombre)
    * @method bool establecer_vigente(bool tlVigente)
    */
ENDDEFINE
