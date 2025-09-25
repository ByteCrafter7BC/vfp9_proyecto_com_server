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
* @file dto_maquinas.prg
* @package modulo\maquinas
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dto_maquinas
* @extends biblioteca\dto_base
*/

**/
* Objeto de Transferencia de Datos (DTO) para la tabla de m�quinas.
*
* Esta clase hereda la estructura de la clase base 'dto_base', que proporciona
* las propiedades y m�todos para manejar datos de c�digo, nombre y estado de
* vigencia.
*
* Su prop�sito es servir como un DTO especializado para la entidad 'maquinas',
* permitiendo una clara distinci�n y organizaci�n en la capa de transferencia
* de datos sin la necesidad de a�adir una l�gica adicional. Act�a como un
* contenedor de datos para la transferencia entre las diferentes capas de la
* aplicaci�n.
*/
DEFINE CLASS dto_maquinas AS dto_base OF dto_base.prg
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
