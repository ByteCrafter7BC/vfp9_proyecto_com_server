**/
* fabrica_dao_dbf.prg
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

**/
* Clase derivada de la clase abstracta.
* Implementación de la fábrica DAO concreta para base de datos DBF nativa.
*/

DEFINE CLASS fabrica_dao_dbf AS fabrica_dao OF fabrica_dao.prg
    **/
    * @constructor
    *
    * @method Init
    *
    * @purpose Constructor de la clase.
    *
    * @access protected
    *
    * @return {Logical} .T. si éxito, .F. si falla.
    *
    * @description Inicializa la matriz de DAOs y valida la propiedad
    *              protegida cPrefijoDao.
    *
    */
    PROTECTED FUNCTION Init
        IF !fabrica_dao::Init() THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.cPrefijoDao) != 'C' OR EMPTY(THIS.cPrefijoDao) THEN
            IF ATC('fabrica_dao_', THIS.Name) == 0 THEN
                registrar_error('fabrica_dao_dbf', 'Init', ;
                    "Propiedad protegida 'cPrefijoDao': " + NO_BLANCO)
                RETURN .F.
            ENDIF

            THIS.cPrefijoDao = SUBSTR(LOWER(THIS.Name), 9) + '_'
        ENDIF

        IF THIS.cPrefijoDao != 'dao_dbf_' THEN
            registrar_error('fabrica_dao_dbf', 'Init', "El valor '" + ;
                THIS.cPrefijoDao + "' de la propiedad protegida '" + ;
                "cPrefijoDao' es inválido.")
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
