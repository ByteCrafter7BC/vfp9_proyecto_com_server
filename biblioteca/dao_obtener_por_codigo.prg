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
* @file dao_obtener_por_codigo.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @uses constantes.h, crear_dao
*/

**/
* Devuelve un objeto modelo utilizando su código único.
*
* Esta función valida los parámetros, crea la instancia del DAO correspondiente
* (ej: dao_dbf_clientes, dao_mysql_clientes, etc.) y le delega la tarea de
* buscar y devolver el registro como un objeto.
*
* @param string tcModelo Nombre del modelo/tabla a consultar (ej: 'clientes',
*                        'proveedores', etc.).
* @param int tnCodigo Código numérico del registro que se desea obtener.
* @return mixed object modelo si el registro se encuentra;
*               .F. en caso contrario (devuelto por el método del DAO).
* @throws string Mensaje de error si no se pudo instanciar el DAO.
*/
#INCLUDE 'constantes.h'

FUNCTION dao_obtener_por_codigo
    LPARAMETERS tcModelo, tnCodigo

    IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
        RETURN 'ERROR: ' + STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcModelo')
    ENDIF

    tcModelo = LOWER(ALLTRIM(tcModelo))

    IF VARTYPE(tnCodigo) != 'N' OR !BETWEEN(tnCodigo, 1, INT_MAX) THEN
        RETURN 'ERROR: ' + STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCodigo')
    ENDIF

    LOCAL loDao, lcDao
    loDao = crear_dao(tcModelo)

    IF VARTYPE(loDao) != 'O' THEN
        lcDao = obtener_prefijo_dao() + tcModelo
        RETURN 'ERROR: ' + STRTRAN(MSG_ERROR_INSTANCIA_CLASE, '{}', lcDao)
    ENDIF

    RETURN loDao.obtener_por_codigo(tnCodigo)
ENDFUNC

**/
* Determina el prefijo del nombre de la clase DAO según la configuración global.
*
* Lee la constante global BD_ACTUAL para devolver el prefijo correspondiente al
* motor de base de datos en uso. Esta función es clave para el patrón Abstract
* Factory que permite cambiar de motor de BD.
*
* @internal Es una función auxiliar utilizada principalmente por las fábricas
*           de objetos DAO.
* @global int BD_ACTUAL Constante que define el motor de base de datos actual.
* @return string Prefijo del nombre de la clase DAO (ejemplos: 'dao_dbf_',
*                'dao_firebird_', 'dao_mysql_', etc.).
*/
FUNCTION obtener_prefijo_dao
    LOCAL lcDao

    DO CASE
    CASE BD_ACTUAL == BD_DBF
        lcDao = 'dao_dbf_'
    CASE BD_ACTUAL == BD_FIREBIRD
        lcDao = 'dao_firebird_'
    CASE BD_ACTUAL == BD_MYSQL
        lcDao = 'dao_mysql_'
    CASE BD_ACTUAL == BD_POSTGRES
        lcDao = 'dao_postgres_'
    OTHERWISE
        lcDao = 'dao_'
    ENDCASE

    RETURN lcDao
ENDFUNC
