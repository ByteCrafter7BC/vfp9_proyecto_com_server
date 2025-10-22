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
* @file validador_proveedo.prg
* @package modulo\proveedo
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class validador_proveedo
* @extends biblioteca\validador_base
*/

**
* Clase de validaci�n para el modelo 'proveedo'.
*/
DEFINE CLASS validador_proveedo AS validador_base OF validador_base.prg
    **/
    * @section M�TODOS P�BLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method bool es_valido()
    * @method string obtener_error(string tcCampo)
    */

    **/
    * @section M�TODOS PROTEGIDOS
    * @method bool campo_establecer_ultimo_error(string tcCampo, ;
                                                 string tcUltimoError)
    * @method bool campo_existe_error()
    * @method string campo_obtener_ultimo_error()
    * @method bool validar()
    * @method bool validar_codigo()
    * @method bool validar_nombre()
    * @method bool validar_e_mail()
    * @method bool validar_ruc()
    */

    **/
    * Valida el correo electr�nico del modelo.
    *
    * @return bool .T. si el correo electr�nico es v�lido;
    *              .F. en caso contrario.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el �ltimo mensaje de error del campo.
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
    * @return bool .T. si el RUC del modelo es v�lido;
    *              .F. en caso contrario.
    * @uses string campo_obtener_ultimo_error(string tcCampo)
    *       Para obtener el �ltimo mensaje de error del campo.
    * @uses bool campo_establecer_ultimo_error(string tcCampo, ;
                                               string tcUltimoError)
    *       Para establecer el �ltimo mensaje de error del campo.
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
