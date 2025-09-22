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
* @file dao_existe_referencia.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @see crear_dao()
*/

**/
* Verifica la existencia de registros referenciales en una tabla.
*
* Se utiliza para comprobar si existen registros en una tabla que cumplan con
* una condici�n espec�fica, t�picamente antes de intentar borrar un registro
* maestro.
* Por ejemplo, se usa para verificar si existe alguna factura para un cliente
* antes de borrarlo.
*
* La funci�n est� dise�ada de forma defensiva: si los par�metros son inv�lidos o
* si no se puede crear el objeto de acceso a datos, devuelve .T. (verdadero)
* para prevenir un borrado accidental.
*
* @param string tcModelo Nombre o alias de la tabla (modelo) donde se buscar� la
*                        referencia.
* @param string tcCondicionFiltro Condici�n de filtro (cl�usula WHERE) para
*                                 encontrar los registros.
*
* @return bool .T. si encuentra al menos un registro que cumpla la condici�n (o
*              si hay un error).
*              .F. �nicamente si no se encuentra ning�n registro coincidente.
*/
FUNCTION dao_existe_referencia
    LPARAMETERS tcModelo, tcCondicionFiltro

    IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
        RETURN .T.
    ENDIF

    IF VARTYPE(tcCondicionFiltro) != 'C' OR EMPTY(tcCondicionFiltro) THEN
        RETURN .T.
    ENDIF

    LOCAL loDao
    loDao = crear_dao(LOWER(ALLTRIM(tcModelo)))

    IF VARTYPE(loDao) != 'O' THEN
        RETURN .T.
    ENDIF

    RETURN loDao.contar(tcCondicionFiltro) != 0
ENDFUNC
