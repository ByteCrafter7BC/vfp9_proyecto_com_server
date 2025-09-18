**/
* fabrica_dao_dbf.prg
*
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
* Clase derivada de la clase abstracta.
* Implementaci�n de la f�brica DAO concreta para base de datos DBF nativa.
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
    * @return {Logical} .T. si �xito, .F. si falla.
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
                "cPrefijoDao' es inv�lido.")
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
