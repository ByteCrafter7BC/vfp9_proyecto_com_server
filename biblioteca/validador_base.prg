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
* Agregar (1), Modificar (2) y Borrar (3) sobre un modelo de datos. Las
* validaciones se realizan sobre todas las propiedades.
*
* Está diseñada para ser implementada por clases validadoras específicas para
* cada modelo, proporcionando un marco de trabajo reutilizable y consistente.

* Se pueden implementar validaciones de propiedades específicas siguiendo las
* siguientes reglas:
* a) Nombre del método: 'validar_' + nombre_propiedad,
* b) El método debe retornar un valor lógico (.T. o .F.).
* Ejemplos: bool validar_codigo(), bool validar_nombre().
*/
#INCLUDE 'constantes.h'

DEFINE CLASS validador_base AS Custom
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
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method bool es_valido()
    * @method string obtener_error(string tcCampo)
    */

    **/
    * Constructor de la clase validadora.
    *
    * Inicializa la clase con los parámetros necesarios y ejecuta la validación
    * si la bandera indica una operación de Agregar o Modificar.
    *
    * @param int tnBandera Bandera que indica la operación:
    *                      1 para Agregar, 2 para Modificar y 3 para Borrar.
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
                OR VARTYPE(toDao) != 'O' THEN
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
    *   mensaje de error en cada uno de los campos del modelo.
    * - Para otras banderas (borrar), verifica que el registro no esté
    *   relacionado con otros registros de la base de datos antes de permitir
    *   la operación.
    *
    * @return bool .T. si el modelo es válido para la operación;
    *              .F. en caso contrario.
    */
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            RETURN !THIS.campo_existe_error()
        ELSE
            RETURN !THIS.oDao.esta_relacionado(THIS.oModelo.obtener('codigo'))
        ENDIF
    ENDFUNC

    **/
    * Obtiene el mensaje de error de un campo específico.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @return string Mensaje de error. Cadena vacía si no hay error.
    */
    FUNCTION obtener_error
        LPARAMETERS tcCampo
        RETURN THIS.campo_obtener_ultimo_error(tcCampo)
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool campo_establecer_ultimo_error(string tcCampo, ;
                                                 string tcUltimoError)
    * @method bool campo_existe_error()
    * @method string campo_obtener_ultimo_error()
    * @method bool validar()
    * @method bool validar_codigo()
    * @method bool validar_nombre()
    */

    **/
    * Establece el último mensaje de error del campo.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @param string tcUltimoError Mensaje de error a establecer.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    */
    PROTECTED FUNCTION campo_establecer_ultimo_error
        LPARAMETERS tcCampo, tcUltimoError

        IF VARTYPE(tcCampo) != 'C' OR EMPTY(tcCampo) ;
                OR VARTYPE(tcUltimoError) != 'C' THEN
            RETURN .F.
        ENDIF

        LOCAL loCampo
        loCampo = THIS.oModelo.campo_obtener(tcCampo)

        IF VARTYPE(loCampo) != 'O' THEN
            RETURN .F.
        ENDIF

        RETURN loCampo.establecer_ultimo_error(tcUltimoError)
    ENDFUNC

    **/
    * Verifica el último mensaje de error de todos los campos del modelo.
    *
    * @return bool .T. si existe un error o si ocurre uno;
    *              .F. en caso contrario.
    */
    PROTECTED FUNCTION campo_existe_error
        LOCAL loCampos, loCampo
        loCampos = THIS.oModelo.campo_obtener_todos()

        IF VARTYPE(loCampos) != 'O' THEN
            RETURN .T.
        ENDIF

        * Busca errores si encuentra uno devuelve .T. y termina el ciclo.
        FOR EACH loCampo IN loCampos
            IF !EMPTY(loCampo.obtener_ultimo_error()) THEN
                RETURN .T.
            ENDIF
        ENDFOR

        RETURN .F.
    ENDFUNC

    **/
    * Devuelve el último mensaje de error del campo.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @return string Mensaje de error si ocurre una falla;
    *                cadena vacía si no hay error.
    */
    PROTECTED FUNCTION campo_obtener_ultimo_error
        LPARAMETERS tcCampo

        IF VARTYPE(tcCampo) != 'C' OR EMPTY(tcCampo) THEN
            RETURN "ERROR: El parámetro 'tcCampo' no es válido."
        ENDIF

        LOCAL loCampo
        loCampo = THIS.oModelo.campo_obtener(tcCampo)

        IF VARTYPE(loCampo) != 'O' THEN
            RETURN STRTRAN(MSG_CAMPO_NO_EXISTE, '{}', tcCampo)
        ENDIF

        RETURN loCampo.obtener_ultimo_error()
    ENDFUNC

    **/
    * Ejecuta las validaciones de todos los campos del modelo.
    *
    * Este método es llamado por el constructor ('Init') para las operaciones
    * de Agregar (bandera 1) y Modificar (bandera 2).
    *
    * Almacena los mensajes de error devueltos por los métodos de validación
    * en la propiedad 'cUltimoError' de cada campo.
    */
    PROTECTED PROCEDURE validar
        LOCAL loCampos, loCampo, lcCampo
        loCampos = THIS.oModelo.campo_obtener_todos()

        IF VARTYPE(loCampos) != 'O' THEN
            RETURN .F.
        ENDIF

        * Ejecuta todas las validaciones específicas.
        FOR EACH loCampo IN loCampos
            lcCampo = loCampo.obtener_nombre()    && Nombre del campo.

            IF PEMSTATUS(THIS, 'validar_' + lcCampo, 5) THEN
                EVALUATE('THIS.validar_' + lcCampo + '()')
            ENDIF
        ENDFOR
    ENDPROC

    **/
    * Valida el código del modelo.
    *
    * @return bool .T. si el código del modelo es válido;
    *              .F. en caso contrario.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el último mensaje de error del campo.
    */
    PROTECTED FUNCTION validar_codigo
        LOCAL lcCampo, loCampo, lcEtiqueta, loModelo
        lcCampo = 'codigo'

        IF !EMPTY(THIS.campo_obtener_ultimo_error(lcCampo)) THEN
            RETURN .F.
        ENDIF

        loCampo = THIS.oModelo.campo_obtener(lcCampo)

        WITH loCampo
            lcEtiqueta = .obtener_etiqueta()
            loModelo = THIS.oDao.obtener_por_codigo(.obtener_valor())
        ENDWITH

        IF THIS.nBandera == 1 THEN    && Agregar
            IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + ;
                    THIS.oDao.obtener_ultimo_error())
                RETURN .F.
            ENDIF

            IF VARTYPE(loModelo) == 'O' THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + MSG_YA_EXISTE)
                RETURN .F.
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                    loCampo.establecer_ultimo_error(lcEtiqueta + ;
                        THIS.oDao.obtener_ultimo_error())
                    RETURN .F.
                ENDIF

                IF VARTYPE(loModelo) != 'O' THEN
                    loCampo.establecer_ultimo_error(lcEtiqueta + MSG_NO_EXISTE)
                    RETURN .F.
                ENDIF
            ENDIF
        ENDIF
    ENDFUNC

    **/
    * Valida el nombre del modelo.
    *
    * @return bool .T. si el nombre del modelo es válido;
    *              .F. en caso contrario.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el último mensaje de error del campo.
    * @uses bool campo_establecer_ultimo_error(string tcCampo, ;
                                               string tcUltimoError)
    *       Para establecer el último mensaje de error del campo.
    */
    PROTECTED FUNCTION validar_nombre
        LOCAL lcCampo, loCampo, lcEtiqueta, loModelo
        lcCampo = 'nombre'

        IF !EMPTY(THIS.campo_obtener_ultimo_error(lcCampo)) THEN
            RETURN .F.
        ENDIF

        * Verifica que el campo 'codigo' no contenga errores.
        IF !EMPTY(THIS.campo_obtener_ultimo_error('codigo')) THEN
            THIS.campo_establecer_ultimo_error(lcCampo, ;
                THIS.campo_obtener_ultimo_error('codigo'))
            RETURN .F.
        ENDIF

        loCampo = THIS.oModelo.campo_obtener(lcCampo)

        WITH loCampo
            lcEtiqueta = .obtener_etiqueta()
            loModelo = THIS.oDao.obtener_por_nombre(.obtener_valor())
        ENDWITH

        IF THIS.nBandera == 1 THEN    && Agregar
            IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + ;
                    THIS.oDao.obtener_ultimo_error())
                RETURN .F.
            ENDIF

            IF VARTYPE(loModelo) == 'O' THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + MSG_YA_EXISTE)
                RETURN .F.
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                    loCampo.establecer_ultimo_error(lcEtiqueta + ;
                        THIS.oDao.obtener_ultimo_error())
                    RETURN .F.
                ENDIF

                IF VARTYPE(loModelo) == 'O' AND loModelo.obtener('codigo') != ;
                        THIS.oModelo.obtener('codigo') THEN
                    loCampo.establecer_ultimo_error(lcEtiqueta + MSG_YA_EXISTE)
                    RETURN .F.
                ENDIF
            ENDIF
        ENDIF
    ENDFUNC
ENDDEFINE
