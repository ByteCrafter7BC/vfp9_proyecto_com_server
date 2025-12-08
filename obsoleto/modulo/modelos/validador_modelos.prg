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
* @file validador_modelos.prg
* @package modulo\modelos
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class validador_modelos
* @extends biblioteca\validador_base
* @uses constantes.h
*/

**
* Clase de validación para el modelo 'modelos'.
*
* Hereda de la clase 'validador_base' y añade dos propiedades numéricas
* específicas: 'maquina' y 'marca'.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS validador_modelos AS validador_base OF validador_base.prg
    **/
    * @var string Mensaje de error para la propiedad 'maquina'.
    */
    PROTECTED cErrorMaquina

    **/
    * @var string Mensaje de error para la propiedad 'marca'.
    */
    PROTECTED cErrorMarca

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method string obtener_error_codigo()
    * @method string obtener_error_nombre()
    * @method string obtener_error_vigente()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool es_valido()
    * @method string obtener_error_maquina()
    * @method string obtener_error_marca()
    */

    **/
    * Verifica si el modelo es válido según el contexto (bandera).
    *
    * - Para banderas 1 y 2 (agregar/modificar), comprueba si existe algún
    *   mensaje de error en las propiedades de la clase.
    * - Para otras banderas (borrar), verifica que el modelo no esté
    *   relacionada con otros registros de la base de datos.
    *
    * @return bool .T. si el modelo es válido, o .F. si no lo es.
    * @override
    */
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            IF !EMPTY(THIS.cErrorCodigo) ;
                    OR !EMPTY(THIS.cErrorNombre) ;
                    OR !EMPTY(THIS.cErrorMaquina) ;
                    OR !EMPTY(THIS.cErrorMarca) ;
                    OR !EMPTY(THIS.cErrorVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN !THIS.oDao.esta_relacionado(THIS.oModelo.obtener_codigo())
        ENDIF
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'maquina',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_maquina
        RETURN IIF(VARTYPE(THIS.cErrorMaquina) == 'C', THIS.cErrorMaquina, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'marca',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_marca
        RETURN IIF(VARTYPE(THIS.cErrorMarca) == 'C', THIS.cErrorMarca, '')
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool configurar()
    * @method string validar_codigo()
    * @method string validar_vigente()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method void validar()
    * @method string validar_nombre()
    * @method string validar_maquina()
    * @method string validar_marca()
    */

    **
    * Ejecuta todas las reglas de validación para el modelo.
    *
    * Llama al método de validación de la clase base y luego ejecuta las
    * validaciones específicas para las propiedades 'maquina' y 'marca'.
    *
    * Este método es invocado por el constructor ('Init') para las operaciones
    * de agregar (bandera 1) y modificar (bandera 2).
    *
    * Almacena los mensajes de error devueltos por los métodos de validación
    * en las propiedades de error de la clase.
    *
    * @override
    */
    PROTECTED FUNCTION validar
        validador_base::validar()

        WITH THIS
            .cErrorMaquina = .validar_maquina()
            .cErrorMarca = .validar_marca()
        ENDWITH
    ENDFUNC

    **/
    * Valida la propiedad 'nombre' del modelo.
    *
    * @return string Si la propiedad es válida, devuelve una cadena vacía;
    *                de lo contrario, devuelve un mensaje de error.
    * @override
    */
    PROTECTED FUNCTION validar_nombre
        LOCAL lcEtiqueta, lcNombre, loModelo
        lcEtiqueta = 'Nombre: '
        lcNombre = THIS.oModelo.obtener_nombre()

        IF EMPTY(lcNombre) THEN
            RETURN lcEtiqueta + MSG_NO_BLANCO
        ENDIF

        IF LEN(lcNombre) > THIS.nAnchoNombre THEN
            RETURN lcEtiqueta + ;
                STRTRAN(MSG_LONGITUD_MAXIMA, '{}', ;
                ALLTRIM(STR(THIS.nAnchoNombre)))
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida la propiedad 'maquina' del modelo.
    *
    * @return string Si la propiedad es válida, devuelve una cadena vacía;
    *                de lo contrario, devuelve un mensaje de error.
    */
    PROTECTED FUNCTION validar_maquina
        LOCAL lcEtiqueta, lnMaquina, loModelo
        lcEtiqueta = 'Máquina: '

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        lnMaquina = THIS.oModelo.obtener_maquina()

        IF lnMaquina < 0 THEN
            RETURN lcEtiqueta + MSG_MAYOR_O_IGUAL_A_CERO
        ENDIF

        IF lnMaquina > 9999 THEN
            RETURN lcEtiqueta + STRTRAN(MSG_MENOR_QUE, '{}', ;
                ALLTRIM(STR(9999 + 1)))
        ENDIF

        IF lnMaquina > 0 THEN
            loModelo = dao_obtener_por_codigo('maquinas', lnMaquina)

            IF VARTYPE(loModelo) != 'O' THEN
                RETURN lcEtiqueta + ;
                    STRTRAN(MSG_NO_EXISTE, '{}', ALLTRIM(STR(lnMaquina)))
            ENDIF

            IF !loModelo.esta_vigente() THEN
                RETURN lcEtiqueta + ;
                    STRTRAN(MSG_NO_VIGENTE, '{}', ALLTRIM(STR(lnMaquina)))
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida la propiedad 'marca' del modelo.
    *
    * @return string Si la propiedad es válida, devuelve una cadena vacía;
    *                de lo contrario, devuelve un mensaje de error.
    */
    PROTECTED FUNCTION validar_marca
        LOCAL lcEtiqueta, lcNombre, lnMaquina, lnMarca, loModelo
        lcEtiqueta = 'Marca: '

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        IF !EMPTY(THIS.cErrorMaquina) THEN
            RETURN THIS.cErrorMaquina
        ENDIF

        WITH THIS.oModelo
            lcNombre = .obtener_nombre()
            lnMaquina = .obtener_maquina()
            lnMarca = .obtener_marca()
        ENDWITH

        IF lnMarca < 0 THEN
            RETURN lcEtiqueta + MSG_MAYOR_O_IGUAL_A_CERO
        ENDIF

        IF lnMarca > 9999 THEN
            RETURN lcEtiqueta + STRTRAN(MSG_MENOR_QUE, '{}', ;
                ALLTRIM(STR(9999 + 1)))
        ENDIF

        IF lnMarca > 0 THEN
            loModelo = dao_obtener_por_codigo('marcas2', lnMarca)

            IF VARTYPE(loModelo) != 'O' THEN
                RETURN lcEtiqueta + ;
                    STRTRAN(MSG_NO_EXISTE, '{}', ALLTRIM(STR(lnMarca)))
            ENDIF

            IF !loModelo.esta_vigente() THEN
                RETURN lcEtiqueta + ;
                    STRTRAN(MSG_NO_VIGENTE, '{}', ALLTRIM(STR(lnMarca)))
            ENDIF
        ENDIF

        loModelo = THIS.oDao.obtener_por_nombre(lcNombre, lnMaquina, lnMarca)

        IF THIS.nBandera == 1 THEN    && Agregar
            IF VARTYPE(loModelo) == 'O' THEN
                RETURN 'Nombre: ' + MSG_YA_EXISTE
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF VARTYPE(loModelo) == 'O' ;
                        AND loModelo.obtener_codigo() != ;
                            THIS.oModelo.obtener_codigo() THEN
                    RETURN 'Nombre: ' + MSG_YA_EXISTE
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
