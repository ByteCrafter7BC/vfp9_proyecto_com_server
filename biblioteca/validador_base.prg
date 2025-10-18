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
* @file validador_base.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @abstract
* @class validador_base
* @extends Custom
* @uses constantes.h
*/

**/
* Clase base abstracta para la validación de modelos.
*
* Esta clase implementa la lógica de validación genérica para operaciones de
* Agregar (1), Modificar (2) y Borrar (3) sobre un modelo de datos. La
* validación se realiza en función de tres propiedades principales: código,
* nombre y estado de vigencia.
*
* Está diseñada para ser implementada por clases validadoras específicas para
* cada modelo, proporcionando un marco de trabajo reutilizable y consistente.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS validador_base AS Custom
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
    * @var string Mensaje de error para la validación del código.
    */
    PROTECTED cErrorCodigo

    **/
    * @var string Mensaje de error para la validación del nombre.
    */
    PROTECTED cErrorNombre

    **/
    * @var string Mensaje de error para la validación del estado de vigencia.
    */
    PROTECTED cErrorVigente

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method bool es_valido()
    * @method string obtener_error_codigo()
    * @method string obtener_error_nombre()
    * @method string obtener_error_vigente()
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
    * Verifica si el modelo es válido según la operación (bandera).
    *
    * - Para banderas 1 y 2 (agregar/modificar), comprueba si existe algún
    *   mensaje de error en las propiedades de la clase.
    * - Para otras banderas (borrar), verifica que el registro no esté
    *   relacionada con otros registros de la base de datos antes de permitir
    *   la operación.
    *
    * @return bool .T. si el modelo es válido para la operación.
    */
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            IF !EMPTY(THIS.cErrorCodigo) ;
                    OR !EMPTY(THIS.cErrorNombre) ;
                    OR !EMPTY(THIS.cErrorVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN !THIS.oDao.esta_relacionado(THIS.oModelo.obtener_codigo())
        ENDIF
    ENDFUNC

    **/
    * Obtiene el mensaje de error de la validación del código.
    *
    * @return string Mensaje de error. Cadena vacía si no hay error.
    */
    FUNCTION obtener_error_codigo
        RETURN IIF(VARTYPE(THIS.cErrorCodigo) == 'C', THIS.cErrorCodigo, '')
    ENDFUNC

    **/
    * Obtiene el mensaje de error de la validación del nombre.
    *
    * @return string Mensaje de error. Cadena vacía si no hay error.
    */
    FUNCTION obtener_error_nombre
        RETURN IIF(VARTYPE(THIS.cErrorNombre) == 'C', THIS.cErrorNombre, '')
    ENDFUNC

    **/
    * Obtiene el mensaje de error de la validación de la vigencia.
    *
    * @return string Mensaje de error. Cadena vacía si no hay error.
    */
    FUNCTION obtener_error_vigente
        RETURN IIF(VARTYPE(THIS.cErrorVigente) == 'C', THIS.cErrorVigente, '')
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool configurar()
    * @method void validar()
    * @method string validar_codigo()
    * @method string validar_nombre()
    * @method string validar_vigente()
    */

    **/
    * Configura las propiedades de la clase validadora.
    *
    * Si las propiedades 'cModelo', 'nAnchoCodigo' y 'nAnchoNombre' no han sido
    * definidas, las establece con valores predeterminados y deriva el nombre
    * del modelo del nombre de la clase.
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
            .cErrorCodigo = .validar_codigo()
            .cErrorNombre = .validar_nombre()
            .cErrorVigente = .validar_vigente()
        ENDWITH
    ENDPROC

    **/
    * Valida el código del modelo.
    *
    * @return string Mensaje de error si la validación falla.
    *                Cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_codigo
        LOCAL lcCampo, lcUltimoError, loCampo, lcEtiqueta, lnCodigo, loModelo
        lcCampo = 'codigo'
        lcUltimoError = THIS.campo_obtener_ultimo_error(lcCampo)

        IF !EMPTY(lcUltimoError) THEN
            RETURN lcUltimoError
        ENDIF

        loCampo = THIS.oModelo.campo_obtener(lcCampo)
        lcEtiqueta = loCampo.obtener_etiqueta()
        lnCodigo = loCampo.obtener_valor()
        loModelo = THIS.oDao.obtener_por_codigo(lnCodigo)

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
    * Valida el nombre del modelo.
    *
    * @return string Mensaje de error si la validación falla.
    *                Cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_nombre
        LOCAL lcCampo, lcUltimoError, loCampo, lcEtiqueta, lcNombre, loModelo

        IF !EMPTY(THIS.cErrorCodigo) THEN
            RETURN THIS.cErrorCodigo
        ENDIF

        lcCampo = 'nombre'
        lcUltimoError = THIS.campo_obtener_ultimo_error(lcCampo)

        IF !EMPTY(lcUltimoError) THEN
            RETURN lcUltimoError
        ENDIF

        loCampo = THIS.oModelo.campo_obtener(lcCampo)
        lcEtiqueta = loCampo.obtener_etiqueta()
        lcNombre = loCampo.obtener_valor()
        loModelo = THIS.oDao.obtener_por_nombre(lcNombre)

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
                        AND loModelo.obtener_codigo() != ;
                            THIS.oModelo.obtener_codigo() THEN
                    RETURN lcEtiqueta + MSG_YA_EXISTE
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida la propiedad de vigencia del modelo.
    *
    * @return string Mensaje de error si la validación falla.
    *                Cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_vigente
        RETURN THIS.campo_obtener_ultimo_error('vigente')
    ENDFUNC

    **/
    * Devuelve el último mensaje de error del campo.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @return string Mensaje de error si la validación falla.
    *                Cadena vacía si no hay error.
    */
    PROTECTED FUNCTION campo_obtener_ultimo_error
        LPARAMETERS tcCampo

        IF VARTYPE(tcCampo) != 'C' OR EMPTY(tcCampo) THEN
            RETURN "ERROR: el parámetro 'tcCampo' no es válido."
        ENDIF

        LOCAL loCampo
        loCampo = THIS.oModelo.campo_obtener(tcCampo)

        IF VARTYPE(loCampo) != 'O' THEN
            RETURN STRTRAN(MSG_CAMPO_NO_EXISTE, '{}', tcCampo)
        ENDIF

        IF !loCampo.es_valido() THEN
            RETURN loCampo.obtener_etiqueta() + loCampo.obtener_ultimo_error()
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
