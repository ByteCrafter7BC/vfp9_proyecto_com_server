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
* Clase base abstracta para la validaci�n de modelos.
*
* Esta clase implementa la l�gica de validaci�n gen�rica para operaciones de
* Agregar (1), Modificar (2) y Borrar (3) sobre un modelo de datos. La
* validaci�n se realiza en funci�n de tres propiedades principales: c�digo,
* nombre y estado de vigencia.
*
* Est� dise�ada para ser implementada por clases validadoras espec�ficas para
* cada modelo, proporcionando un marco de trabajo reutilizable y consistente.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS validador_base AS Custom
    **/
    * @var string Nombre del modelo que se est� validando.
    */
    PROTECTED cModelo

    **/
    * @var int Ancho del campo 'codigo' de la tabla asociada al modelo.
    */
    PROTECTED nAnchoCodigo

    **/
    * @var int Ancho del campo 'nombre' de la tabla asociada al modelo.
    */
    PROTECTED nAnchoNombre

    **/
    * @var int Bandera que indica el tipo de operaci�n a validar.
    * 1 = Agregar, 2 = Modificar y 3 = Borrar.
    */
    PROTECTED nBandera

    **
    * @var object Modelo que contiene los datos a validar.
    */
    PROTECTED oModelo

    **/
    * @var object DAO para la interacci�n con la base de datos.
    */
    PROTECTED oDao

    **/
    * @var string Mensaje de error para la validaci�n del c�digo.
    */
    PROTECTED cErrorCodigo

    **/
    * @var string Mensaje de error para la validaci�n del nombre.
    */
    PROTECTED cErrorNombre

    **/
    * @var string Mensaje de error para la validaci�n del estado de vigencia.
    */
    PROTECTED cErrorVigente

    **/
    * @section M�TODOS P�BLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method bool es_valido()
    * @method string obtener_error_codigo()
    * @method string obtener_error_nombre()
    * @method string obtener_error_vigente()
    */

    **/
    * Constructor de la clase validadora.
    *
    * Inicializa la clase con los par�metros necesarios y ejecuta la validaci�n
    * si la bandera indica una operaci�n de Agregar o Modificar.
    *
    * @param int tnBandera Bandera que indica la operaci�n: 1 para Agregar,
    *                      2 para Modificar y 3 para Borrar.
    * @param object toModelo Modelo con los datos a validar.
    * @param object toDao DAO para las consultas de validaci�n.
    *
    * @return bool .T. si la inicializaci�n fue completada correctamente.
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
    * Determina si el modelo es v�lido seg�n la operaci�n.
    *
    * Para las operaciones de Agregar o Modificar (banderas 1 y 2), verifica si
    * hay alg�n mensaje de error en las validaciones de c�digo, nombre o
    * vigencia.
    * Para la operaci�n de Borrar (bandera 3), verifica si el registro no est�
    * relacionado con otros registros en la base de datos.
    *
    * @return bool .T. si el modelo es v�lido para la operaci�n.
    */
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            IF !EMPTY(THIS.cErrorCodigo) ;
                    OR !EMPTY(THIS.cErrorNombre) ;
                    OR !EMPTY(THIS.cErrorVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN !THIS.oDao.esta_relacionado( ;
                THIS.oModelo.obtener_codigo())
        ENDIF
    ENDFUNC

    **/
    * Obtiene el mensaje de error de la validaci�n del c�digo.
    *
    * @return string Mensaje de error. Cadena vac�a si no hay error.
    */
    FUNCTION obtener_error_codigo
        RETURN IIF(VARTYPE(THIS.cErrorCodigo) == 'C', THIS.cErrorCodigo, '')
    ENDFUNC

    **/
    * Obtiene el mensaje de error de la validaci�n del nombre.
    *
    * @return string Mensaje de error. Cadena vac�a si no hay error.
    */
    FUNCTION obtener_error_nombre
        RETURN IIF(VARTYPE(THIS.cErrorNombre) == 'C', THIS.cErrorNombre, '')
    ENDFUNC

    **/
    * Obtiene el mensaje de error de la validaci�n de la vigencia.
    *
    * @return string Mensaje de error. Cadena vac�a si no hay error.
    */
    FUNCTION obtener_error_vigente
        RETURN IIF(VARTYPE(THIS.cErrorVigente) == 'C', THIS.cErrorVigente, '')
    ENDFUNC

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool configurar()
    * @method bool validar()
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
    * @return bool .T. si la configuraci�n fue completada correctamente.
    */
    PROTECTED FUNCTION configurar
        IF VARTYPE(THIS.cModelo) != 'C' OR EMPTY(THIS.cModelo) THEN
            IF ATC('validador_', THIS.Name) == 0 THEN
                RETURN .F.
            ENDIF

            THIS.cModelo = SUBSTR(LOWER(THIS.Name), 11)
        ENDIF

        IF VARTYPE(THIS.nAnchoCodigo) != 'N' OR THIS.nAnchoCodigo <= 0 THEN
            THIS.nAnchoCodigo = 9999
        ENDIF

        IF VARTYPE(THIS.nAnchoNombre) != 'N' OR THIS.nAnchoNombre <= 0 THEN
            THIS.nAnchoNombre = 30
        ENDIF
    ENDFUNC

    **/
    * Ejecuta la validaci�n de todas las propiedades del modelo.
    *
    * Este m�todo es llamado por el constructor ('Init') para las operaciones
    * de Agregar (bandera 1) y Modificar (bandera 2).
    * Almacena los mensajes de error devueltos por los m�todos de validaci�n
    * en las propiedades de error de la clase.
    *
    * @return bool .T. si la validaci�n fue ejecutada exitosamente.
    */
    PROTECTED FUNCTION validar
        WITH THIS
            .cErrorCodigo = .validar_codigo()
            .cErrorNombre = .validar_nombre()
            .cErrorVigente = .validar_vigente()
        ENDWITH
    ENDFUNC

    **/
    * Valida el c�digo del modelo.
    *
    * @return string Mensaje de error si la validaci�n falla.
    *                Cadena vac�a si no hay error.
    */
    PROTECTED FUNCTION validar_codigo
        LOCAL lcEtiqueta, lnCodigo, loModelo
        lcEtiqueta = 'C�digo: '
        lnCodigo = THIS.oModelo.obtener_codigo()

        IF lnCodigo <= 0 THEN
            RETURN lcEtiqueta + MSG_MAYOR_QUE_CERO
        ENDIF

        IF lnCodigo > THIS.nAnchoCodigo THEN
            RETURN lcEtiqueta + STRTRAN(MSG_MENOR_QUE, '{}', ;
                ALLTRIM(STR(THIS.nAnchoCodigo + 1)))
        ENDIF

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
    * @return string Mensaje de error si la validaci�n falla.
    *                Cadena vac�a si no hay error.
    */
    PROTECTED FUNCTION validar_nombre
        LOCAL lcEtiqueta, lcNombre, loModelo
        lcEtiqueta = 'Nombre: '
        lcNombre = THIS.oModelo.obtener_nombre()

        IF !EMPTY(THIS.cErrorCodigo) THEN
            RETURN THIS.cErrorCodigo
        ENDIF

        IF EMPTY(lcNombre) THEN
            RETURN lcEtiqueta + MSG_NO_BLANCO
        ENDIF

        IF LEN(lcNombre) > THIS.nAnchoNombre THEN
            RETURN lcEtiqueta + STRTRAN(MSG_LONGITUD_MAXIMA, '{}', ;
                ALLTRIM(STR(THIS.nAnchoNombre)))
        ENDIF

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
    * @return string Mensaje de error si la validaci�n falla.
    *                Cadena vac�a si no hay error.
    */
    PROTECTED FUNCTION validar_vigente
        IF VARTYPE(THIS.oModelo.esta_vigente()) != 'L' THEN
            RETURN 'Vigente: ' + MSG_TIPO_LOGICO
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
