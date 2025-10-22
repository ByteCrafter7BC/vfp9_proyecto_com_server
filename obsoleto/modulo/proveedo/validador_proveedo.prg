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
* @uses constantes.h
*/

**
* Clase de validación para el modelo 'proveedo'.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS validador_proveedo AS validador_base OF validador_base.prg
    **/
    * @var string Mensaje de error para la propiedad 'direc1'.
    */
    PROTECTED cErrorDirec1

    **/
    * @var string Mensaje de error para la propiedad 'direc2'.
    */
    PROTECTED cErrorDirec2

    **/
    * @var string Mensaje de error para la propiedad 'ciudad'.
    */
    PROTECTED cErrorCiudad

    **/
    * @var string Mensaje de error para la propiedad 'telefono'.
    */
    PROTECTED cErrorTelefono

    **/
    * @var string Mensaje de error para la propiedad 'fax'.
    */
    PROTECTED cErrorFax

    **/
    * @var string Mensaje de error para la propiedad 'e_mail'.
    */
    PROTECTED cErrorEmail

    **/
    * @var string Mensaje de error para la propiedad 'ruc'.
    */
    PROTECTED cErrorRuc

    **/
    * @var string Mensaje de error para la propiedad 'dias_plazo'.
    */
    PROTECTED cErrorDiasPlazo

    **/
    * @var string Mensaje de error para la propiedad 'dueno'.
    */
    PROTECTED cErrorDueno

    **/
    * @var string Mensaje de error para la propiedad 'teldueno'.
    */
    PROTECTED cErrorTelDueno

    **/
    * @var string Mensaje de error para la propiedad 'gtegral'.
    */
    PROTECTED cErrorGteGral

    **/
    * @var string Mensaje de error para la propiedad 'telgg'.
    */
    PROTECTED cErrorTelGG

    **/
    * @var string Mensaje de error para la propiedad 'gteventas'.
    */
    PROTECTED cErrorGteVentas

    **/
    * @var string Mensaje de error para la propiedad 'telgv'.
    */
    PROTECTED cErrorTelGV

    **/
    * @var string Mensaje de error para la propiedad 'gtemkg'.
    */
    PROTECTED cErrorGteMkg

    **/
    * @var string Mensaje de error para la propiedad 'telgm'.
    */
    PROTECTED cErrorTelGM

    **/
    * @var string Mensaje de error para la propiedad 'stecnico'.
    */
    PROTECTED cErrorSTecnico

    **/
    * @var string Mensaje de error para la propiedad 'stdirec1'.
    */
    PROTECTED cErrorSTDirec1

    **/
    * @var string Mensaje de error para la propiedad 'stdirec2'.
    */
    PROTECTED cErrorSTDirec2

    **/
    * @var string Mensaje de error para la propiedad 'sttel'.
    */
    PROTECTED cErrorSTTel

    **/
    * @var string Mensaje de error para la propiedad 'sthablar1'.
    */
    PROTECTED cErrorSTHablar1

    **/
    * @var string Mensaje de error para la propiedad 'vendedor1'.
    */
    PROTECTED cErrorVendedor1

    **/
    * @var string Mensaje de error para la propiedad 'larti1'.
    */
    PROTECTED cErrorLArti1

    **/
    * @var string Mensaje de error para la propiedad 'tvend1'.
    */
    PROTECTED cErrorTVend1

    **/
    * @var string Mensaje de error para la propiedad 'vendedor2'.
    */
    PROTECTED cErrorVendedor2

    **/
    * @var string Mensaje de error para la propiedad 'larti2'.
    */
    PROTECTED cErrorLArti2

    **/
    * @var string Mensaje de error para la propiedad 'tvend2'.
    */
    PROTECTED cErrorTVend2

    **/
    * @var string Mensaje de error para la propiedad 'vendedor3'.
    */
    PROTECTED cErrorVendedor3

    **/
    * @var string Mensaje de error para la propiedad 'larti3'.
    */
    PROTECTED cErrorLArti3

    **/
    * @var string Mensaje de error para la propiedad 'tvend3'.
    */
    PROTECTED cErrorTVend3

    **/
    * @var string Mensaje de error para la propiedad 'vendedor4'.
    */
    PROTECTED cErrorVendedor4

    **/
    * @var string Mensaje de error para la propiedad 'larti4'.
    */
    PROTECTED cErrorLArti4

    **/
    * @var string Mensaje de error para la propiedad 'tvend4'.
    */
    PROTECTED cErrorTVend4

    **/
    * @var string Mensaje de error para la propiedad 'vendedor5'.
    */
    PROTECTED cErrorVendedor5

    **/
    * @var string Mensaje de error para la propiedad 'larti5'.
    */
    PROTECTED cErrorLArti5

    **/
    * @var string Mensaje de error para la propiedad 'tvend5'.
    */
    PROTECTED cErrorTVend5

    **/
    * @var string Mensaje de error para la propiedad 'saldo_actu'.
    */
    PROTECTED cErrorSaldoActu

    **/
    * @var string Mensaje de error para la propiedad 'saldo_usd'.
    */
    PROTECTED cErrorSaldoUSD

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnBandera, object toModelo, object toDao)
    * @method string obtener_error_codigo()
    * @method string obtener_error_nombre()
    * @method string obtener_error_vigente()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method bool es_valido()
    * @method string obtener_error_direc1()
    * @method string obtener_error_direc2()
    * @method string obtener_error_ciudad()
    * @method string obtener_error_telefono()
    * @method string obtener_error_fax()
    * @method string obtener_error_email()
    * @method string obtener_error_ruc()
    * @method string obtener_error_dias_plazo()
    * @method string obtener_error_dueno()
    * @method string obtener_error_teldueno()
    * @method string obtener_error_gtegral()
    * @method string obtener_error_telgg()
    * @method string obtener_error_gteventas()
    * @method string obtener_error_telgv()
    * @method string obtener_error_gtemkg()
    * @method string obtener_error_telgm()
    * @method string obtener_error_stecnico()
    * @method string obtener_error_stdirec1()
    * @method string obtener_error_stdirec2()
    * @method string obtener_error_sttel()
    * @method string obtener_error_sthablar1()
    * @method string obtener_error_vendedor1()
    * @method string obtener_error_larti1()
    * @method string obtener_error_tvend1()
    * @method string obtener_error_vendedor2()
    * @method string obtener_error_larti2()
    * @method string obtener_error_tvend2()
    * @method string obtener_error_vendedor3()
    * @method string obtener_error_larti3()
    * @method string obtener_error_tvend3()
    * @method string obtener_error_vendedor4()
    * @method string obtener_error_larti4()
    * @method string obtener_error_tvend4()
    * @method string obtener_error_vendedor5()
    * @method string obtener_error_larti5()
    * @method string obtener_error_tvend5()
    * @method string obtener_error_saldo_actu()
    * @method string obtener_error_saldo_usd()
    */

    **/
    * Verifica si el modelo es válido según el contexto (bandera).
    *
    * - Para banderas 1 y 2 (agregar/modificar), comprueba si existe algún
    *   mensaje de error en las propiedades de la clase.
    * - Para otras banderas (borrar), verifica que la familia no esté
    *   relacionada con otros registros de la base de datos.
    *
    * @return bool .T. si el modelo es válido, o .F. si no lo es.
    * @override
    */
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            IF !EMPTY(THIS.cErrorCodigo) ;
                    OR !EMPTY(THIS.cErrorNombre) ;
                    OR !EMPTY(THIS.cErrorDirec1) ;
                    OR !EMPTY(THIS.cErrorDirec2) ;
                    OR !EMPTY(THIS.cErrorCiudad) ;
                    OR !EMPTY(THIS.cErrorTelefono) ;
                    OR !EMPTY(THIS.cErrorFax) ;
                    OR !EMPTY(THIS.cErrorEmail) ;
                    OR !EMPTY(THIS.cErrorRuc) ;
                    OR !EMPTY(THIS.cErrorDiasPlazo) ;
                    OR !EMPTY(THIS.cErrorDueno) ;
                    OR !EMPTY(THIS.cErrorTelDueno) ;
                    OR !EMPTY(THIS.cErrorGteGral) ;
                    OR !EMPTY(THIS.cErrorTelGG) ;
                    OR !EMPTY(THIS.cErrorGteVentas) ;
                    OR !EMPTY(THIS.cErrorTelGV) ;
                    OR !EMPTY(THIS.cErrorGteMkg) ;
                    OR !EMPTY(THIS.cErrorTelGM) ;
                    OR !EMPTY(THIS.cErrorSTecnico) ;
                    OR !EMPTY(THIS.cErrorSTDirec1) ;
                    OR !EMPTY(THIS.cErrorSTDirec2) ;
                    OR !EMPTY(THIS.cErrorSTTel) ;
                    OR !EMPTY(THIS.cErrorSTHablar1) ;
                    OR !EMPTY(THIS.cErrorVendedor1) ;
                    OR !EMPTY(THIS.cErrorLArti1) ;
                    OR !EMPTY(THIS.cErrorTVend1) ;
                    OR !EMPTY(THIS.cErrorVendedor2) ;
                    OR !EMPTY(THIS.cErrorLArti2) ;
                    OR !EMPTY(THIS.cErrorTVend2) ;
                    OR !EMPTY(THIS.cErrorVendedor3) ;
                    OR !EMPTY(THIS.cErrorLArti3) ;
                    OR !EMPTY(THIS.cErrorTVend3) ;
                    OR !EMPTY(THIS.cErrorVendedor4) ;
                    OR !EMPTY(THIS.cErrorLArti4) ;
                    OR !EMPTY(THIS.cErrorTVend4) ;
                    OR !EMPTY(THIS.cErrorVendedor5) ;
                    OR !EMPTY(THIS.cErrorLArti5) ;
                    OR !EMPTY(THIS.cErrorTVend5) ;
                    OR !EMPTY(THIS.cErrorSaldoActu) ;
                    OR !EMPTY(THIS.cErrorSaldoUSD) ;
                    OR !EMPTY(THIS.cErrorVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN !THIS.oDao.esta_relacionado(THIS.oModelo.obtener_codigo())
        ENDIF
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'direc1',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_direc1
        RETURN IIF(VARTYPE(THIS.cErrorDirec1) == 'C', THIS.cErrorDirec1, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'direc2',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_direc2
        RETURN IIF(VARTYPE(THIS.cErrorDirec2) == 'C', THIS.cErrorDirec2, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'ciudad',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_ciudad
        RETURN IIF(VARTYPE(THIS.cErrorCiudad) == 'C', THIS.cErrorCiudad, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'telefono',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_telefono
        RETURN IIF(VARTYPE(THIS.cErrorTelefono) == 'C', THIS.cErrorTelefono, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'fax',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_fax
        RETURN IIF(VARTYPE(THIS.cErrorFax) == 'C', THIS.cErrorFax, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'email',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_email
        RETURN IIF(VARTYPE(THIS.cErrorEmail) == 'C', THIS.cErrorEmail, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'ruc',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_ruc
        RETURN IIF(VARTYPE(THIS.cErrorRuc) == 'C', THIS.cErrorRuc, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'dias_plazo',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_dias_plazo
        RETURN IIF(VARTYPE(THIS.cErrorDiasPlazo) == 'C', ;
            THIS.cErrorDiasPlazo, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'dueno',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_dueno
        RETURN IIF(VARTYPE(THIS.cErrorDueno) == 'C', THIS.cErrorDueno, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'teldueno',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_teldueno
        RETURN IIF(VARTYPE(THIS.cErrorTelDueno) == 'C', THIS.cErrorTelDueno, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'gtegral',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_gtegral
        RETURN IIF(VARTYPE(THIS.cErrorGteGral) == 'C', THIS.cErrorGteGral, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'telgg',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_telgg
        RETURN IIF(VARTYPE(THIS.cErrorTelGG) == 'C', THIS.cErrorTelGG, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'gteventas',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_gteventas
        RETURN IIF(VARTYPE(THIS.cErrorGteVentas) == 'C', ;
            THIS.cErrorGteVentas, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'telgv',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_telgv
        RETURN IIF(VARTYPE(THIS.cErrorTelGV) == 'C', THIS.cErrorTelGV, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'gtemkg',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_gtemkg
        RETURN IIF(VARTYPE(THIS.cErrorGteMkg) == 'C', THIS.cErrorGteMkg, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'telgm',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_telgm
        RETURN IIF(VARTYPE(THIS.cErrorTelGM) == 'C', THIS.cErrorTelGM, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'stecnico',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_stecnico
        RETURN IIF(VARTYPE(THIS.cErrorSTecnico) == 'C', THIS.cErrorSTecnico, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'stdirec1',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_stdirec1
        RETURN IIF(VARTYPE(THIS.cErrorSTDirec1) == 'C', THIS.cErrorSTDirec1, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'stdirec2',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_stdirec2
        RETURN IIF(VARTYPE(THIS.cErrorSTDirec2) == 'C', THIS.cErrorSTDirec2, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'sttel',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_sttel
        RETURN IIF(VARTYPE(THIS.cErrorSTTel) == 'C', THIS.cErrorSTTel, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'sthablar1',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_sthablar1
        RETURN IIF(VARTYPE(THIS.cErrorSTHablar1) == 'C', ;
            THIS.cErrorSTHablar1, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'vendedor1',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_vendedor1
        RETURN IIF(VARTYPE(THIS.cErrorVendedor1) == 'C', ;
            THIS.cErrorVendedor1, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'larti1',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_larti1
        RETURN IIF(VARTYPE(THIS.cErrorLArti1) == 'C', THIS.cErrorLArti1, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'tvend1',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_tvend1
        RETURN IIF(VARTYPE(THIS.cErrorTVend1) == 'C', THIS.cErrorTVend1, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'vendedor2',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_vendedor2
        RETURN IIF(VARTYPE(THIS.cErrorVendedor2) == 'C', ;
            THIS.cErrorVendedor2, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'larti2',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_larti2
        RETURN IIF(VARTYPE(THIS.cErrorLArti2) == 'C', THIS.cErrorLArti2, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'tvend2',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_tvend2
        RETURN IIF(VARTYPE(THIS.cErrorTVend2) == 'C', THIS.cErrorTVend2, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'vendedor3',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_vendedor3
        RETURN IIF(VARTYPE(THIS.cErrorVendedor3) == 'C', ;
            THIS.cErrorVendedor3, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'larti3',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_larti3
        RETURN IIF(VARTYPE(THIS.cErrorLArti3) == 'C', THIS.cErrorLArti3, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'tvend3',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_tvend3
        RETURN IIF(VARTYPE(THIS.cErrorTVend3) == 'C', THIS.cErrorTVend3, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'vendedor4',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_vendedor4
        RETURN IIF(VARTYPE(THIS.cErrorVendedor4) == 'C', ;
            THIS.cErrorVendedor4, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'larti4',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_larti4
        RETURN IIF(VARTYPE(THIS.cErrorLArti4) == 'C', THIS.cErrorLArti4, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'tvend4',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_tvend4
        RETURN IIF(VARTYPE(THIS.cErrorTVend4) == 'C', THIS.cErrorTVend4, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'vendedor5',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_vendedor5
        RETURN IIF(VARTYPE(THIS.cErrorVendedor5) == 'C', ;
            THIS.cErrorVendedor5, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'larti5',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_larti5
        RETURN IIF(VARTYPE(THIS.cErrorLArti5) == 'C', THIS.cErrorLArti5, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'tvend5',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_tvend5
        RETURN IIF(VARTYPE(THIS.cErrorTVend5) == 'C', THIS.cErrorTVend5, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'saldo_actu',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_saldo_actu
        RETURN IIF(VARTYPE(THIS.cErrorSaldoActu) == 'C', ;
            THIS.cErrorSaldoActu, '')
    ENDFUNC

    **
    * Devuelve el mensaje de error de la propiedad 'saldo_usd',
    * o una cadena vacía si no hay error.
    *
    * @return string
    */
    FUNCTION obtener_error_saldo_usd
        RETURN IIF(VARTYPE(THIS.cErrorSaldoUSD) == 'C', THIS.cErrorSaldoUSD, '')
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool configurar()
    * @method string validar_codigo()
    * @method string validar_nombre()
    * @method string validar_vigente()
    * -- MÉTODOS ESPECÍFICOS DE ESTA CLASE --
    * @method void validar()
    * @method string validar_direc1()
    * @method string validar_direc1()
    * @method string validar_ciudad()
    * @method string validar_telefono()
    * @method string validar_fax()
    * @method string validar_email()
    * @method string validar_ruc()
    * @method string validar_dias_plazo()
    * @method string validar_dueno()
    * @method string validar_teldueno()
    * @method string validar_gtegral()
    * @method string validar_telgg()
    * @method string validar_gteventas()
    * @method string validar_telgv()
    * @method string validar_gtemkg()
    * @method string validar_telgm()
    * @method string validar_stecnico()
    * @method string validar_stdirec1()
    * @method string validar_stdirec2()
    * @method string validar_sttel()
    * @method string validar_sthablar1()
    * @method string validar_vendedor1()
    * @method string validar_larti1()
    * @method string validar_tvend1()
    * @method string validar_vendedor2()
    * @method string validar_larti2()
    * @method string validar_tvend2()
    * @method string validar_vendedor3()
    * @method string validar_larti3()
    * @method string validar_tvend3()
    * @method string validar_vendedor4()
    * @method string validar_larti4()
    * @method string validar_tvend4()
    * @method string validar_vendedor5()
    * @method string validar_larti5()
    * @method string validar_tvend5()
    * @method string validar_saldo_actu()
    * @method string validar_saldo_usd()
    */

    **
    * Ejecuta todas las reglas de validación para el modelo.
    *
    * Llama al método de validación de la clase base y luego ejecuta las
    * validaciones específicas.
    *
    * Este método es invocado por el constructor ('Init') para las operaciones
    * de agregar (bandera 1) y modificar (bandera 2).
    *
    * Almacena los mensajes de error devueltos por los métodos de validación
    * en las propiedades de error de la clase.
    *
    * @override
    */
    PROTECTED PROCEDURE validar
        validador_base::validar()

        WITH THIS
            .cErrorDirec1 = .validar_direc1()
            .cErrorDirec2 = .validar_direc1()
            .cErrorCiudad = .validar_ciudad()
            .cErrorTelefono = .validar_telefono()
            .cErrorFax = .validar_fax()
            .cErrorEmail = .validar_email()
            .cErrorRuc = .validar_ruc()
            .cErrorDiasPlazo = .validar_dias_plazo()
            .cErrorDueno = .validar_dueno()
            .cErrorTelDueno = .validar_teldueno()
            .cErrorGteGral = .validar_gtegral()
            .cErrorTelGG = .validar_telgg()
            .cErrorGteVentas = .validar_gteventas()
            .cErrorTelGV = .validar_telgv()
            .cErrorGteMkg = .validar_gtemkg()
            .cErrorTelGM = .validar_telgm()
            .cErrorSTecnico = .validar_stecnico()
            .cErrorSTDirec1 = .validar_stdirec1()
            .cErrorSTDirec2 = .validar_stdirec2()
            .cErrorSTTel = .validar_sttel()
            .cErrorSTHablar1 = .validar_sthablar1()
            .cErrorVendedor1 = .validar_vendedor1()
            .cErrorLArti1 = .validar_larti1()
            .cErrorTVend1 = .validar_tvend1()
            .cErrorVendedor2 = .validar_vendedor2()
            .cErrorLArti2 = .validar_larti2()
            .cErrorTVend2 = .validar_tvend2()
            .cErrorVendedor3 = .validar_vendedor3()
            .cErrorLArti3 = .validar_larti3()
            .cErrorTVend3 = .validar_tvend3()
            .cErrorVendedor4 = .validar_vendedor4()
            .cErrorLArti4 = .validar_larti4()
            .cErrorTVend4 = .validar_tvend4()
            .cErrorVendedor5 = .validar_vendedor5()
            .cErrorLArti5 = .validar_larti5()
            .cErrorTVend5 = .validar_tvend5()
            .cErrorSaldoActu = .validar_saldo_actu()
            .cErrorSaldoUSD = .validar_saldo_usd()
        ENDWITH
    ENDPROC

    **/
    * Valida la propiedad 'direc1'.
    *
    * @return string Mensaje de error si la validación falla.
    *                Cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_direc1
        LOCAL lcEtiqueta, lcValor, lnAncho
        lcEtiqueta = 'Dirección 1: '
        lcValor = THIS.oModelo.obtener_direc1()
        lnAncho = 60

        IF LEN(lcValor) > lnAncho THEN
            RETURN lcEtiqueta + STRTRAN(MSG_LONGITUD_MAXIMA, '{}', ;
                ALLTRIM(STR(lnAncho)))
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida la propiedad 'direc2'.
    *
    * @return string Mensaje de error si la validación falla.
    *                Cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_direc2
        LOCAL lcEtiqueta, lcValor, lnAncho
        lcEtiqueta = 'Dirección 2: '
        lcValor = THIS.oModelo.obtener_direc2()
        lnAncho = 60

        IF LEN(lcValor) > lnAncho THEN
            RETURN lcEtiqueta + STRTRAN(MSG_LONGITUD_MAXIMA, '{}', ;
                ALLTRIM(STR(lnAncho)))
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida la propiedad 'ciudad'.
    *
    * @return string Mensaje de error si la validación falla.
    *                Cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_ciudad
        LOCAL lcEtiqueta, lcValor, lnAncho
        lcEtiqueta = 'Ciudad: '
        lcValor = THIS.oModelo.obtener_ciudad()
        lnAncho = 25

        IF LEN(lcValor) > lnAncho THEN
            RETURN lcEtiqueta + STRTRAN(MSG_LONGITUD_MAXIMA, '{}', ;
                ALLTRIM(STR(lnAncho)))
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida la propiedad 'telefono'.
    *
    * @return string Mensaje de error si la validación falla.
    *                Cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_telefono
        LOCAL lcEtiqueta, lcValor, lnAncho
        lcEtiqueta = 'Teléfono: '
        lcValor = THIS.oModelo.obtener_telefono()
        lnAncho = 40

        IF LEN(lcValor) > lnAncho THEN
            RETURN lcEtiqueta + STRTRAN(MSG_LONGITUD_MAXIMA, '{}', ;
                ALLTRIM(STR(lnAncho)))
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida la propiedad 'fax'.
    *
    * @return string Mensaje de error si la validación falla.
    *                Cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_fax
        RETURN THIS.validar_campo('fax')
    ENDFUNC

    **/
    * Valida la propiedad 'email'.
    *
    * @return string Mensaje de error si la validación falla.
    *                Cadena vacía si no hay error.
    */
    PROTECTED FUNCTION validar_email
        LOCAL lcCampo, lcMensaje, loCampo, lcValor
        lcCampo = 'e_mail'
        lcMensaje = THIS.validar_campo(lcCampo)

        IF !EMPTY(lcMensaje) THEN
            RETURN lcMensaje
        ENDIF

        loCampo = THIS.obtener_campo(lcCampo)

        IF VARTYPE(loCampo) != 'O' THEN
            RETURN "El campo '" + ALLTRIM(tcCampo) + "' no existe en el " + ;
                "arreglo 'aEstructuraTabla'."
        ENDIF

        lcValor = EVALUATE('THIS.oModelo.' + loCampo.getter + '()')

        IF !EMPTY(lcValor) THEN
            IF !es_email(lcValor) THEN
                RETURN loCampo.etiqueta + MSG_NO_ES_VALIDO
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Carga la estructura de la tabla a la propiedad de tipo arreglo
    * 'aEstructuraTabla'.
    *
    * Este método es llamado por el constructor ('Init').
    *
    * @return bool .T. si la carga se completa correctamente;
    *              .F. si ocurre un error.
    * @override
    */
    PROTECTED FUNCTION cargar_estructura_tabla
        DIMENSION THIS.aEstructuraTabla[41, 8]
        **/
        * Estructura de la tabla
        * [n, 1] = nombre del campo (ej.: 'codigo', 'nombre', 'vigente'),
        * [n, 2] = tipo de dato el campo (ej.: 'C', 'D', 'L', 'N', 'T'),
        * [n, 3] = ancho del campo (ej.: 4, 30, 1),
        * [n, 4] = decimales (posiciones decimales en caso de tipo 'N'),
        * [n, 5] = etiqueta (ej.: 'Código: ', 'Nombre: ', 'Vigente: '),
        * [n, 6] = nombre de la propiedad de la clase (ej.: 'nCodigo'),
        * [n, 7] = getter de la clase (ej.: 'obtener_codigo'),
        * [n, 8] = setter de la clase (ej.: 'establecer_codigo').
        */
        THIS.aEstructuraTabla[01, 1] = 'codigo'
        THIS.aEstructuraTabla[01, 2] = 'N'
        THIS.aEstructuraTabla[01, 3] = 5
        THIS.aEstructuraTabla[01, 5] = 'Código: '

        THIS.aEstructuraTabla[02, 1] = 'nombre'
        THIS.aEstructuraTabla[02, 2] = 'C'
        THIS.aEstructuraTabla[02, 3] = 40
        THIS.aEstructuraTabla[02, 5] = 'Nombre: '

        THIS.aEstructuraTabla[03, 1] = 'direc1'
        THIS.aEstructuraTabla[03, 2] = 'C'
        THIS.aEstructuraTabla[03, 3] = 60
        THIS.aEstructuraTabla[03, 5] = 'Dirección 1: '

        THIS.aEstructuraTabla[04, 1] = 'direc2'
        THIS.aEstructuraTabla[04, 2] = 'C'
        THIS.aEstructuraTabla[04, 3] = 60
        THIS.aEstructuraTabla[04, 5] = 'Dirección 2: '

        THIS.aEstructuraTabla[05, 1] = 'ciudad'
        THIS.aEstructuraTabla[05, 2] = 'C'
        THIS.aEstructuraTabla[05, 3] = 25
        THIS.aEstructuraTabla[05, 5] = 'Ciudad: '

        THIS.aEstructuraTabla[06, 1] = 'telefono'
        THIS.aEstructuraTabla[06, 2] = 'C'
        THIS.aEstructuraTabla[06, 3] = 40
        THIS.aEstructuraTabla[06, 5] = 'Teléfono: '

        THIS.aEstructuraTabla[07, 1] = 'fax'
        THIS.aEstructuraTabla[07, 2] = 'C'
        THIS.aEstructuraTabla[07, 3] = 25
        THIS.aEstructuraTabla[07, 5] = 'Fax: '

        THIS.aEstructuraTabla[08, 1] = 'e_mail'
        THIS.aEstructuraTabla[08, 2] = 'C'
        THIS.aEstructuraTabla[08, 3] = 60
        THIS.aEstructuraTabla[08, 5] = 'E-mail: '
        THIS.aEstructuraTabla[08, 6] = 'cEmail'
        THIS.aEstructuraTabla[08, 7] = 'obtener_email'
        THIS.aEstructuraTabla[08, 8] = 'establecer_email'

        THIS.aEstructuraTabla[09, 1] = 'ruc'
        THIS.aEstructuraTabla[09, 2] = 'C'
        THIS.aEstructuraTabla[09, 3] = 15
        THIS.aEstructuraTabla[09, 5] = 'RUC: '

        THIS.aEstructuraTabla[10, 1] = 'dias_plazo'
        THIS.aEstructuraTabla[10, 2] = 'N'
        THIS.aEstructuraTabla[10, 3] = 3
        THIS.aEstructuraTabla[10, 5] = 'Crédito (días): '

        THIS.aEstructuraTabla[11, 1] = 'dueno'
        THIS.aEstructuraTabla[11, 2] = 'C'
        THIS.aEstructuraTabla[11, 3] = 40
        THIS.aEstructuraTabla[11, 5] = 'Propietario: '

        THIS.aEstructuraTabla[12, 1] = 'teldueno'
        THIS.aEstructuraTabla[12, 2] = 'C'
        THIS.aEstructuraTabla[12, 3] = 25
        THIS.aEstructuraTabla[12, 5] = 'Número de teléfono del Propietario: '

        THIS.aEstructuraTabla[13, 1] = 'gtegral'
        THIS.aEstructuraTabla[13, 2] = 'C'
        THIS.aEstructuraTabla[13, 3] = 40
        THIS.aEstructuraTabla[13, 5] = 'Gerente General: '

        THIS.aEstructuraTabla[14, 1] = 'telgg'
        THIS.aEstructuraTabla[14, 2] = 'C'
        THIS.aEstructuraTabla[14, 3] = 25
        THIS.aEstructuraTabla[14, 5] = ;
            'Número de teléfono del Gerente General: '

        THIS.aEstructuraTabla[15, 1] = 'gteventas'
        THIS.aEstructuraTabla[15, 2] = 'C'
        THIS.aEstructuraTabla[15, 3] = 40
        THIS.aEstructuraTabla[15, 5] = 'Gerente de Ventas: '

        THIS.aEstructuraTabla[16, 1] = 'telgv'
        THIS.aEstructuraTabla[16, 2] = 'C'
        THIS.aEstructuraTabla[16, 3] = 25
        THIS.aEstructuraTabla[16, 5] = ;
            'Número de teléfono del Gerente de Ventas: '

        THIS.aEstructuraTabla[17, 1] = 'gtemkg'
        THIS.aEstructuraTabla[17, 2] = 'C'
        THIS.aEstructuraTabla[17, 3] = 40
        THIS.aEstructuraTabla[17, 5] = 'Gerente de Marketing: '

        THIS.aEstructuraTabla[18, 1] = 'telgm'
        THIS.aEstructuraTabla[18, 2] = 'C'
        THIS.aEstructuraTabla[18, 3] = 25
        THIS.aEstructuraTabla[18, 5] = ;
            'Número de teléfono del Gerente de Marketing: '

        THIS.aEstructuraTabla[19, 1] = 'stecnico'
        THIS.aEstructuraTabla[19, 2] = 'C'
        THIS.aEstructuraTabla[19, 3] = 40
        THIS.aEstructuraTabla[19, 5] = 'Servicio Técnico: '

        THIS.aEstructuraTabla[20, 1] = 'stdirec1'
        THIS.aEstructuraTabla[20, 2] = 'C'
        THIS.aEstructuraTabla[20, 3] = 60
        THIS.aEstructuraTabla[20, 5] = 'Dirección 1 del Servicio Técnico: '

        THIS.aEstructuraTabla[21, 1] = 'direc2'
        THIS.aEstructuraTabla[21, 2] = 'C'
        THIS.aEstructuraTabla[21, 3] = 60
        THIS.aEstructuraTabla[21, 5] = 'Dirección 2 del Servicio Técnico: '

        THIS.aEstructuraTabla[22, 1] = 'sttel'
        THIS.aEstructuraTabla[22, 2] = 'C'
        THIS.aEstructuraTabla[22, 3] = 25
        THIS.aEstructuraTabla[22, 5] = ;
            'Número de teléfono del Servicio Técnico: '

        THIS.aEstructuraTabla[23, 1] = 'sthablar1'
        THIS.aEstructuraTabla[23, 2] = 'C'
        THIS.aEstructuraTabla[23, 3] = 60
        THIS.aEstructuraTabla[23, 5] = ;
            'Nombre del contacto del Servicio Técnico: '

        THIS.aEstructuraTabla[24, 1] = 'vendedor1'
        THIS.aEstructuraTabla[24, 2] = 'C'
        THIS.aEstructuraTabla[24, 3] = 40
        THIS.aEstructuraTabla[24, 5] = ;
            'Nombre del vendedor de la línea de artículos 1: '

        THIS.aEstructuraTabla[25, 1] = 'larti1'
        THIS.aEstructuraTabla[25, 2] = 'C'
        THIS.aEstructuraTabla[25, 3] = 25
        THIS.aEstructuraTabla[25, 5] = 'Línea de artículos 1: '

        THIS.aEstructuraTabla[26, 1] = 'tvend1'
        THIS.aEstructuraTabla[26, 2] = 'C'
        THIS.aEstructuraTabla[26, 3] = 25
        THIS.aEstructuraTabla[26, 5] = ;
            'Número de teléfono del vendedor de la línea de artículos 1: '

        THIS.aEstructuraTabla[27, 1] = 'vendedor2'
        THIS.aEstructuraTabla[27, 2] = 'C'
        THIS.aEstructuraTabla[27, 3] = 40
        THIS.aEstructuraTabla[27, 5] = ;
            'Nombre del vendedor de la línea de artículos 2: '

        THIS.aEstructuraTabla[28, 1] = 'larti2'
        THIS.aEstructuraTabla[28, 2] = 'C'
        THIS.aEstructuraTabla[28, 3] = 25
        THIS.aEstructuraTabla[28, 5] = 'Línea de artículos 2: '

        THIS.aEstructuraTabla[29, 1] = 'tvend2'
        THIS.aEstructuraTabla[29, 2] = 'C'
        THIS.aEstructuraTabla[29, 3] = 25
        THIS.aEstructuraTabla[29, 5] = ;
            'Número de teléfono del vendedor de la línea de artículos 2: '

        THIS.aEstructuraTabla[30, 1] = 'vendedor3'
        THIS.aEstructuraTabla[30, 2] = 'C'
        THIS.aEstructuraTabla[30, 3] = 40
        THIS.aEstructuraTabla[30, 5] = ;
            'Nombre del vendedor de la línea de artículos 3: '

        THIS.aEstructuraTabla[31, 1] = 'larti3'
        THIS.aEstructuraTabla[31, 2] = 'C'
        THIS.aEstructuraTabla[31, 3] = 25
        THIS.aEstructuraTabla[31, 5] = 'Línea de artículos 3: '

        THIS.aEstructuraTabla[32, 1] = 'tvend3'
        THIS.aEstructuraTabla[32, 2] = 'C'
        THIS.aEstructuraTabla[32, 3] = 25
        THIS.aEstructuraTabla[32, 5] = ;
            'Número de teléfono del vendedor de la línea de artículos 3: '

        THIS.aEstructuraTabla[33, 1] = 'vendedor4'
        THIS.aEstructuraTabla[33, 2] = 'C'
        THIS.aEstructuraTabla[33, 3] = 40
        THIS.aEstructuraTabla[33, 5] = ;
            'Nombre del vendedor de la línea de artículos 4: '

        THIS.aEstructuraTabla[34, 1] = 'larti4'
        THIS.aEstructuraTabla[34, 2] = 'C'
        THIS.aEstructuraTabla[34, 3] = 25
        THIS.aEstructuraTabla[34, 5] = 'Línea de artículos 4: '

        THIS.aEstructuraTabla[35, 1] = 'tvend4'
        THIS.aEstructuraTabla[35, 2] = 'C'
        THIS.aEstructuraTabla[35, 3] = 25
        THIS.aEstructuraTabla[35, 5] = ;
            'Número de teléfono del vendedor de la línea de artículos 4: '

        THIS.aEstructuraTabla[36, 1] = 'vendedor5'
        THIS.aEstructuraTabla[36, 2] = 'C'
        THIS.aEstructuraTabla[36, 3] = 40
        THIS.aEstructuraTabla[36, 5] = ;
            'Nombre del vendedor de la línea de artículos 5: '

        THIS.aEstructuraTabla[37, 1] = 'larti5'
        THIS.aEstructuraTabla[37, 2] = 'C'
        THIS.aEstructuraTabla[37, 3] = 25
        THIS.aEstructuraTabla[37, 5] = 'Línea de artículos 5: '

        THIS.aEstructuraTabla[38, 1] = 'tvend5'
        THIS.aEstructuraTabla[38, 2] = 'C'
        THIS.aEstructuraTabla[38, 3] = 25
        THIS.aEstructuraTabla[38, 5] = ;
            'Número de teléfono del vendedor de la línea de artículos 5: '

        THIS.aEstructuraTabla[39, 1] = 'saldo_actu'
        THIS.aEstructuraTabla[39, 2] = 'N'
        THIS.aEstructuraTabla[39, 3] = 12
        THIS.aEstructuraTabla[39, 5] = 'Saldo actual PYG: '

        THIS.aEstructuraTabla[40, 1] = 'saldo_usd'
        THIS.aEstructuraTabla[40, 2] = 'N'
        THIS.aEstructuraTabla[40, 3] = 12
        THIS.aEstructuraTabla[40, 4] = 2
        THIS.aEstructuraTabla[40, 5] = 'Saldo actual USD: '

        THIS.aEstructuraTabla[41, 1] = 'vigente'
        THIS.aEstructuraTabla[41, 2] = 'L'
        THIS.aEstructuraTabla[41, 3] = 1
        THIS.aEstructuraTabla[41, 5] = 'Vigente: '
    ENDFUNC
ENDDEFINE
