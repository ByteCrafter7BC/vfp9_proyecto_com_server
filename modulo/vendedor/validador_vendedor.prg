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
* @file validador_vendedor.prg
* @package modulo\vendedor
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class validador_vendedor
* @extends biblioteca\validador_base
*/

**
* Clase validadora para la entidad de vendedores.
*
* Esta clase hereda la funcionalidad genérica de validación de la clase base
* 'validador_base'. Se especializa en la validación de un objeto de modelo
* de tipo 'vendedor'.
*
* Su propósito es asegurar que los datos de los vendedores cumplan con las reglas
* de negocio (por ejemplo, unicidad de código y nombre, longitud, etc.) antes
* de ser persistidos en la base de datos. Al heredar de 'validador_base', se
* beneficia de la lógica de validación predefinida sin necesidad de implementar
* los métodos desde cero.
*/
DEFINE CLASS validador_vendedor AS validador_base OF validador_base.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method bool es_valido()
    * @method string obtener_error_codigo()
    * @method string obtener_error_nombre()
    * @method string obtener_error_vigente()
    */

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool configurar()
    * @method bool validar()
    * @method string validar_codigo()
    * @method string validar_nombre()
    * @method string validar_vigente()
    */
ENDDEFINE
