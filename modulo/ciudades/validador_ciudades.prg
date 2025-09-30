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
* @file validador_ciudades.prg
* @package modulo\ciudades
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class validador_ciudades
* @extends biblioteca\validador_base
* @uses constantes.h
*/

**
* Clase de validación para el modelo 'ciudades'.
*
* Hereda de la clase 'validador_base' y añade dos propiedades numéricas
* específicas: 'departamen' y 'sifen'.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS validador_ciudades AS validador_base OF validador_base.prg
    **/
    * @var string Mensaje de error para la propiedad 'departamen'.
    */
    PROTECTED cErrorDepartamen

    **/
    * @var string Mensaje de error para la propiedad 'sifen'.
    */
    PROTECTED cErrorSifen

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method string obtener_error_codigo()
    * @method string obtener_error_nombre()
    * @method string obtener_error_vigente()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool es_valido()
    * @method string obtener_error_departamen()
    * @method string obtener_error_sifen()
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
                    OR !EMPTY(THIS.cErrorDepartamen) ;
                    OR !EMPTY(THIS.cErrorSifen) ;
                    OR !EMPTY(THIS.cErrorVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN !THIS.oDao.esta_relacionado(THIS.oModelo.obtener_codigo())
        ENDIF
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'departamen',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_departamen
        RETURN IIF(VARTYPE(THIS.cErrorDepartamen) == 'C', ;
            THIS.cErrorDepartamen, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'sifen',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_sifen
        RETURN IIF(VARTYPE(THIS.cErrorSifen) == 'C', THIS.cErrorSifen, '')
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
    * validaciones específicas para las propiedades 'departamen' y 'sifen'.
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
            .cErrorDepartamen = .validar_departamen()
            .cErrorSifen = .validar_sifen()
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
    * Valida la propiedad 'departamen' del modelo.
    *
    * @return string Si la propiedad es válida, devuelve una cadena vacía;
    *                de lo contrario, devuelve un mensaje de error.
    */
    PROTECTED FUNCTION validar_departamen
        LOCAL lcEtiqueta, lnDepartamen, loModelo
        lcEtiqueta = 'Departamento: '

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        lnDepartamen = THIS.oModelo.obtener_departamen()

        IF lnDepartamen <= 0 THEN
            RETURN lcEtiqueta + MSG_MAYOR_QUE_CERO
        ENDIF

        IF lnDepartamen > 999 THEN
            RETURN lcEtiqueta + STRTRAN(MSG_MENOR_QUE, '{}', ;
                ALLTRIM(STR(999 + 1)))
        ENDIF

        loModelo = dao_obtener_por_codigo('depar', lnDepartamen)

        IF VARTYPE(loModelo) != 'O' THEN
            RETURN lcEtiqueta + ;
                STRTRAN(MSG_NO_EXISTE, '{}', ALLTRIM(STR(lnDepartamen)))
        ENDIF

        IF !loModelo.esta_vigente() THEN
            RETURN lcEtiqueta + ;
                STRTRAN(MSG_NO_VIGENTE, '{}', ALLTRIM(STR(lnDepartamen)))
        ENDIF

        loModelo = THIS.oDao.obtener_por_nombre(lcNombre, lnDepartamen)

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

    **/
    * Valida la propiedad 'sifen' del modelo.
    *
    * @return string Si la propiedad es válida, devuelve una cadena vacía;
    *                de lo contrario, devuelve un mensaje de error.
    */
    PROTECTED FUNCTION validar_sifen
        LOCAL lcEtiqueta, lnSifen, loModelo
        lcEtiqueta = 'Sifen: '

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        IF !EMPTY(THIS.cErrorDepartamen) THEN
            RETURN THIS.cErrorDepartamen
        ENDIF

        lnSifen = THIS.oModelo.obtener_sifen()

        IF lnSifen <= 0 THEN
            RETURN lcEtiqueta + MSG_MAYOR_QUE_CERO
        ENDIF

        IF lnSifen > 99999 THEN
            RETURN lcEtiqueta + ;
                STRTRAN(MSG_MENOR_QUE, '{}', ALLTRIM(STR(99999 + 1)))
        ENDIF

        loModelo = ;
            NEWOBJECT('sifen_ciudades', 'sifen_ciudades.prg', '', lnSifen)

        IF VARTYPE(loModelo) != 'O' THEN
            RETURN lcEtiqueta + STRTRAN(MSG_NO_EXISTE, '{}', ;
                ALLTRIM(STR(lnSifen)))
        ENDIF

        loModelo = THIS.oDao.obtener_por_sifen(lnSifen)

        IF THIS.nBandera == 1 THEN    && Agregar
            IF VARTYPE(loModelo) == 'O' THEN
                RETURN lcEtiqueta + MSG_YA_EXISTE
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF VARTYPE(loModelo) == 'O' ;
                        AND loModelo.obtener_codigo() != ;
                            THIS.oModelo.obtener_codigo() THEN
                    RETURN lcEtiqueta + MSG_YA_EXISTE
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
