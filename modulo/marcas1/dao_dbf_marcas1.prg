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
* @file dao_dbf_marcas1.prg
* @package modulo\marcas1
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dao_dbf_marcas1
* @extends biblioteca\dao_dbf
* @uses constantes.h
*/

**/
* Clase de objeto de acceso a datos (DAO) para la tabla de marcas en formato
* DBF.
*
* Esta clase hereda la funcionalidad b�sica de la clase 'dao_dbf' y la
* especializa para la tabla 'marcas1'. Su prop�sito es manejar las operaciones
* de persistencia (crear, leer, actualizar, borrar) y validaciones espec�ficas
* de esta tabla.
*
* Sobrescribe el m�todo 'esta_relacionado' para verificar si un registro de
* marca est� siendo utilizado en la tabla de productos ('maesprod'), impidiendo
* su eliminaci�n si existen referencias.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf_marcas1 AS dao_dbf OF dao_dbf.prg
    **/
    * @section M�TODOS P�BLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool existe_nombre(string tcNombre)
    * @method bool esta_vigente(int tnCodigo)
    * @method bool esta_relacionado(int tnCodigo) !!
    * @method int contar()
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo()
    * @method mixed obtener_por_nombre()
    * @method bool obtener_todos([string tcCondicionFiltro], [string tcOrden])
    * @method string obtener_ultimo_error()
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    * @method bool borrar(int tnCodigo)
    */

    **
    * Verifica si el c�digo de una marca est� relacionado con otros registros.
    *
    * Este m�todo sobrescribe la funcionalidad de la clase padre para comprobar
    * espec�ficamente si una marca se utiliza en la tabla de productos
    * ('maesprod').
    *
    * @param int tnCodigo C�digo de la marca a verificar.
    *
    * @return bool .T. si el registro est� relacionado o si ocurre un error.
    * @override
    */
    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo

        IF !THIS.tnCodigo_Valid(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        LOCAL llRelacionado, lcCondicionFiltro
        llRelacionado = .F.
        lcCondicionFiltro = 'marca == ' + ALLTRIM(STR(tnCodigo))

        IF !llRelacionado THEN
            llRelacionado = dao_existe_referencia('maesprod', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool configurar()
    * @method mixed obtener_modelo()
    * @method bool conectar([bool tlModoEscritura])
    * @method bool desconectar()
    * @method bool Init()
    * @method string obtener_nombre_referencial(string tcModelo, int tnCodigo)
    * @method bool validar_codigo_referencial(string tcModelo, int tnCodigo)
    * @method bool tnCodigo_Valid(int tnCodigo)
    * @method bool tcNombre_Valid(string tcNombre)
    * @method bool tlVigente_Valid(bool tlVigente)
    * @method bool toModelo_Valid(object toModelo)
    * @method bool tcCondicionFiltro_Valid(string tcCondicionFiltro)
    * @method bool tcOrden_Valid(string tcOrden)
    */
ENDDEFINE
