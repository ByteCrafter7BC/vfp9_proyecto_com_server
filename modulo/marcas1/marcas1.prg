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
    * @section M�TODOS P�BLICOS
    * @method bool Init(int tnCodigo, string tcNombre, bool tlVigente)
    * @method mixed obtener(string tcCampo)
    * @method bool establecer(string tcCampo)
    * @method bool es_igual(object toModelo)
    */

    **/
    * @section M�TODOS PROTEGIDOS
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
