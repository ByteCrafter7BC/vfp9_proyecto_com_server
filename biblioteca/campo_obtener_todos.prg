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
* @file campo_obtener_todos.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Función principal (debe coincidir con el nombre del archivo).
*
* Devuelve un objeto de tipo 'Collection' con todos los campos del modelo
* especificado.
*
* Utiliza el prefijo 'campo_' como espacio de nombres (namespace).
*
* @param tcModelo Nombre del modelo a buscar.
* @return mixed object si se crea correctamente; .F. si ocurre un error.
* @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
*       Para validar si un valor es una cadena de caracteres y su longitud
*       está dentro de un rango específico.
* @uses bool campo_obtener_base()
*       Para cargar los campos del modelo base.
*/
FUNCTION campo_obtener_todos
    LPARAMETERS tcModelo

    IF !es_cadena(tcModelo) THEN
        RETURN .F.
    ENDIF

    tcModelo = LOWER(ALLTRIM(tcModelo))

    PRIVATE poCampos
    poCampos = CREATEOBJECT('Collection')

    DO CASE
    CASE tcModelo == 'barrios'
        campo_obtener_barrios()
    CASE tcModelo == 'ciudades'
        campo_obtener_ciudades()
    CASE tcModelo == 'depar'
        campo_obtener_depar()
     CASE tcModelo == 'marcas1'
        campo_obtener_base()     && Duplicado.
    CASE tcModelo == 'marcas2'
        campo_obtener_base()     && Duplicado.
    CASE tcModelo == 'proveedo'
        campo_obtener_proveedo()
    CASE tcModelo == 'rubros1'
        campo_obtener_base()     && Duplicado.
    CASE tcModelo == 'rubros2'
        campo_obtener_base()     && Duplicado.
    CASE tcModelo == 'vendedor'
        campo_obtener_depar()    && Duplicado.
    ENDCASE

    RETURN poCampos
ENDFUNC

**/
* @section FUNCIONES PRIVADAS
* @function bool campo_agregar(string tcNombre, string tcTipo, int tnAncho, ;
                                int tnDecimales, string tcEtiqueta)
* @function bool campo_establecer_getter(string tcCampo, bool tlValor)
* @function bool campo_establecer_getter_todos(bool tlValor)
* @function bool campo_establecer_requerido(string tcCampo, bool tlValor)
* @function bool campo_establecer_setter(string tcCampo, bool tlValor)
* @function bool campo_establecer_setter_todos(bool tlValor)
* @function bool campo_establecer_sin_signo(string tcCampo, bool tlValor)
* @function bool campo_existe(string tcCampo)
* @function bool cargar_campos_base()
*/

**/
* Agrega un campo a la variable privada 'poCampos'.
*
* @param string tcNombre Nombre del campo (ej.: 'codigo', 'nombre').
* @param string tcTipo Tipo de dato del campo (ej.: 'C', 'D', 'L', 'N').
* @param int tnAncho Ancho del campo (ej.: 4, 30, 1).
* @param int tnDecimales Cantidad de posiciones decimales en caso de
*                        tcTipo == 'N'.
* @param string tcEtiqueta Etiqueta del campo (ej.: 'Código: ', 'Nombre: ').
* @return bool .T. si el campo se agrega correctamente;
*              .F. si ocurre un error.
* @uses bool campo_existe(string tcCampo)
*       Para verifica si un campo existe en la variable privada 'poCampos'.
* @uses object poCampos Almacena la estructura de la tabla.
*/
FUNCTION campo_agregar
    LPARAMETERS tcNombre, tcTipo, tnAncho, tnDecimales, tcEtiqueta

    LOCAL loCampo
    loCampo = NEWOBJECT('campo', 'campo.prg', '', ;
        tcNombre, tcTipo, tnAncho, tnDecimales, tcEtiqueta)

    IF VARTYPE(loCampo) != 'O' OR campo_existe(tcNombre) THEN
        RETURN .F.
    ENDIF

    RETURN poCampos.Add(loCampo, tcNombre)
