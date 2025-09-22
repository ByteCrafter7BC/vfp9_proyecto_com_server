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
* una condición específica, típicamente antes de intentar borrar un registro
* maestro.
* Por ejemplo, se usa para verificar si existe alguna factura para un cliente
* antes de borrarlo.
*
* La función está diseñada de forma defensiva: si los parámetros son inválidos o
* si no se puede crear el objeto de acceso a datos, devuelve .T. (verdadero)
* para prevenir un borrado accidental.
*
* @param string tcModelo Nombre o alias de la tabla (modelo) donde se buscará la
*                        referencia.
* @param string tcCondicionFiltro Condición de filtro (cláusula WHERE) para
*                                 encontrar los registros.
*
* @return bool .T. si encuentra al menos un registro que cumpla la condición (o
*              si hay un error).
*              .F. únicamente si no se encuentra ningún registro coincidente.
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
