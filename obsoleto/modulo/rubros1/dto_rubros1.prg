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
* @file dto_rubros1.prg
* @package modulo\rubros1
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dto_rubros1
* @extends biblioteca\dto_base
*/

**
* Clase de transferencia de datos (DTO) para la entidad 'rubros1'.
*
* Esta clase se utiliza para transportar datos de rubros de art�culos entre
* diferentes capas de la aplicaci�n. Hereda de 'dto_base'.
*/
DEFINE CLASS dto_rubros1 AS dto_base OF dto_base.prg
    **/
    * @section M�TODOS P�BLICOS
    * @method bool Init([int tnCodigo], [string tcNombre], [bool tlVigente])
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool establecer_codigo(int tnCodigo)
    * @method bool establecer_nombre(string tcNombre)
    * @method bool establecer_vigente(bool tlVigente)
    */
ENDDEFINE
