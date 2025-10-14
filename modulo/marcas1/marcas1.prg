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
* @file marcas1.prg
* @package modulo\marcas1
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class marcas1
* @extends biblioteca\modelo_base
*/

**
* Clase modelo de datos para la entidad 'marcas1'.
*/
DEFINE CLASS marcas1 AS modelo_base OF modelo_base.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnCodigo, string tcNombre, bool tlVigente)
    * @method mixed obtener(string tcCampo)
    * @method bool establecer(string tcCampo)
    * @method bool es_igual(object toModelo)
    */

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool cargar_campos()
    * @method bool cargar_campos_base()
    * @method bool agregar_campo(string tcCampo, string tcTipo, int tnAncho, ;
                                 int tnDecimales, string tcEtiqueta)
    * @method bool existe_campo(string tcCampo)
    * @method int posicion_campo(string tcCampo)
    * @method bool establecer_campo_sin_signo(string tcCampo, bool tlValor)
    * @method bool establecer_campo_requerido(string tcCampo, bool tlValor)
    * @method bool establecer_campo_getter(string tcCampo, bool tlValor)
    * @method bool establecer_campo_setter(string tcCampo, bool tlValor)
    * @method bool establecer_campo_getter_todos(bool tlValor)
    * @method bool establecer_campo_setter_todos(bool tlValor)
    * @method bool establecer_campo_valor(string tcCampo, mixed tvValor)
    * @method mixed obtener_campo_valor(string tcCampo)
    * @method mixed obtener_campo(string tcCampo)
    */
ENDDEFINE
