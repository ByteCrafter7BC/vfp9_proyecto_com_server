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
* @file crea_dao.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @see fabrica_dao, fabrica_dao_dbf
* @uses constantes.h
*/

**/
* Crea una instancia de un DAO (Data Access Object) y lo almacena como una
* propiedad del objeto '_oSCREEN'.
*
* Esta función aplica el patrón de diseño 'Singleton' para garantizar que solo
* exista una instancia del DAO en la aplicación.
*
* @param string tcModelo Nombre del modelo (entidad) para el cual se obtendrá
*                        el objeto DAO.
*
* @return mixed Object Instancia del objeto DAO si la operación fue completada
*               correctamente.
*               .F. si el parámetro es inválido o si ocurre un error al
*               instanciar el objeto.
*/
#INCLUDE 'constantes.h'

FUNCTION crear_dao
    LPARAMETERS tcModelo

    IF VARTYPE(tcModelo) == 'C' AND !EMPTY(tcModelo) THEN
        tcModelo = LOWER(ALLTRIM(tcModelo))
    ELSE
        RETURN .F.
    ENDIF

    IF VARTYPE(_oSCREEN.oDao) != 'O' THEN
        LOCAL loFabricaDao, loDao
        loFabricaDao = NEWOBJECT('fabrica_dao', 'fabrica_dao.prg')

        IF VARTYPE(loFabricaDao) != 'O' THEN
            registrar_error('crear_dao', 'crear_dao', ;
                STRTRAN(MSG_ERROR_INSTANCIA_CLASE, '{}', 'fabrica_dao'))
            RETURN .F.
        ENDIF

        loDao = loFabricaDao.obtener_fabrica_dao(BD_ACTUAL)

        IF VARTYPE(loDao) != 'O' THEN
            registrar_error('crear_dao', 'crear_dao', ;
                "No se pudo obtener la implementación de '" + ;
                obtener_cual_fabrica())
            RETURN .F.
        ENDIF

        ADDPROPERTY(_oSCREEN, 'oDao', loDao)
    ENDIF

    RETURN _oSCREEN.oDao.obtener(tcModelo)
ENDFUNC

**/
* Devuelve el nombre del archivo de la clase de fábrica DAO según la constante
* de la base de datos seleccionada.
*
* @return string Nombre de la clase de fábrica DAO (ejemplo: 'fabrica_dao_dbf').
*                Devuelve 'fabrica_dao_desconocida' si la constante es inválida.
*/
FUNCTION obtener_cual_fabrica
    LOCAL lcFabricaDao

    DO CASE
    CASE BD_CUAL_FABRICA == BD_DBF
        lcFabricaDao = 'fabrica_dao_dbf'
    CASE BD_CUAL_FABRICA == BD_FIREBIRD
        lcFabricaDao = 'fabrica_dao_firebird'
    CASE BD_CUAL_FABRICA == BD_MYSQL
        lcFabricaDao = 'fabrica_dao_mysql'
    CASE BD_CUAL_FABRICA == BD_POSTGRES
        lcFabricaDao = 'fabrica_dao_postgres'
    OTHERWISE
        lcFabricaDao = 'fabrica_dao_desconocida'
    ENDCASE

    RETURN lcFabricaDao
ENDFUNC
