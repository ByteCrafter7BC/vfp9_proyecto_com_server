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
* @file com_familias.prg
* @package modulo\familias
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class com_familias
* @extends biblioteca\com_base
*/

**/
* Componente COM para la gestión de familias de artículos.
*
* Esta clase actúa como un controlador o una capa de servicio (business object)
* para la entidad 'familias'. Se expone como un objeto COM para ser utilizado
* por otras aplicaciones.
*/
DEFINE CLASS com_familias AS com_base OF com_base.prg OLEPUBLIC
    **/
    * @var string Nombre de la clase modelo asociado a este componente.
    */
    cModelo = 'familias'

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool existe_codigo(int tnCodigo)
    * @method bool existe_nombre(string tcNombre)
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
    */

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
    * Convierte un objeto DTO (Data Transfer Object) a su objeto modelo
    * correspondiente.
    *
    * Extrae los datos de un DTO de tipo 'dto_familias' para instanciar
    * y devolver un nuevo objeto del modelo 'familias'.
    *
    * @param object toDto DTO (dto_familias) que se va a convertir.
    * @return mixed Object si la conversión fue completada correctamente.
    *               .F. si el parámetro de entrada no es un objeto válido.
    * @override
    */
    PROTECTED FUNCTION convertir_dto_a_modelo
        LPARAMETERS toDto

        IF VARTYPE(toDto) != 'O' THEN
            RETURN .F.
        ENDIF

        LOCAL lnCodigo, lcNombre, lnP1, lnP2, lnP3, lnP4, lnP5, llVigente

        WITH toDto
            lnCodigo = .obtener_codigo()
            lcNombre = ALLTRIM(.obtener_nombre())
            lnP1 = .obtener_p1()
            lnP2 = .obtener_p2()
            lnP3 = .obtener_p3()
            lnP4 = .obtener_p4()
            lnP5 = .obtener_p5()
            llVigente = .esta_vigente()
        ENDWITH

        RETURN NEWOBJECT(THIS.cModelo, THIS.cModelo + '.prg', '', ;
            lnCodigo, lcNombre, lnP1, lnP2, lnP3, lnP4, lnP5, llVigente)
    ENDFUNC
ENDDEFINE
