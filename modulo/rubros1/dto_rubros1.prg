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
* @file dto_rubros1.prg
* @package modulo\rubros1
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dto_rubros1
* @extends biblioteca\dto_base
*/

**/
* Clase de transferencia de datos (DTO) para la entidad 'rubros1'.
*
* Esta clase se utiliza para transportar datos de rubros de artículos entre
* diferentes capas de la aplicación. Hereda de 'dto_base'.
*/
DEFINE CLASS dto_rubros1 AS dto_base OF dto_base.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method mixed campo_obtener(string tcCampo)
    * @method object campo_obtener_todos()
    * @method bool es_igual(object toModelo)
    * @method bool establecer(string tcCampo)
    * @method mixed obtener(string tcCampo)
    */

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool Init()
    * @method bool campo_cargar()
    * @method bool campo_establecer_getter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_getter_todos(bool tlValor)
    * @method bool campo_establecer_setter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_setter_todos(bool tlValor)
    * @method bool campo_establecer_valor(string tcCampo, mixed tvValor)
    * @method bool campo_existe(string tcCampo)
    * @method mixed campo_obtener_valor(string tcCampo)
    */
ENDDEFINE
