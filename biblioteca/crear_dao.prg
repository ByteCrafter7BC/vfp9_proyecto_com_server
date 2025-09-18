**/
* crear_dao.prg
*
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
                STRTRAN(ERROR_INSTANCIA_CLASE, '{}', 'fabrica_dao'))
            RETURN .F.
        ENDIF

        loDao = loFabricaDao.obtener_fabrica_dao(BD_CUAL_FABRICA)

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

**------------------------------------------------------------------------------
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
