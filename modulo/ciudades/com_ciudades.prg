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
* @file com_ciudades.prg
* @package modulo\com_ciudades
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class com_ciudades
* @extends biblioteca\com_base
*/

**/
* Componente COM para la gestión de ciudades.
*
* Esta clase actúa como un controlador o una capa de servicio (business object)
* para la entidad 'ciudades'. Se expone como un objeto COM para ser utilizado
* por otras aplicaciones.
*/
DEFINE CLASS com_ciudades AS com_base OF com_base.prg OLEPUBLIC
    **/
    * @var string Nombre de la clase modelo asociado a este componente.
    */
    cModelo = 'ciudades'

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool esta_vigente(int tnCodigo)
    * @method bool esta_relacionado(int tnCodigo)
    * @method int contar([string tcCondicionFiltro])
    * @method int obtener_nuevo_codigo()
    * @method mixed obtener_por_codigo(int tnCodigo)
    * @method mixed obtener_por_nombre(string tcNombre)
    * @method string obtener_todos([string tcCondicionFiltro], [string tcOrden])
    * @method mixed obtener_dto()
    * @method string obtener_ultimo_error()
    * @method bool agregar(object toDto)
    * @method bool modificar(object toDto)
    * @method bool borrar(int tnCodigo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool existe_nombre(string tcNombre, int tnDepartamen)
    * @method bool existe_sifen(int tnSifen)
    * @method mixed obtener_por_nombre(string tcNombre, int tnDepartamen)
    * @method mixed obtener_por_sifen(int tnSifen)
    */

    **/
    * Verifica la existencia de una ciudad por su nombre dentro de un
    * departamento específico.
    *
    * @param string tcNombre Nombre de la ciudad a verificar.
    * @param int tnDepartamen Código del departamento.
    * @return bool .T. si el nombre existe o si ocurre un error, o
    *              .F. si el nombre no existe.
    * @override
    */
    FUNCTION existe_nombre(tcNombre AS String, tnDepartamen AS Integer) ;
            AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si existe el nombre u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oDao.existe_nombre(tcNombre, tnDepartamen)
    ENDFUNC

    **/
    * Verifica la existencia de un código del SIFEN.
    *
    * @param int tnSifen Código del SIFEN a verificar.
    * @return bool .T. si el código del SIFEN existe o si ocurre un error, o
    *              .F. si el código del SIFEN no existe.
    */
    FUNCTION existe_sifen(tnSifen AS Integer) AS Logical ;
        HELPSTRING 'Devuelve verdadero (.T.) si el código del SIFEN existe u ocurre un error; de lo contrario, devuelve falso (.F.).'
        RETURN THIS.oDao.existe_sifen(tnSifen)
    ENDFUNC

    **/
    * Realiza la búsqueda de una ciudad por su nombre dentro de un departamento
    * específico.
    *
    * @param string tcNombre Nombre de la ciudad a buscar.
    * @param int tnDepartamen Código del departamento.
    * @return mixed object modelo si la ciudad se encuentra, o
    *               .F. si no se encuentra o si ocurre un error.
    * @override
    */
    FUNCTION obtener_por_nombre(tcNombre AS String, tnDepartamen AS Integer) ;
            AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si existe el nombre; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oDao.obtener_por_nombre(tcNombre, tnDepartamen)
    ENDFUNC

    **/
    * Realiza la búsqueda de una ciudad por su código del SIFEN.
    *
    * @param int tnSifen Código del SIFEN a buscar.
    * @return mixed object modelo si el código del SIFEN se encuentra, o
    *               .F. si no se encuentra o si ocurre un error.
    */
    FUNCTION obtener_por_sifen(tnSifen AS Integer) AS Object ;
        HELPSTRING 'Devuelve un objeto (Object) si el código del SIFEN existe; de lo contrario, devuelve falso (.F.). En caso de error, devuelve falso (.F.).'
        RETURN THIS.oDao.obtener_por_sifen(tnSifen)
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool Init()
    * @method bool configurar()
    * @method void establecer_entorno()
    * @method bool establecer_dao()
    * -- MÉTODO ESPECÍFICO DE ESTA CLASE --
    * @method mixed convertir_dto_a_modelo(object toDto)
    */

    **/
    * Convierte un DTO (Data Transfer Object) a su objeto modelo
    * correspondiente.
    *
    * Extrae los datos de un DTO de tipo 'dto_ciudades' para instanciar
    * y devolver un nuevo objeto del modelo 'ciudades'.
    *
    * @param object toDto DTO (dto_ciudades) que se va a convertir.
    * @return mixed object modelo si la conversión se completa correctamente, o
    *               .F. si el parámetro de entrada no es un objeto válido.
    * @override
    */
    PROTECTED FUNCTION convertir_dto_a_modelo
        LPARAMETERS toDto

        IF VARTYPE(toDto) != 'O' THEN
            RETURN .F.
        ENDIF

        LOCAL lnCodigo, lcNombre, lnDepartamen, lnSifen, llVigente

        WITH toDto
            lnCodigo = .obtener_codigo()
            lcNombre = ALLTRIM(.obtener_nombre())
            lnDepartamen = .obtener_departamen()
            lnSifen = .obtener_sifen()
            llVigente = .esta_vigente()
        ENDWITH

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            lnCodigo, lcNombre, lnDepartamen, lnSifen, llVigente)
    ENDFUNC
ENDDEFINE
