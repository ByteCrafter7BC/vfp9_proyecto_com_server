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
* @file cobrador.prg
* @package modulo\cobrador
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class cobrador
* @extends biblioteca\modelo_base
*/

**
* Clase modelo de datos para la entidad de cobradores.
*
* Esta clase hereda la estructura de la clase base 'modelo_base', que
* proporciona las propiedades y métodos para manejar datos de código, nombre y
* estado de vigencia.
*
* Su propósito es servir como una representación específica de la tabla de
* cobradores en la capa de modelos. Al heredar de 'modelo_base', asegura
* la consistencia en la estructura de datos y en los métodos de acceso,
* adhiriéndose al estándar definido para la arquitectura de la aplicación.
*/
DEFINE CLASS cobrador AS modelo_base OF modelo_base.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnCodigo, string tcNombre, bool tlVigente)
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool es_igual(object toModelo)
    */
ENDDEFINE
