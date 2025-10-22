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
* @file fabrica_dao_dbf.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class fabrica_dao_dbf
* @extends fabrica_dao
*/

**/
* Clase que implementa la Fábrica (Factory) para crear objetos DAO (Data Access
* Object) específicos para bases de datos de tipo DBF.
*
* Extiende de la clase abstracta 'fabrica_dao' y se especializa en la creación
* de objetos DAO que interactúan con archivos DBF.
*/
DEFINE CLASS fabrica_dao_dbf AS fabrica_dao OF fabrica_dao.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method mixed obtener(string tcModelo)
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
    * @method mixed obtener_fabrica_dao(int tnCualFabrica)
    */

    **/
    * Devuelve la instancia de la fábrica DAO específica para un tipo de base
    * de datos.
    *
    * @param int tnCualFabrica Constante que identifica el tipo de base de
    *                          datos, ejemplos:
    *                          BD_DBF       = 1 (Base de datos DBF nativa).
    *                          BD_FIREBIRD  = 2 (Base de datos Firebird).
    *                          BD_MYSQL     = 3 (Base de datos MySQL).
    *                          BD_POSTGRES  = 4 (Base de datos PostgreSQL).
    * @return mixed object Instancia de la clase fábrica DAO específica;
    *               .F. si el parámetro es inválido o si la instancia no se
    *               pudo crear.
    * @override
    */
    FUNCTION obtener_fabrica_dao
        LPARAMETERS tnCualFabrica
        RETURN .F.
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method mixed crear(string tcModelo)
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
    * @method bool Init()
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa la clase y valida que el prefijo del DAO sea el correcto para
    * los objetos DBF.
    *
    * @return bool .T. si la inicialización y validación se completaron
    *              correctamente;
    *              .F. si la inicialización de la clase padre falla o si el
    *              prefijo 'cPrefijoDao' es inválido.
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
                "cPrefijoDao' es inválido.")
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