ENDFUNC

**/
* Establece el estado getter de un campo.
*
* @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
* @param tlValor Valor a asignar.
* @return bool .T. si el valor se asigna correctamente;
*              .F. en caso contrario.
* @uses bool campo_existe(string tcCampo)
*       Para verifica si un campo existe en la variable privada 'poCampos'.
* @uses object poCampos Almacena la estructura de la tabla.
*/
FUNCTION campo_establecer_getter
    LPARAMETERS tcCampo, tlValor

    IF PARAMETERS() != 2 ;
            OR !campo_existe(tcCampo) ;
            OR VARTYPE(tlValor) != 'L' THEN
        RETURN .F.
    ENDIF

    RETURN poCampos.Item(tcCampo).establecer_getter(tlValor)
ENDFUNC

**/
* Establece el estado getter de todos los campos.
*
* @param tlValor Valor a asignar.
* @return bool .T. si el valor se asigna correctamente;
*              .F. en caso contrario.
* @uses bool campo_establecer_getter(string tcCampo, bool tlValor)
*       Para establecer el estado getter de un campo.
* @uses object poCampos Almacena la estructura de la tabla.
*/
FUNCTION campo_establecer_getter_todos
    LPARAMETERS tlValor

    IF PARAMETERS() != 1 OR VARTYPE(tlValor) != 'L' THEN
        RETURN .F.
    ENDIF

    LOCAL loCampo, lcCampo

    FOR EACH loCampo IN poCampos
        lcCampo = loCampo.obtener_nombre()    && Nombre del campo.

        IF !campo_establecer_getter(lcCampo, tlValor) THEN
            RETURN .F.
        ENDIF
    ENDFOR
ENDFUNC

**/
* Establece si un campo es requerido.
*
* @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
* @param tlValor Valor a asignar.
* @return bool .T. si el valor se asigna correctamente;
*              .F. en caso contrario.
* @uses object poCampos Almacena la estructura de la tabla.
* @uses bool campo_existe(string tcCampo)
*       Para verifica si un campo existe en la variable privada 'poCampos'.
*/
FUNCTION campo_establecer_requerido
    LPARAMETERS tcCampo, tlValor

    IF PARAMETERS() != 2 ;
            OR !campo_existe(tcCampo) ;
            OR VARTYPE(tlValor) != 'L' THEN
        RETURN .F.
    ENDIF

    RETURN poCampos.Item(tcCampo).establecer_requerido(tlValor)
ENDFUNC

**/
* Establece el estado setter de un campo.
*
* @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
* @param tlValor Valor a asignar.
* @return bool .T. si el valor se asigna correctamente;
*              .F. en caso contrario.
* @uses bool campo_existe(string tcCampo)
*       Para verifica si un campo existe en la variable privada 'poCampos'.
* @uses object poCampos Almacena la estructura de la tabla.
*/
FUNCTION campo_establecer_setter
    LPARAMETERS tcCampo, tlValor

    IF PARAMETERS() != 2 ;
            OR !campo_existe(tcCampo) ;
            OR VARTYPE(tlValor) != 'L' THEN
        RETURN .F.
    ENDIF

    RETURN poCampos.Item(tcCampo).establecer_setter(tlValor)
ENDFUNC

**/
* Establece el estado setter de todos los campos.
*
* @param tlValor Valor a asignar.
* @return bool .T. si el valor se asigna correctamente;
*              .F. en caso contrario.
* @uses bool campo_establecer_setter(string tcCampo, bool tlValor)
*       Para establecer el estado setter de un campo.
* @uses object poCampos Almacena la estructura de la tabla.
*/
FUNCTION campo_establecer_setter_todos
    LPARAMETERS tlValor

    IF PARAMETERS() != 1 OR VARTYPE(tlValor) != 'L' THEN
        RETURN .F.
    ENDIF

    LOCAL loCampo, lcCampo

    FOR EACH loCampo IN poCampos
        lcCampo = loCampo.obtener_nombre()    && Nombre del campo.

        IF !campo_establecer_setter(lcCampo, tlValor) THEN
            RETURN .F.
        ENDIF
    ENDFOR
