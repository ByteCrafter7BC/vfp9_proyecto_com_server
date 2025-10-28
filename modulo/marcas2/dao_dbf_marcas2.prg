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
* @file dao_dbf_marcas2.prg
* @package modulo\marcas2
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dao_dbf_marcas2
* @extends biblioteca\dao_dbf
* @uses constantes.h
*/

**/
* Clase de acceso a datos (DAO).
*
* Esta clase hereda la funcionalidad b�sica de la clase 'dao_dbf' y la
* especializa para la tabla 'marcas2'. Su prop�sito es manejar las operaciones
* de persistencia (crear, leer, actualizar, borrar) y validaciones espec�ficas
* de esta tabla.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS dao_dbf_marcas2 AS dao_dbf OF dao_dbf.prg
    **/
    * @section M�TODOS P�BLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool existe_nombre(string tcNombre)
    * @method bool esta_vigente(int tnCodigo)
    * @method int contar(string [tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre)
    * @method bool obtener_todos(string [tcCondicionFiltro], string [tcOrden])
    * @method string obtener_ultimo_error()
    * @method bool agregar(object toModelo)
    * @method bool modificar(object toModelo)
    * @method bool borrar(int tnCodigo)
    * -- M�TODO ESPEC�FICO DE ESTA CLASE --
    * @method bool esta_relacionado(int tnCodigo)
    */

    **/
    * Verifica si un c�digo est� relacionado con otros registros de la base
    * de datos.
    *
    * @param int tnCodigo C�digo num�rico �nico a verificar.
    * @return bool .T. si el registro est� relacionado o si ocurre un error;
    *              .F. si no est� relacionado.
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es num�rico y se encuentra dentro de un
    *       rango espec�fico.
    * @uses bool dao_existe_referencia(string tcModelo, ;
                                       string tcCondicionFiltro)
    *       Para verificar la existencia de registros referenciales en una
    *       tabla.
    * @uses string cUltimoError Almacena el �ltimo mensaje de error ocurrido.
    * @override
    */
    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo

        IF PARAMETERS() != 1 THEN
            THIS.cUltimoError = MSG_ERROR_NUMERO_ARGUMENTOS
            RETURN .T.
        ENDIF

        IF !es_numero(tnCodigo) THEN
            THIS.cUltimoError = STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCodigo')
            RETURN .T.
        ENDIF

        LOCAL lcCondicionFiltro, llRelacionado
        lcCondicionFiltro = 'marca == ' + ALLTRIM(STR(tnCodigo))

        IF !llRelacionado THEN    && Modelos.
            llRelacionado = dao_existe_referencia('modelos', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN    && �rdenes de trabajo.
            llRelacionado = dao_existe_referencia('ot', lcCondicionFiltro)
        ENDIF

        IF !llRelacionado THEN
            THIS.cUltimoError = ''
        ENDIF

        RETURN llRelacionado
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool Init()
    * @method bool configurar()
    * @method mixed obtener_modelo()
    * @method bool conectar(bool [tlModoEscritura])
    * @method bool desconectar()
    */
ENDDEFINE
