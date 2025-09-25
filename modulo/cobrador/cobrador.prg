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
* proporciona las propiedades y m�todos para manejar datos de c�digo, nombre y
* estado de vigencia.
*
* Su prop�sito es servir como una representaci�n espec�fica de la tabla de
* cobradores en la capa de modelos. Al heredar de 'modelo_base', asegura
* la consistencia en la estructura de datos y en los m�todos de acceso,
* adhiri�ndose al est�ndar definido para la arquitectura de la aplicaci�n.
*/
DEFINE CLASS cobrador AS modelo_base OF modelo_base.prg
    **/
    * @section M�TODOS P�BLICOS
    * @method bool Init(int tnCodigo, string tcNombre, bool tlVigente)
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool es_igual(object toModelo)
    */
ENDDEFINE
