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
* @file proveedo.prg
* @package modulo\proveedo
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class proveedo
* @extends biblioteca\modelo_base
*/

**/
* Clase modelo de datos para la entidad 'proveedo'.
*/
DEFINE CLASS proveedo AS modelo_base OF modelo_base.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method mixed campo_obtener(string tcCampo)
    * @method object campo_obtener_todos()
    * @method bool es_igual(object toModelo)
    * @method bool establecer(string tcCampo)
    * @method mixed obtener(string tcCampo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool Init(object toDto)
    */

    **/
    * Clase modelo de datos para la entidad 'proveedo'.
    *
    * @param object toDto DTO con los datos a asignar.
    * @return bool .T. si la inicialización se completa correctamente;
    *              .F. en caso contrario.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses bool campo_cargar()
    *       Para cargar los campos a la propiedad protegida 'oCampos'.
    * @uses bool copiar_datos(object toDto)
    *       Para copiar los datos del DTO al modelo.
    * @override
    */
    FUNCTION Init
        LPARAMETERS toDto

        IF PARAMETERS() != 1 ;
                OR !es_objeto(toDto) ;
                OR !THIS.campo_cargar() ;
                OR !THIS.copiar_datos(toDto) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool campo_cargar()
    * @method bool campo_establecer_getter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_getter_todos(bool tlValor)
    * @method bool campo_establecer_setter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_setter_todos(bool tlValor)
    * @method bool campo_establecer_valor(string tcCampo, mixed tvValor)
    * @method bool campo_existe(string tcCampo)
    * @method mixed campo_obtener_valor(string tcCampo)
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool copiar_datos(object toDto)
    */

    **/
    * Copia los datos del DTO al modelo.
    *
    * @param object toDto DTO con los datos a asignar.
    * @return bool .T. si se copian los datos correctamente;
    *              .F. en caso contrario.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses bool campo_establecer_valor(string tcCampo, mixed tvValor)
    *       Para establecer el valor de un campo.
    */
    PROTECTED FUNCTION copiar_datos
        LPARAMETERS toDto

        IF PARAMETERS() != 1 OR !es_objeto(toDto) THEN
            RETURN .F.
        ENDIF

        LOCAL loCampos, loCampo
        loCampos = toDto.campo_obtener_todos()

        IF !es_objeto(loCampos) OR loCampos.Count == 0 THEN
            RETURN .F.
        ENDIF

        FOR EACH loCampo IN loCampos
            IF !THIS.campo_establecer_valor(loCampo.obtener_nombre(), ;
                    loCampo.obtener_valor()) THEN
                RETURN .F.
            ENDIF
        ENDFOR
    ENDFUNC
ENDDEFINE