ENDFUNC

**/
* Establece si un campo de tipo numérico acepta números negativos.
*
* @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
* @param tlValor Valor a asignar.
* @return bool .T. si el valor se asigna correctamente;
*              .F. en caso contrario.
* @uses bool campo_existe(string tcCampo)
*       Para verifica si un campo existe en la variable privada 'poCampos'.
* @uses object poCampos Almacena la estructura de la tabla.
*/
FUNCTION campo_establecer_sin_signo
    LPARAMETERS tcCampo, tlValor

    IF PARAMETERS() != 2 ;
            OR !campo_existe(tcCampo) ;
            OR VARTYPE(tlValor) != 'L' THEN
        RETURN .F.
    ENDIF

    RETURN poCampos.Item(tcCampo).establecer_sin_signo(tlValor)
ENDFUNC

**/
* Verifica si un campo existe en la variable privada 'poCampos'.
*
* @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
* @return bool .T. si el campo existe o si ocurre un error;
*              .F. si el campo no existe.
* @uses object poCampos Almacena la estructura de la tabla.
*/
FUNCTION campo_existe
    LPARAMETERS tcCampo

    IF VARTYPE(tcCampo) != 'C' ;
            OR EMPTY(tcCampo) ;
            OR VARTYPE(poCampos) != 'O' THEN
        RETURN .T.
    ENDIF

    RETURN poCampos.GetKey(tcCampo) > 0
ENDFUNC

**/
* @section IMPLEMENTACIÓN DE MODELOS
*/

**/
* Carga los campos del modelo 'barrios'.
*
* @return bool .T. si la carga se completa correctamente;
*              .F. si ocurre un error.
* @uses bool campo_agregar(string tcCampo, string tcTipo, int tnAncho, ;
                            int tnDecimales, string tcEtiqueta)
*       Para agregar un campo a la variable privada 'poCampos'.
* @uses bool campo_establecer_sin_signo(string tcCampo, bool tlValor)
*       Para establecer si un campo de tipo numérico acepta números
*       negativos.
* @uses bool campo_establecer_requerido(string tcCampo, bool tlValor)
*       Para establecer si un campo es requerido.
* @uses bool campo_establecer_getter_todos(bool tlValor)
*       Para establecer el estado getter de todos los campos.
*/
FUNCTION campo_obtener_barrios
    * Agrega todos los campos.
    IF !campo_agregar('codigo', 'N', 5, , 'Código: ') ;
            OR !campo_agregar('nombre', 'C', 30, , 'Nombre: ') ;
            OR !campo_agregar('departamen', 'N', 3, , 'Depart.: ') ;
            OR !campo_agregar('ciudad', 'N', 5, , 'Ciudad: ') ;
            OR !campo_agregar('vigente', 'L', 1, , 'Vigente: ') THEN
        RETURN .F.
    ENDIF

    * Establece todos los campos sin signo (unsigned).
    IF !campo_establecer_sin_signo('codigo', .T.) ;
            OR !campo_establecer_sin_signo('departamen', .T.) ;
            OR !campo_establecer_sin_signo('ciudad', .T.) THEN
        RETURN .F.
    ENDIF

    * Establece todos los campos requeridos.
    IF !campo_establecer_requerido('codigo', .T.) ;
            OR !campo_establecer_requerido('nombre', .T.) ;
            OR !campo_establecer_requerido('departamen', .T.) ;
            OR !campo_establecer_requerido('ciudad', .T.) ;
            OR !campo_establecer_requerido('vigente', .T.) THEN
        RETURN .F.
    ENDIF

    * Establece todos los getter a verdadero (.T.).
    IF !campo_establecer_getter_todos(.T.) THEN
        RETURN .F.
    ENDIF
ENDFUNC

