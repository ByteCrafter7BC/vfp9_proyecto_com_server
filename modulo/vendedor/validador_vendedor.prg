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
* Esta clase hereda la funcionalidad gen�rica de validaci�n de la clase base
* 'validador_base'. Se especializa en la validaci�n de un objeto de modelo
* de tipo 'vendedor'.
*
* Su prop�sito es asegurar que los datos de los vendedores cumplan con las reglas
* de negocio (por ejemplo, unicidad de c�digo y nombre, longitud, etc.) antes
* de ser persistidos en la base de datos. Al heredar de 'validador_base', se
* beneficia de la l�gica de validaci�n predefinida sin necesidad de implementar
* los m�todos desde cero.
*/
DEFINE CLASS validador_vendedor AS validador_base OF validador_base.prg
    **/
    * @section M�TODOS P�BLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method bool es_valido()
    * @method string obtener_error_codigo()
    * @method string obtener_error_nombre()
    * @method string obtener_error_vigente()
    */

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool configurar()
    * @method bool validar()
    * @method string validar_codigo()
    * @method string validar_nombre()
    * @method string validar_vigente()
    */
ENDDEFINE
