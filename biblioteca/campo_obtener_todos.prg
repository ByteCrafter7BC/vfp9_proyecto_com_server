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
* @file campo_obtener_todos.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Funci�n principal (debe coincidir con el nombre del archivo).
*
* Devuelve un objeto de tipo 'Collection' con todos los campos del modelo
* especificado.
*
* Utiliza el prefijo 'campo_' como espacio de nombres (namespace).
*
* @return mixed object si se crea correctamente; .F. si ocurre un error.
* @uses bool campo_obtener_base()
*       Para cargar los campos del modelo base.
*/
FUNCTION campo_obtener_todos
    LPARAMETERS tcModelo

    IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
        RETURN .F.
    ENDIF

    PRIVATE poCampos
    poCampos = CREATEOBJECT('Collection')

    DO CASE
    CASE tcModelo == 'marcas1'
        campo_obtener_base()
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
* @param string tcEtiqueta Etiqueta del campo (ej.: 'C�digo: ', 'Nombre: ').
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
* Establece si un campo de tipo num�rico acepta n�meros negativos.
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
* @section IMPLEMENTACI�N DE MODELOS
*/

**/
* Carga los campos del modelo base.
*
* @return bool .T. si la carga se completa correctamente;
*              .F. si ocurre un error.
* @uses bool campo_agregar(string tcCampo, string tcTipo, int tnAncho, ;
                            int tnDecimales, string tcEtiqueta)
*       Para agregar un campo a la variable privada 'poCampos'.
* @uses bool campo_establecer_sin_signo(string tcCampo, bool tlValor)
*       Para establecer si un campo de tipo num�rico acepta n�meros
*       negativos.
* @uses bool campo_establecer_requerido(string tcCampo, bool tlValor)
*       Para establecer si un campo es requerido.
* @uses bool campo_establecer_getter_todos(bool tlValor)
*       Para establecer el estado getter de todos los campos.
*/
FUNCTION campo_obtener_base
    * Agrega todos los campos.
    IF !campo_agregar('codigo', 'N', 4, , 'C�digo: ') ;
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