**/
* Carga los campos del modelo 'ciudades'.
*
* @return bool .T. si la carga se completa correctamente;
*              .F. si ocurre un error.
* @uses bool campo_agregar(string tcCampo, string tcTipo, int tnAncho, ;
                            int tnDecimales, string tcEtiqueta)
*       Para agregar un campo a la variable privada 'poCampos'.
* @uses bool campo_establecer_sin_signo(string tcCampo, bool tlValor)
*       Para establecer si un campo de tipo numérico acepta números
*       negativos.
* @uses bool campo_establecer_requerido(string tcCampo, bool tlValor)
*       Para establecer si un campo es requerido.
* @uses bool campo_establecer_getter_todos(bool tlValor)
*       Para establecer el estado getter de todos los campos.
*/
FUNCTION campo_obtener_ciudades
    * Agrega todos los campos.
    IF !campo_agregar('codigo', 'N', 5, , 'Código: ') ;
            OR !campo_agregar('nombre', 'C', 30, , 'Nombre: ') ;
            OR !campo_agregar('departamen', 'N', 3, , 'Depart.: ') ;
            OR !campo_agregar('sifen', 'N', 5, , 'Ciudad: ') ;
            OR !campo_agregar('vigente', 'L', 1, , 'Vigente: ') THEN
        RETURN .F.
    ENDIF

    * Establece todos los campos sin signo (unsigned).
    IF !campo_establecer_sin_signo('codigo', .T.) ;
            OR !campo_establecer_sin_signo('departamen', .T.) ;
            OR !campo_establecer_sin_signo('sifen', .T.) THEN
        RETURN .F.
    ENDIF

    * Establece todos los campos requeridos.
    IF !campo_establecer_requerido('codigo', .T.) ;
            OR !campo_establecer_requerido('nombre', .T.) ;
            OR !campo_establecer_requerido('departamen', .T.) ;
            OR !campo_establecer_requerido('sifen', .T.) ;
            OR !campo_establecer_requerido('vigente', .T.) THEN
        RETURN .F.
    ENDIF

    * Establece todos los getter a verdadero (.T.).
    IF !campo_establecer_getter_todos(.T.) THEN
        RETURN .F.
    ENDIF
ENDFUNC

**/
* Carga los campos del modelo 'depar'.
*
* @return bool .T. si la carga se completa correctamente;
*              .F. si ocurre un error.
* @uses bool campo_agregar(string tcCampo, string tcTipo, int tnAncho, ;
                            int tnDecimales, string tcEtiqueta)
*       Para agregar un campo a la variable privada 'poCampos'.
* @uses bool campo_establecer_sin_signo(string tcCampo, bool tlValor)
*       Para establecer si un campo de tipo numérico acepta números
*       negativos.
* @uses bool campo_establecer_requerido(string tcCampo, bool tlValor)
*       Para establecer si un campo es requerido.
* @uses bool campo_establecer_getter_todos(bool tlValor)
*       Para establecer el estado getter de todos los campos.
*/
FUNCTION campo_obtener_depar
    * Agrega todos los campos.
    IF !campo_agregar('codigo', 'N', 3, , 'Código: ') ;
            OR !campo_agregar('nombre', 'C', 30, , 'Nombre: ') ;
            OR !campo_agregar('vigente', 'L', 1, , 'Vigente: ') THEN
        RETURN .F.
    ENDIF

    * Establece todos los campos sin signo (unsigned).
    IF !campo_establecer_sin_signo('codigo', .T.) THEN
        RETURN .F.
    ENDIF

    * Establece todos los campos requeridos.
    IF !campo_establecer_requerido('codigo', .T.) ;
            OR !campo_establecer_requerido('nombre', .T.) ;
            OR !campo_establecer_requerido('vigente', .T.) THEN
        RETURN .F.
    ENDIF

    * Establece todos los getter a verdadero (.T.).
    IF !campo_establecer_getter_todos(.T.) THEN
        RETURN .F.
    ENDIF
ENDFUNC

