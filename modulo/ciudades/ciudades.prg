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
* @file ciudades.prg
* @package modulo\ciudades
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class ciudades
* @extends biblioteca\modelo_base
*/

**
* Clase modelo de datos para la entidad 'ciudades'.
*
* Hereda de la clase 'modelo_base' y a�ade dos propiedades num�ricas
* espec�ficas: 'departamen' y 'sifen'.
*/
DEFINE CLASS ciudades AS modelo_base OF modelo_base.prg
    **/
    * @var int C�digo num�rico del departamento.
    */
    PROTECTED nDepartamen

    **/
    * @var int C�digo num�rico SIFEN de la ciudad.
    */
    PROTECTED nSifen

    **/
    * @section M�TODOS P�BLICOS
    * @method int obtener_codigo()
    * @method string obtener_nombre()
    * @method bool esta_vigente()
    * -- M�TODOS ESPEC�FICOS DE ESTA CLASE --
    * @method bool Init(int tnCodigo, string tcNombre, int tnDepartamen, ;
                        int tnSifen, bool tlVigente)
    * @method int obtener_departamen()
    * @method int obtener_sifen()
    * @method bool es_igual(object toModelo)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa una nueva instancia de la clase 'ciudades'.
    *
    * Adem�s de los par�metros de la clase base, inicializa los dos par�metros
    * num�ricos espec�ficos de esta clase.
    *
    * @param int tnCodigo C�digo num�rico �nico de la ciudad.
    * @param string tcNombre Nombre o descripci�n de la ciudad.
    * @param int tnDepartamen C�digo num�rico del departamento.
    * @param int tnSifen C�digo num�rico SIFEN de la ciudad.
    * @param bool tlVigente Indica si la ciudad est� vigente.
    * @return bool .T. si la inicializaci�n se completa correctamente, o
    *              .F. si ocurre un error.
    * @override
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnDepartamen, tnSifen, tlVigente

        IF !modelo_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnDepartamen) != 'N' ;
                OR VARTYPE(tnSifen) != 'N' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nDepartamen = tnDepartamen
            .nSifen = tnSifen
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el c�digo del departamento.
    *
    * @return int C�digo num�rico del departamento.
    */
    FUNCTION obtener_departamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **/
    * Devuelve el c�digo SIFEN de la ciudad.
    *
    * @return int C�digo num�rico SIFEN de la ciudad.
    */
    FUNCTION obtener_sifen
        RETURN THIS.nSifen
    ENDFUNC

    **/
    * Compara la instancia actual con otro objeto para determinar si son
    * iguales.
    *
    * Compara las propiedades de la clase base y las propiedades espec�ficas
    * ('departamen' y 'sifen') de la clase 'ciudades'.
    *
    * @param object toModelo Objeto de tipo 'ciudades' con el que se comparar�.
    * @return bool .T. si los objetos son iguales, o .F. si no lo son.
    * @override
    */
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF !modelo_base::es_igual(toModelo) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_departamen() != THIS.nDepartamen ;
                OR toModelo.obtener_sifen() != THIS.nSifen THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
