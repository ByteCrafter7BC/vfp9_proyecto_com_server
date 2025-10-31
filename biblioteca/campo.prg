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
* @file campo.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @class campo
* @extends Custom
* @uses constantes.h
*/

**/
* Clase para representar un campo de una tabla; implementa validación del valor
* del campo almacenado en la propiedad 'vValor'.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS campo AS Custom
    **/
    * var string Nombre del campo (ej.: 'codigo', 'nombre', 'vigente').
    */
    PROTECTED cNombre

    **/
    * var string Tipo de dato del campo (ej.: 'C', 'D', 'L', 'N', 'T').
    */
    PROTECTED cTipo

    **/
    * var int Ancho del campo (ej.: 4, 30, 1).
    */
    PROTECTED nAncho

    **/
    * var int Cantidad de posiciones decimales en caso de cTipo == 'N'.
    */
    PROTECTED nDecimales

    **/
    * var bool Sin signo (unsigned), indica si el campo solo puede contener
    *          valores no negativos (en caso de cTipo == 'N').
    */
    PROTECTED lSinSigno

    **/
    * var bool Indica si el campo es obligatorio (en caso de cTipo == 'N' debe
    *          ser > 0; en caso de cTipo == 'C' no puede quedar en blanco).
    */
    PROTECTED lRequerido

    **/
    * var mixed Valor del campo.
    */
    PROTECTED vValor

    **/
    * var bool Indica si está habilitado el getter del campo.
    */
    PROTECTED lGetter

    **/
    * var bool Indica si está habilitado el setter del campo.
    */
    PROTECTED lSetter

    **/
    * var string Etiqueta del campo (ej.: 'Código: ', 'Nombre: ', 'Vigente: ').
    */
    PROTECTED cEtiqueta

    **
    * @var string Almacena el último mensaje de error ocurrido.
    */
    PROTECTED cUltimoError

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(string tcNombre, string tcTipo, int tnAncho, ;
                        int tnDecimales, string tcEtiqueta)
    * @method string obtener_nombre()
    * @method string obtener_tipo()
    * @method int obtener_ancho()
    * @method int obtener_decimales()
    * @method bool es_sin_signo()
    * @method bool es_requerido()
    * @method mixed obtener_valor()
    * @method bool permitir_getter()
    * @method bool permitir_setter()
    * @method string obtener_etiqueta()
    * @method string obtener_ultimo_error()
    * @method bool establecer_sin_signo(bool tlValor)
    * @method bool establecer_requerido(bool tlValor)
    * @method bool establecer_valor(mixed tvValor)
    * @method bool establecer_getter(bool tlValor)
    * @method bool establecer_setter(bool tlValor)
    * @method bool establecer_ultimo_error(string tcUltimoError)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa las propiedades del objeto con los valores proporcionados,
    * validando que los tipos de datos sean correctos.
    *
    * @param string tcNombre Nombre del campo (ej.: 'codigo', 'nombre').
    * @param string tcTipo Tipo de dato del campo (ej.: 'C', 'D', 'L', 'N').
    * @param int tnAncho Ancho del campo (ej.: 4, 30, 1).
    * @param int tnDecimales Cantidad de posiciones decimales en caso de
    *                        tcTipo == 'N'.
    * @param string tcEtiqueta Etiqueta del campo (ej.: 'Código: ', 'Nombre: ').
    * @return bool .T. si la inicialización se completa correctamente;
    *              .F. si ocurre un error.
    */
    FUNCTION Init
        LPARAMETERS tcNombre, tcTipo, tnAncho, tnDecimales, tcEtiqueta

        * inicio { validaciones de parámetros }
        IF PARAMETERS() < 4 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcNombre) != 'C' ;
                OR VARTYPE(tcTipo) != 'C' ;
                OR VARTYPE(tnAncho) != 'N' ;
                OR VARTYPE(tcEtiqueta) != 'C' THEN
            RETURN .F.
        ENDIF

        IF EMPTY(tcNombre) ;
                OR EMPTY(tcTipo) ;
                OR EMPTY(tnAncho) ;
                OR EMPTY(tcEtiqueta) THEN
            RETURN .F.
        ENDIF

        * Character, Date, Logical, Numeric, Datetime.
        IF !INLIST(tcTipo, 'C', 'D', 'L', 'N', 'T') THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnDecimales) == 'L' THEN
            tnDecimales = 0
        ENDIF

        IF tnDecimales > 0 THEN
            IF tnDecimales + 2 >= tnAncho THEN
                RETURN .F.
            ENDIF
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL llSinSigno, llRequerido, llGetter, llSetter, ;
              lcUltimoError, lvValor, lnFila

        STORE .F. TO llSinSigno, llRequerido, llGetter, llSetter
        lcUltimoError = ''

        * Valor predeterminado para el campo.
        DO CASE
        CASE tcTipo == 'C'
            lvValor = ''
        CASE tcTipo == 'D'
            lvValor = {}
        CASE tcTipo == 'L'
            lvValor = .F.
        CASE tcTipo == 'N'
            lvValor = 0
        CASE tcTipo == 'T'
            lvValor = CTOT('')
        ENDCASE

        WITH THIS
            .cNombre = tcNombre
            .cTipo = tcTipo
            .nAncho = tnAncho
            .nDecimales = tnDecimales
            .lSinSigno = llSinSigno
            .lRequerido = llRequerido
            .vValor = lvValor
            .lGetter = llGetter
            .lSetter = llSetter
            .cEtiqueta = tcEtiqueta
            .cUltimoError = lcUltimoError
        ENDWITH
    ENDFUNC

    **/
    * @section GETTERS
    */

    **/
    * Devuelve el nombre del campo.
    *
    * @return string Nombre del campo (ej.: 'codigo', 'nombre', 'vigente').
    */
    FUNCTION obtener_nombre
        RETURN THIS.cNombre
    ENDFUNC

    **/
    * Devuelve el tipo de dato del campo.
    *
    * @return string Tipo de dato del campo (ej.: 'C', 'D', 'L', 'N', 'T').
    */
    FUNCTION obtener_tipo
        RETURN THIS.cTipo
    ENDFUNC

    **/
    * Devuelve el ancho del campo.
    *
    * @return int Ancho del campo (ej.: 4, 30, 1).
    */
    FUNCTION obtener_ancho
        RETURN THIS.nAncho
    ENDFUNC

    **/
    * Devuelve la cantidad de posiciones decimales del campo.
    *
    * @return int Cantidad de posiciones decimales en caso de cTipo == 'N'.
    */
    FUNCTION obtener_decimales
        RETURN THIS.nDecimales
    ENDFUNC

    **/
    * Devuelve si el campo numérico solo puede contener valores no negativos.
    *
    * @return bool .T. si es sin signo (unsigned); .F. en caso contrario.
    */
    FUNCTION es_sin_signo
        RETURN THIS.lSinSigno
    ENDFUNC

    **/
    * Devuelve si el campo es obligatorio.
    *
    * @return bool .T. si es obligatorio; .F. en caso contrario.
    */
    FUNCTION es_requerido
        RETURN THIS.lRequerido
    ENDFUNC

    **/
    * Devuelve el valor del campo.
    *
    * @return mixed Valor que depende del tipo de dato del campo.
    */
    FUNCTION obtener_valor
        RETURN THIS.vValor
    ENDFUNC

    **/
    * Devuelve si está habilitado el getter del campo.
    *
    * @return bool .T. si está habilitado; .F. en caso contrario.
    */
    FUNCTION permitir_getter
        RETURN THIS.lGetter
    ENDFUNC

    **/
    * Devuelve si está habilitado el setter del campo.
    *
    * @return bool .T. si está habilitado; .F. en caso contrario.
    */
    FUNCTION permitir_setter
        RETURN THIS.lSetter
    ENDFUNC

    **/
    * Devuelve la etiqueta del campo.
    *
    * @return string Etiqueta del campo (ej.: 'Código: ', 'Nombre: ').
    */
    FUNCTION obtener_etiqueta
        RETURN THIS.cEtiqueta
    ENDFUNC

    **/
    * Devuelve el último mensaje de error ocurrido.
    *
    * @return string Mensaje de error.
    */
    FUNCTION obtener_ultimo_error
        RETURN THIS.cUltimoError
    ENDFUNC

    **/
    * @section SETTERS
    */

    **/
    * Establece si el campo numérico solo puede contener valores no negativos.
    *
    * @param bool tlValor Valor lógico que se asignará a la propiedad.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_sin_signo
        LPARAMETERS tlValor

        IF VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF

        IF THIS.cTipo != 'N' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .lSinSigno = tlValor
            .es_valido()
        ENDWITH
    ENDFUNC

    **/
    * Establece si el campo es obligatorio.
    *
    * @param bool tlValor Valor lógico que se asignará a la propiedad.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_requerido
        LPARAMETERS tlValor

        IF VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .lRequerido = tlValor
            .es_valido()
        ENDWITH
    ENDFUNC

    **/
    * Establece el valor del campo.
    *
    * @param mixed tvValor Valor que se asignará a la propiedad.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_valor
        LPARAMETERS tvValor

        IF VARTYPE(tvValor) != THIS.cTipo THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .vValor = tvValor
            .es_valido()
        ENDWITH
    ENDFUNC

    **/
    * Establece si está habilitado el getter del campo.
    *
    * @param bool tlValor Valor lógico que se asignará a la propiedad.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_getter
        LPARAMETERS tlValor

        IF VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF

        THIS.lGetter = tlValor
    ENDFUNC

    **/
    * Establece si está habilitado el setter del campo.
    *
    * @param bool tlValor Valor lógico que se asignará a la propiedad.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_setter
        LPARAMETERS tlValor

        IF VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF

        THIS.lSetter = tlValor
    ENDFUNC

    **/
    * Establece el mensaje de error ocurrido.
    *
    * @param string tcUltimoError Valor que se asignará a la propiedad.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    */
    FUNCTION establecer_ultimo_error
        LPARAMETERS tcUltimoError

        IF VARTYPE(tcUltimoError) != 'C' THEN
            RETURN .F.
        ENDIF

        THIS.cUltimoError = tcUltimoError
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool es_valido()
    * @method string validar_tipo()
    * @method string validar_ancho()
    * @method string validar_sin_signo()
    * @method string validar_requerido()
    */

    **/
    * Valida el valor del campo.
    *
    * @return bool .T. si el valor del campo es válido; .F. en caso contrario.
    * @uses string validar_tipo()
    *       Para validar el tipo de dato del valor del campo.
    * @uses string validar_ancho()
    *       Para validar el ancho del valor del campo.
    * @uses string validar_sin_signo()
    *       Para validar la propiedad sin signo (unsigned) del valor campo.
    * @uses string validar_requerido()
    *       Para validar la propiedad requerido del valor campo.
    */
    PROTECTED FUNCTION es_valido
        THIS.cUltimoError = THIS.validar_tipo()

        IF EMPTY(THIS.cUltimoError) THEN
            THIS.cUltimoError = THIS.validar_ancho()
        ENDIF

        IF EMPTY(THIS.cUltimoError) THEN
            THIS.cUltimoError = THIS.validar_sin_signo()
        ENDIF

        IF EMPTY(THIS.cUltimoError) THEN
            THIS.cUltimoError = THIS.validar_requerido()
        ENDIF

        RETURN EMPTY(THIS.cUltimoError)
    ENDFUNC

    **/
    * Valida el tipo de dato del valor del campo.
    *
    * @return string
    */
    PROTECTED FUNCTION validar_tipo
        IF VARTYPE(THIS.vValor) != THIS.cTipo THEN
            DO CASE
            CASE THIS.cTipo == 'C'
                RETURN THIS.cEtiqueta + MSG_TIPO_CARACTER
            CASE THIS.cTipo == 'D'
                RETURN THIS.cEtiqueta + MSG_TIPO_FECHA
            CASE THIS.cTipo == 'L'
                RETURN THIS.cEtiqueta + MSG_TIPO_LOGICO
            CASE THIS.cTipo == 'N'
                RETURN THIS.cEtiqueta + MSG_TIPO_NUMERICO
            CASE THIS.cTipo == 'T'
                RETURN THIS.cEtiqueta + MSG_TIPO_FECHA_HORA
            ENDCASE
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida el ancho del valor del campo.
    *
    * @return string
    */
    PROTECTED FUNCTION validar_ancho
        LOCAL lnAncho

        IF THIS.cTipo == 'C' THEN
            IF LEN(THIS.vValor) > THIS.nAncho THEN
                RETURN THIS.cEtiqueta + STRTRAN(MSG_LONGITUD_MAXIMA, '{}', ;
                    ALLTRIM(STR(THIS.nAncho)))
            ENDIF
        ENDIF

        IF THIS.cTipo == 'N' THEN
            lnAncho = VAL(REPLICATE('9', THIS.nAncho))

            IF THIS.vValor > lnAncho THEN
                RETURN THIS.cEtiqueta + STRTRAN(MSG_MENOR_QUE, '{}', ;
                    ALLTRIM(STR(lnAncho + 1)))
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida la propiedad sin signo (unsigned) del valor campo.
    *
    * @return string
    */
    PROTECTED FUNCTION validar_sin_signo
        IF THIS.lSinSigno AND THIS.cTipo == 'N' AND THIS.vValor < 0 THEN
            RETURN THIS.cEtiqueta + MSG_MAYOR_O_IGUAL_A_CERO
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **/
    * Valida la propiedad requerido del valor campo.
    *
    * @return string
    */
    PROTECTED FUNCTION validar_requerido
        IF THIS.lRequerido THEN
            IF INLIST(THIS.cTipo, 'C', 'D', 'T') THEN
                IF EMPTY(THIS.vValor) THEN
                    RETURN THIS.cEtiqueta + MSG_NO_BLANCO
                ENDIF
            ENDIF

            IF THIS.cTipo == 'N' THEN
                IF THIS.vValor <= 0 THEN
                    RETURN THIS.cEtiqueta + MSG_MAYOR_QUE_CERO
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
