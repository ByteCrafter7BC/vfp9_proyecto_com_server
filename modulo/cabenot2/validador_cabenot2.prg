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
* @file validador_cabenot2.prg
* @package modulo\cabenot2
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class validador_cabenot2
* @extends Custom
* @uses constantes.h
*/

**/
* Clase de validación para el modelo 'cabenot2'.
*/
DEFINE CLASS validador_cabenot2 AS Custom
    **/
    * @var string Nombre del modelo que se está validando.
    */
    PROTECTED cModelo

    **/
    * @var int Bandera que indica el tipo de operación a validar.
    * 1 = Agregar, 2 = Modificar y 3 = Borrar.
    */
    PROTECTED nBandera

    **
    * @var object Modelo que contiene los datos a validar.
    */
    PROTECTED oModelo

    **/
    * @var object DAO para la interacción con la base de datos.
    */
    PROTECTED oDao

    **/
    * @var string Mensaje de error para la validación del tipo de documento.
    */
    PROTECTED cErrorTipoNota

    **/
    * @var string Mensaje de error para la validación del número de documento
    */
    PROTECTED cErrorNroNota

    **/
    * @var string Mensaje de error para la validación del CDC.
    */
    PROTECTED cErrorCdc

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method bool es_valido()
    * @method string obtener_error_tiponota()
    * @method string obtener_error_nronota()
    * @method string obtener_error_cdc()
    */

    **/
    * Constructor de la clase validadora.
    *
    * Inicializa la clase con los parámetros necesarios y ejecuta la validación
    * si la bandera indica una operación de Agregar o Modificar.
    *
    * @param int tnBandera Bandera que indica la operación: 1 para Agregar,
    *                      2 para Modificar y 3 para Borrar.
    * @param object toModelo Modelo con los datos a validar.
    * @param object toDao DAO para las consultas de validación.
    *
    * @return bool .T. si la inicialización se completa correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION Init
        LPARAMETERS tnBandera, toModelo, toDao

        IF VARTYPE(tnBandera) != 'N' ;
                OR !BETWEEN(tnBandera, 1, 3) ;
                OR VARTYPE(toModelo) != 'O' ;
                OR VARTYPE(toDao) != 'O' ;
                OR !THIS.configurar() THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nBandera = tnBandera
            .oModelo = toModelo
            .oDao = toDao
        ENDWITH

        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            THIS.validar()
        ENDIF
    ENDFUNC

    **/
    * Verifica si el modelo es válido según el contexto (bandera).
    *
    * - Para banderas 1 y 2 (agregar/modificar), comprueba si existe algún
    *   mensaje de error en las propiedades de la clase.
    * - Para otras banderas (borrar), verifica que el documento no esté
    *   relacionada con otros registros de la base de datos.
    *
    * @return bool .T. si el modelo es válido, o .F. si no lo es.
    */
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            IF !EMPTY(THIS.cErrorTipoNota) ;
                    OR !EMPTY(THIS.cErrorNroNota) ;
                    OR !EMPTY(THIS.cErrorCdc) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN .F.
        ENDIF
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'tiponota',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_tiponota
        RETURN IIF(VARTYPE(THIS.cErrorTipoNota) == 'C', THIS.cErrorTipoNota, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'nronota',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_nronota
        RETURN IIF(VARTYPE(THIS.cErrorNroNota) == 'C', THIS.cErrorNroNota, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'cdc',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_cdc
        RETURN IIF(VARTYPE(THIS.cErrorCdc) == 'C', THIS.cErrorCdc, '')
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool configurar()
    * @method void validar()
    * @method string validar_tiponota()
    * @method string validar_nronota()
    * @method string validar_cdc()
    */

    **/
    * Configura las propiedades de la clase validadora.
    *
    * Si la propiedad 'cModelo' no han sido definida, la establece con un valor
    * predeterminado que deriva del nombre de la clase.
    *
    * @return bool .T. si la configuración se completa correctamente;
    *              .F. en caso contrario.
    */
    PROTECTED FUNCTION configurar
        IF VARTYPE(THIS.cModelo) != 'C' OR EMPTY(THIS.cModelo) THEN
            IF ATC('validador_', THIS.Name) == 0 THEN
                RETURN .F.
            ENDIF

            THIS.cModelo = SUBSTR(LOWER(THIS.Name), 11)
        ENDIF
    ENDFUNC

    **/
    * Ejecuta la validación de todas las propiedades del modelo.
    *
    * Este método es llamado por el constructor ('Init') para las operaciones
    * de Agregar (bandera 1) y Modificar (bandera 2).
    *
    * Almacena los mensajes de error devueltos por los métodos de validación
    * en las propiedades de error de la clase.
    */
    PROTECTED PROCEDURE validar
        WITH THIS
            .cErrorTipoNota = .validar_tiponota()
            .cErrorNroNota = .validar_nronota()
            .cErrorCdc = .validar_cdc()
        ENDWITH
    ENDPROC

    **/
    * Valida el tipo de documento.
    *
    * @return string Mensaje de error si la validación falla;
    *                cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_tiponota
        IF THIS.oModelo.obtener_tiponota() != 2 THEN
            RETURN 'Tipo de documento: Debe ser igual a 2 (nota de crédito).'
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida el número de documento.
    *
    * @return string Mensaje de error si la validación falla;
    *                cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_nronota
        LOCAL lcEtiqueta, lnTipoNota, lnNroNota, loModelo
        lcEtiqueta = 'Número de documento: '

        IF !EMPTY(THIS.cErrorTipoNota) THEN
            RETURN THIS.cErrorTipoNota
        ENDIF

        WITH THIS.oModelo
            lnTipoNota = .obtener_tiponota()
            lnNroNota = .obtener_nronota()
        ENDWITH

        IF lnNroNota <= 0 THEN
            RETURN lcEtiqueta + MSG_MAYOR_QUE_CERO
        ENDIF

        IF lnNroNota > CABENOTC_NRODOCU THEN
            RETURN lcEtiqueta + STRTRAN(MSG_MENOR_QUE, '{}', ;
                ALLTRIM(STR(CABENOTC_NRODOCU + 1)))
        ENDIF

        loModelo = THIS.oDao.obtener_por_nota(lnTipoNota, lnNroNota)

        IF THIS.nBandera == 1 THEN    && Agregar
            IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                RETURN lcEtiqueta + THIS.oDao.obtener_ultimo_error()
            ENDIF

            IF VARTYPE(loModelo) == 'O' THEN
                RETURN lcEtiqueta + MSG_YA_EXISTE
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                    RETURN lcEtiqueta + THIS.oDao.obtener_ultimo_error()
                ENDIF

                IF VARTYPE(loModelo) != 'O' THEN
                    RETURN lcEtiqueta + MSG_NO_EXISTE
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida el CDC del documento.
    *
    * @return string Mensaje de error si la validación falla;
    *                cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_cdc
        LOCAL lcEtiqueta, lnTipoNota, lnNroNota, lcCdc, loModelo
        lcEtiqueta = 'CDC: '

        IF !EMPTY(THIS.cErrorTipoNota) THEN
            RETURN THIS.cErrorTipoNota
        ENDIF

        IF !EMPTY(THIS.cErrorNroNota) THEN
            RETURN THIS.cErrorNroNota
        ENDIF

        WITH THIS.oModelo
            lnTipoNota = .obtener_tiponota()
            lnNroNota = .obtener_nronota()
            lcCdc = .obtener_cdc()
        ENDWITH

        IF EMPTY(lcCdc) THEN
            RETURN lcEtiqueta + MSG_NO_BLANCO
        ENDIF

        IF LEN(lcCdc) != 44 THEN
            RETURN lcEtiqueta + 'Debe tener 44 caracteres de longitud.'
        ENDIF

        IF !es_digito(lcCdc) THEN
            RETURN lcEtiqueta + MSG_SOLO_DIGITOS
        ENDIF

        loModelo = THIS.oDao.obtener_por_cdc(lcCdc)

        IF THIS.nBandera == 1 THEN    && Agregar
            IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                RETURN lcEtiqueta + THIS.oDao.obtener_ultimo_error()
            ENDIF

            IF VARTYPE(loModelo) == 'O' THEN
                RETURN lcEtiqueta + MSG_YA_EXISTE
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                    RETURN lcEtiqueta + THIS.oDao.obtener_ultimo_error()
                ENDIF

                IF VARTYPE(loModelo) == 'O' ;
                        AND (loModelo.obtener_tiponota() != lnTipoNota ;
                        OR loModelo.obtener_nronota() != lnNroNota) THEN
                    RETURN lcEtiqueta + MSG_YA_EXISTE
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
