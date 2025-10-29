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
* @file validador_proveedo.prg
* @package modulo\proveedo
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class validador_proveedo
* @extends biblioteca\validador_base
*/

**
* Clase de validación para el modelo 'proveedo'.
*/
DEFINE CLASS validador_proveedo AS validador_base OF validador_base.prg
    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method bool es_valido()
    * @method string obtener_error(string tcCampo)
    */

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool campo_establecer_ultimo_error(string tcCampo, ;
                                                 string tcUltimoError)
    * @method bool campo_existe_error()
    * @method string campo_obtener_ultimo_error()
    * @method bool validar()
    * @method bool validar_codigo()
    * @method bool validar_nombre()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool validar_e_mail()
    * @method bool validar_ruc()
    */

    **/
    * Valida el correo electrónico del modelo.
    *
    * @return bool .T. si el correo electrónico del modelo es válido;
    *              .F. en caso contrario.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el último mensaje de error del campo.
    * @uses bool es_email(string tcEmail)
    *       Para determinar si una expresión de cadena de caracteres es una
    *       dirección de correo electrónico válida.
    * @uses object oModelo Modelo que contiene los datos a validar.
    */
    PROTECTED FUNCTION validar_e_mail
        LOCAL lcCampo, loCampo, lcEtiqueta, lcValor
        lcCampo = 'e_mail'

        IF !EMPTY(THIS.campo_obtener_ultimo_error(lcCampo)) THEN
            RETURN .F.
        ENDIF

        loCampo = THIS.oModelo.campo_obtener(lcCampo)

        WITH loCampo
            lcEtiqueta = .obtener_etiqueta()
            lcValor = .obtener_valor()
        ENDWITH

        IF !EMPTY(lcValor) AND !es_email(lcValor) THEN
            loCampo.establecer_ultimo_error(lcEtiqueta + MSG_NO_ES_VALIDO)
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida el RUC del modelo.
    *
    * @return bool .T. si el RUC del modelo es válido;
    *              .F. en caso contrario.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el último mensaje de error del campo.
    * @uses bool campo_establecer_ultimo_error(string tcCampo, ;
                                               string tcUltimoError)
    *       Para establecer el último mensaje de error del campo.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses object oModelo Modelo que contiene los datos a validar.
    * @uses object oDao DAO para la interacción con la base de datos.
    */
    PROTECTED FUNCTION validar_ruc
        LOCAL lcCampo, loCampo, lcEtiqueta, loModelo
        lcCampo = 'ruc'

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
            loModelo = THIS.oDao.obtener_por_ruc(.obtener_valor())
        ENDWITH

        IF THIS.nBandera == 1 THEN    && Agregar
            IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + ;
                    THIS.oDao.obtener_ultimo_error())
                RETURN .F.
            ENDIF

            IF es_objeto(loModelo) THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + MSG_YA_EXISTE)
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.nBandera == 2 THEN    && Modificar
            IF !EMPTY(THIS.oDao.obtener_ultimo_error()) THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + ;
                    THIS.oDao.obtener_ultimo_error())
                RETURN .F.
            ENDIF

            IF es_objeto(loModelo) AND loModelo.obtener('codigo') != ;
                    THIS.oModelo.obtener('codigo') THEN
                loCampo.establecer_ultimo_error(lcEtiqueta + MSG_YA_EXISTE)
                RETURN .F.
            ENDIF
        ENDIF
    ENDFUNC
ENDDEFINE
