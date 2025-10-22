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
* @file fabrica_dao_dbf.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class fabrica_dao_dbf
* @extends fabrica_dao
*/

**/
* Clase que implementa la F�brica (Factory) para crear objetos DAO (Data Access
* Object) espec�ficos para bases de datos de tipo DBF.
*
* Extiende de la clase abstracta 'fabrica_dao' y se especializa en la creaci�n
* de objetos DAO que interact�an con archivos DBF.
*/
DEFINE CLASS fabrica_dao_dbf AS fabrica_dao OF fabrica_dao.prg
    **/
    * @section M�TODOS P�BLICOS
    * @method mixed obtener(string tcModelo)
    * -- M�TODO ESPEC�FICO DE ESTA CLASE --
    * @method mixed obtener_fabrica_dao(int tnCualFabrica)
    */

    **/
    * Devuelve la instancia de la f�brica DAO espec�fica para un tipo de base
    * de datos.
    *
    * @param int tnCualFabrica Constante que identifica el tipo de base de
    *                          datos, ejemplos:
    *                          BD_DBF       = 1 (Base de datos DBF nativa).
    *                          BD_FIREBIRD  = 2 (Base de datos Firebird).
    *                          BD_MYSQL     = 3 (Base de datos MySQL).
    *                          BD_POSTGRES  = 4 (Base de datos PostgreSQL).
    * @return mixed object Instancia de la clase f�brica DAO espec�fica;
    *               .F. si el par�metro es inv�lido o si la instancia no se
    *               pudo crear.
    * @override
    */
    FUNCTION obtener_fabrica_dao
        LPARAMETERS tnCualFabrica
        RETURN .F.
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
    * @method mixed crear(string tcModelo)
    * -- M�TODO ESPEC�FICO DE ESTA CLASE --
    * @method bool Init()
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa la clase y valida que el prefijo del DAO sea el correcto para
    * los objetos DBF.
    *
    * @return bool .T. si la inicializaci�n y validaci�n se completaron
    *              correctamente;
    *              .F. si la inicializaci�n de la clase padre falla o si el
    *              prefijo 'cPrefijoDao' es inv�lido.
    * @override
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