**/
* Carga los campos del modelo base.
*
* @return bool .T. si la carga se completa correctamente;
*              .F. si ocurre un error.
* @uses bool campo_agregar(string tcCampo, string tcTipo, int tnAncho, ;
                            int tnDecimales, string tcEtiqueta)
*       Para agregar un campo a la variable privada 'poCampos'.
* @uses bool campo_establecer_sin_signo(string tcCampo, bool tlValor)
*       Para establecer si un campo de tipo numérico acepta números
*       negativos.
* @uses bool campo_establecer_requerido(string tcCampo, bool tlValor)
*       Para establecer si un campo es requerido.
* @uses bool campo_establecer_getter_todos(bool tlValor)
*       Para establecer el estado getter de todos los campos.
*/
FUNCTION campo_obtener_base
    * Agrega todos los campos.
    IF !campo_agregar('codigo', 'N', 4, , 'Código: ') ;
            OR !campo_agregar('nombre', 'C', 30, , 'Nombre: ') ;
            OR !campo_agregar('vigente', 'L', 1, , 'Vigente: ') THEN
        RETURN .F.
    ENDIF

    * Establece todos los campos sin signo (unsigned).
    IF !campo_establecer_sin_signo('codigo', .T.) THEN
        RETURN .F.
    ENDIF

    * Establece todos los campos requeridos.
    IF !campo_establecer_requerido('codigo', .T.) ;
            OR !campo_establecer_requerido('nombre', .T.) ;
            OR !campo_establecer_requerido('vigente', .T.) THEN
        RETURN .F.
    ENDIF

    * Establece todos los getter a verdadero (.T.).
    IF !campo_establecer_getter_todos(.T.) THEN
        RETURN .F.
    ENDIF
ENDFUNC

**/
* Carga los campos del modelo 'proveedo'.
*
* @return bool .T. si la carga se completa correctamente;
*              .F. si ocurre un error.
* @uses bool campo_agregar(string tcCampo, string tcTipo, int tnAncho, ;
                            int tnDecimales, string tcEtiqueta)
