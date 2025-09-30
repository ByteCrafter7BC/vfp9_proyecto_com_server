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
* @file dto_ciudades.prg
* @package modulo\ciudades
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class dto_ciudades
* @extends biblioteca\dto_base
*/

**
* Clase de transferencia de datos (DTO) para la entidad 'ciudades'.
*
* Esta clase se utiliza para transportar datos de ciudades entre diferentes
* capas de la aplicación. Hereda de 'dto_base' y añade propiedades para dos
* parámetros numéricos específicos ('departamen' y 'sifen') con sus
* respectivos getters y setters para validación.
*/
DEFINE CLASS dto_ciudades AS dto_base OF dto_base.prg
    **/
    * @var int Código del departamento.
    */
    PROTECTED nDepartamen

    **/
    * @var int Código SIFEN de la ciudad.
    */
    PROTECTED nSifen

    **/
    * @section MÉTODOS PÚBLICOS
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * @method bool establecer_codigo(int tnCodigo)
    * @method bool establecer_nombre(string tcNombre)
    * @method bool establecer_vigente(bool tlVigente)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool Init(int tnCodigo, string tcNombre, int tnDepartamen, ;
                        int tnSifen, bool tlVigente)
    * @method int obtener_departamen()
    * @method int obtener_sifen()
    * @method bool establecer_departamen(int tnDepartamen)
    * @method bool establecer_sifen(int tnSifen)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa una nueva instancia de la clase 'dto_ciudades'. Si no se
    * proporcionan parámetros, todas las propiedades se inicializan con
    * valores predeterminados (0, '', .F.).
    *
    * @param int [tnCodigo] Código numérico único de la ciudad.
    * @param string [tcNombre] Nombre o descripción de la ciudad.
    * @param int [tnDepartamen] Código del departamento.
    * @param int [tnSifen] Código SIFEN de la ciudad.
    * @param bool [tlVigente] Indica si la ciudad está vigente.
    * @return bool .T. si la inicialización se completa correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnDepartamen, tnSifen, tlVigente

        IF PARAMETERS() != 5 THEN
            tnCodigo = 0
            tcNombre = ''
            tnDepartamen = 0
            tnSifen = 0
            tlVigente = .F.
        ENDIF

        IF !dto_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF !THIS.establecer_departamen(tnDepartamen) ;
                OR !THIS.establecer_sifen(tnSifen) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * @section GETTERS
    */

    **/
    * Devuelve el código del departamento.
    *
    * @return int
    */
    FUNCTION obtener_departamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **/
    * Devuelve el código SIFEN de la ciudad.
    *
    * @return int
    */
    FUNCTION obtener_sifen
        RETURN THIS.nSifen
    ENDFUNC

    **/
    * @section SETTERS
    */

    **/
    * Establece el código del departamento.
    *
    * @param int tnDepartamen
    * @return bool
    */
    FUNCTION establecer_departamen
        LPARAMETERS tnDepartamen

        IF VARTYPE(tnDepartamen) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nDepartamen = tnDepartamen
    ENDFUNC

    **/
    * Establece el código SIFEN de la ciudad.
    *
    * @param int tnSifen
    * @return bool
    */
    FUNCTION establecer_sifen
        LPARAMETERS tnSifen

        IF VARTYPE(tnSifen) != 'N' THEN
            RETURN .F.
        ENDIF

        THIS.nSifen = tnSifen
    ENDFUNC
ENDDEFINE