*       Para agregar un campo a la variable privada 'poCampos'.
* @uses bool campo_establecer_sin_signo(string tcCampo, bool tlValor)
*       Para establecer si un campo de tipo numérico acepta números
*       negativos.
* @uses bool campo_establecer_requerido(string tcCampo, bool tlValor)
*       Para establecer si un campo es requerido.
* @uses bool campo_establecer_getter_todos(bool tlValor)
*       Para establecer el estado getter de todos los campos.
*/
FUNCTION campo_obtener_proveedo
    * Agrega todos los campos.
    IF !campo_agregar('codigo', 'N', 5, , 'Código: ') ;
            OR !campo_agregar('nombre', 'C', 40, , 'Nombre: ') ;
            OR !campo_agregar('direc1', 'C', 60, , ;
                'Línea 1 de la dirección: ') ;
            OR !campo_agregar('direc2', 'C', 60, , ;
                'Línea 2 de la dirección: ') ;
            OR !campo_agregar('ciudad', 'C', 25, , 'Ciudad: ') ;
            OR !campo_agregar('telefono', 'C', 40, , 'Teléfono: ') ;
            OR !campo_agregar('fax', 'C', 25, , 'Fax: ') ;
            OR !campo_agregar('e_mail', 'C', 60, , 'E-mail: ') ;
            OR !campo_agregar('ruc', 'C', 15, , 'RUC: ') ;
            OR !campo_agregar('dias_plazo', 'N', 3, , 'Días de plazo: ') ;
            OR !campo_agregar('dueno', 'C', 40, , 'Propietario: ') ;
            OR !campo_agregar('teldueno', 'C', 25, , ;
                'Teléfono del propietario: ') ;
            OR !campo_agregar('gtegral', 'C', 40, , 'Gerente general: ') ;
            OR !campo_agregar('telgg', 'C', 25, , ;
                'Teléfono del gerente general: ') ;
            OR !campo_agregar('gteventas', 'C', 40, , 'Gerente de ventas: ') ;
            OR !campo_agregar('telgv', 'C', 25, , ;
                'Teléfono del gerente de ventas: ') ;
            OR !campo_agregar('gtemkg', 'C', 40, , 'Gerente de marketing: ') ;
            OR !campo_agregar('telgm', 'C', 25, , ;
                'Teléfono del gerente de marketing: ') ;
            OR !campo_agregar('stecnico', 'C', 40, , 'Servicio técnico: ') ;
            OR !campo_agregar('stdirec1', 'C', 60, , ;
                'Línea 1 de la dirección del servicio técnico: ') ;
            OR !campo_agregar('stdirec2', 'C', 60, , ;
                'Línea 2 de la dirección del servicio técnico: ') ;
            OR !campo_agregar('sttel', 'C', 25, , ;
                'Teléfono del servicio técnico: ') ;
            OR !campo_agregar('sthablar1', 'C', 60, , ;
                'Contacto del servicio técnico: ') ;
            OR !campo_agregar('vendedor1', 'C', 40, , ;
                'Nombre del vendedor de la línea de artículos 1: ') ;
            OR !campo_agregar('larti1', 'C', 25, , 'Línea de artículos 1: ') ;
            OR !campo_agregar('tvend1', 'C', 25, , ;
                'Teléfono del vendedor de la línea de artículos 1: ') ;
            OR !campo_agregar('vendedor2', 'C', 40, , ;
                'Nombre del vendedor de la línea de artículos 2: ') ;
            OR !campo_agregar('larti2', 'C', 25, , 'Línea de artículos 2: ') ;
            OR !campo_agregar('tvend2', 'C', 25, , ;
                'Teléfono del vendedor de la línea de artículos 2: ') ;
            OR !campo_agregar('vendedor3', 'C', 40, , ;
                'Nombre del vendedor de la línea de artículos 3: ') ;
            OR !campo_agregar('larti3', 'C', 25, , 'Línea de artículos 3: ') ;
            OR !campo_agregar('tvend3', 'C', 25, , ;
                'Teléfono del vendedor de la línea de artículos 3: ') ;
            OR !campo_agregar('vendedor4', 'C', 40, , ;
                'Nombre del vendedor de la línea de artículos 4: ') ;
            OR !campo_agregar('larti4', 'C', 25, , 'Línea de artículos 4: ') ;
            OR !campo_agregar('tvend4', 'C', 25, , ;
                'Teléfono del vendedor de la línea de artículos 4: ') ;
            OR !campo_agregar('vendedor5', 'C', 40, , ;
                'Nombre del vendedor de la línea de artículos 5: ') ;
            OR !campo_agregar('larti5', 'C', 25, , 'Línea de artículos 5: ') ;
            OR !campo_agregar('tvend5', 'C', 25, , ;
                'Teléfono del vendedor de la línea de artículos 5: ') ;
            OR !campo_agregar('saldo_actu', 'N', 12, , 'Saldo adeudado PYG: ') ;
            OR !campo_agregar('saldo_usd', 'N', 12, , 'Saldo adeudado USD: ') ;
            OR !campo_agregar('vigente', 'C', 1, , 'Vigente: ') THEN
        RETURN .F.
    ENDIF

    * Establece todos los campos sin signo (unsigned).
    IF !campo_establecer_sin_signo('codigo', .T.) THEN
        RETURN .F.
    ENDIF

    * Establece todos los campos requeridos.
    IF !campo_establecer_requerido('codigo', .T.) ;
            OR !campo_establecer_requerido('nombre', .T.) ;
            OR !campo_establecer_requerido('ruc', .T.) ;
            OR !campo_establecer_requerido('vigente', .T.) THEN
        RETURN .F.
    ENDIF

    * Establece todos los getter a verdadero (.T.).
    IF !campo_establecer_getter_todos(.T.) THEN
        RETURN .F.
    ENDIF
ENDFUNC
