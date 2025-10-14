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
* @file modelo_base.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @abstract
* @class modelo_base
* @extends Custom
*/

**/
* Clase base abstracta para modelos de datos.
*
* Esta clase sirve como plantilla para los objetos que representan los datos
* de una tabla. Define las propiedades y métodos comunes (código, nombre,
* estado de vigencia) que deben tener todos los modelos para interactuar con
* las clases DAO (Data Access Object).
*
* Su propósito es asegurar la consistencia y la reutilización de código en
* todas las clases modelo.
*/
DEFINE CLASS modelo_base AS Custom
    **/
    * @var object Almacena la estructura de la tabla.
    */
    PROTECTED oCampos

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool Init(int tnCodigo, string tcNombre, bool tlVigente)
    * @method mixed obtener(string tcCampo)
    * @method bool establecer(string tcCampo)
    * @method bool es_igual(object toModelo)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa las propiedades del objeto con los valores proporcionados,
    * validando que los tipos de datos sean correctos.
    *
    * @param int tnCodigo Código numérico único del modelo.
    * @param string tcNombre Nombre descriptivo del modelo.
    * @param bool tlVigente Estado de vigencia del modelo.
    * @return bool .T. si la inicialización se completa correctamente;
    *              .F. si ocurre un error.
    * @uses bool cargar_campos()
    *       Para cargar los campos a la propiedad protegida 'oCampos'.
    * @uses bool establecer_campo_valor(string tcCampo, mixed tvValor)
    *       Para establecer el valor de un campo.
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tlVigente

        IF VARTYPE(tnCodigo) != 'N' ;
                OR VARTYPE(tcNombre) != 'C' ;
                OR VARTYPE(tlVigente) != 'L' THEN
            RETURN .F.
        ENDIF

        THIS.oCampos = CREATEOBJECT('Collection')

        IF !THIS.cargar_campos() THEN
            RETURN .F.
        ENDIF

        IF !THIS.establecer_campo_valor('codigo', tnCodigo) ;
                OR !THIS.establecer_campo_valor('nombre', tcNombre) ;
                OR !THIS.establecer_campo_valor('vigente', tlVigente) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Devuelve el valor de un campo, si la propiedad getter es igual a .T.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @return mixed Si se ejecuta correctamente, devuelve uno de los siguientes
    *               tipos de datos: 'C', 'D', 'L', 'N' o 'T'. En caso contrario,
    *               devuelve NULL.
    * @uses bool existe_campo(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses mixed obtener_campo(string tcCampo)
    *       Para obtener un objeto con todas las propiedades de un campo.
    */
    FUNCTION obtener
        LPARAMETERS tcCampo

        IF PARAMETERS() != 1 OR !THIS.existe_campo(tcCampo) THEN
            RETURN NULL
        ENDIF

        LOCAL loCampo
        loCampo = THIS.obtener_campo(tcCampo)

        IF VARTYPE(loCampo) != 'O' OR !loCampo.permitir_getter() THEN
            RETURN NULL
        ENDIF

        RETURN loCampo.obtener_valor()
    ENDFUNC

    **/
    * Establece el valor de un campo, si la propiedad setter es igual a .T.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @param mixed tvValor Valor del campo a asignar.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    * @uses bool existe_campo(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses mixed obtener_campo(string tcCampo)
    *       Para obtener un objeto con todas las propiedades de un campo.
    * @uses bool establecer_campo_valor(string tcCampo, mixed tvValor)
    *       Para establecer el valor de un campo.
    */
    FUNCTION establecer
        LPARAMETERS tcCampo, tvValor

        IF PARAMETERS() != 2 OR !THIS.existe_campo(tcCampo) THEN
            RETURN .F.
        ENDIF

        LOCAL loCampo
        loCampo = THIS.obtener_campo(tcCampo)

        IF VARTYPE(loCampo) != 'O' ;
                OR !loCampo.permitir_setter() ;
                OR VARTYPE(tvValor) != loCampo.obtener_tipo() THEN
            RETURN .F.
        ENDIF

        RETURN THIS.establecer_campo_valor(tcCampo, tvValor)
    ENDFUNC

    **/
    * Compara si dos objetos modelo son idénticos.
    *
    * Compara las propiedades 'código', 'nombre' y 'vigente' del objeto actual
    * con las del otro objeto modelo.
    *
    * @param object toModelo Modelo con el que se va a comparar.
    * @return bool .T. si los objetos son idénticos, o .F. si no lo son.
    * @uses mixed obtener_campo_valor(string tcCampo)
    *       Para obtener el valor de un campo.
    */
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF VARTYPE(toModelo) != 'O' ;
                OR LOWER(toModelo.Class) != LOWER(THIS.Name) THEN
            RETURN .F.
        ENDIF

        LOCAL lnCodigo, lcNombre, llVigente

        WITH THIS
            lnCodigo = .obtener_campo_valor('codigo')
            lcNombre = .obtener_campo_valor('nombre')
            llVigente = .obtener_campo_valor('vigente')
        ENDWITH

        IF toModelo.obtener('codigo') != lnCodigo ;
                OR toModelo.obtener('nombre') != lcNombre ;
                OR toModelo.obtener('vigente') != llVigente THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool cargar_campos()
    * @method bool cargar_campos_base()
    * @method bool agregar_campo(string tcNombre, string tcTipo, int tnAncho, ;
                                 int tnDecimales, string tcEtiqueta)
    * @method bool existe_campo(string tcCampo)
    * @method bool establecer_campo_sin_signo(string tcCampo, bool tlValor)
    * @method bool establecer_campo_requerido(string tcCampo, bool tlValor)
    * @method bool establecer_campo_getter(string tcCampo, bool tlValor)
    * @method bool establecer_campo_setter(string tcCampo, bool tlValor)
    * @method bool establecer_campo_getter_todos(bool tlValor)
    * @method bool establecer_campo_setter_todos(bool tlValor)
    * @method bool establecer_campo_valor(string tcCampo, mixed tvValor)
    * @method mixed obtener_campo_valor(string tcCampo)
    * @method mixed obtener_campo(string tcCampo)
    */

    **/
    * Carga los campos a la propiedad protegida 'oCampos'.
    *
    * @return bool .T. si la carga se completa correctamente;
    *              .F. si ocurre un error.
    * @uses bool cargar_campos_base()
    *       Para cargar los campos del modelo base.
    */
    PROTECTED FUNCTION cargar_campos
        LOCAL lcModelo
        lcModelo = LOWER(THIS.Name)

        DO CASE
        CASE lcModelo == 'marcas1'
            RETURN THIS.cargar_campos_base()
        ENDCASE

        RETURN .F.
    ENDFUNC

    **/
    * Carga los campos del modelo base.
    *
    * @return bool .T. si la carga se completa correctamente;
    *              .F. si ocurre un error.
    * @uses bool agregar_campo(string tcCampo, string tcTipo, int tnAncho, ;
                               int tnDecimales, string tcEtiqueta)
    *       Para agregar un campo a la propiedad protegida 'oCampos'.
    * @uses bool establecer_campo_sin_signo(string tcCampo, bool tlValor)
    *       Para establecer si un campo de tipo numérico acepta números
    *       negativos.
    * @uses bool establecer_campo_requerido(string tcCampo, bool tlValor)
    *       Para establecer si un campo es requerido.
    * @uses bool establecer_campo_getter_todos(bool tlValor)
    *       Para establecer el estado getter de todos los campos.
    */
    PROTECTED FUNCTION cargar_campos_base
        * Agrega todos los campos.
        IF !THIS.agregar_campo('codigo', 'N', 4, , 'Código: ') ;
                OR !THIS.agregar_campo('nombre', 'C', 30, , 'Nombre: ') ;
                OR !THIS.agregar_campo('vigente', 'L', 1, , 'Vigente: ') THEN
            RETURN .F.
        ENDIF

        * Establece todos los campos sin signo (unsigned).
        IF !THIS.establecer_campo_sin_signo('codigo', .T.) THEN
            RETURN .F.
        ENDIF

        * Establece todos los campos requeridos.
        IF !THIS.establecer_campo_requerido('codigo', .T.) ;
                OR !THIS.establecer_campo_requerido('nombre', .T.) ;
                OR !THIS.establecer_campo_requerido('vigente', .T.) THEN
            RETURN .F.
        ENDIF

        * Establece todos los getter a verdadero (.T.).
        IF !THIS.establecer_campo_getter_todos(.T.) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Agrega un campo a la propiedad protegida 'oCampos'.
    *
    * @param string tcNombre Nombre del campo (ej.: 'codigo', 'nombre').
    * @param string tcTipo Tipo de dato del campo (ej.: 'C', 'D', 'L', 'N').
    * @param int tnAncho Ancho del campo (ej.: 4, 30, 1).
    * @param int tnDecimales Cantidad de posiciones decimales en caso de
    *                        tcTipo == 'N'.
    * @param string tcEtiqueta Etiqueta del campo (ej.: 'Código: ', 'Nombre: ').
    * @return bool .T. si el campo se agrega correctamente;
    *              .F. si ocurre un error.
    * @uses bool existe_campo(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION agregar_campo
        LPARAMETERS tcNombre, tcTipo, tnAncho, tnDecimales, tcEtiqueta

        LOCAL loCampo
        loCampo = NEWOBJECT('campo', 'campo.prg', '', ;
            tcNombre, tcTipo, tnAncho, tnDecimales, tcEtiqueta)

        IF VARTYPE(loCampo) != 'O' OR THIS.existe_campo(tcNombre) THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCampos.Add(loCampo, tcNombre)
    ENDFUNC

    **/
    * Verifica si un campo existe en la propiedad protegida 'oCampos'.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @return bool .T. si el campo existe o si ocurre un error;
    *              .F. si el campo no existe.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION existe_campo
        LPARAMETERS tcCampo

        IF VARTYPE(tcCampo) != 'C' ;
                OR EMPTY(tcCampo) ;
                OR VARTYPE(THIS.oCampos) != 'O' THEN
            RETURN .T.
        ENDIF

        RETURN THIS.oCampos.GetKey(tcCampo) > 0
    ENDFUNC

    **/
    * Establece si un campo de tipo numérico acepta números negativos.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses bool existe_campo(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_sin_signo
        LPARAMETERS tcCampo, tlValor

        IF PARAMETERS() != 2 ;
                OR !THIS.existe_campo(tcCampo) ;
                OR VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo).establecer_sin_signo(tlValor)
    ENDFUNC

    **/
    * Establece si un campo es requerido.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses object oCampos Almacena la estructura de la tabla.
    * @uses bool existe_campo(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    */
    PROTECTED FUNCTION establecer_campo_requerido
        LPARAMETERS tcCampo, tlValor

        IF PARAMETERS() != 2 ;
                OR !THIS.existe_campo(tcCampo) ;
                OR VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo).establecer_requerido(tlValor)
    ENDFUNC

    **/
    * Establece el estado getter de un campo.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses bool existe_campo(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_getter
        LPARAMETERS tcCampo, tlValor

        IF PARAMETERS() != 2 ;
                OR !THIS.existe_campo(tcCampo) ;
                OR VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo).establecer_getter(tlValor)
    ENDFUNC

    **/
    * Establece el estado setter de un campo.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses bool existe_campo(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_setter
        LPARAMETERS tcCampo, tlValor

        IF PARAMETERS() != 2 ;
                OR !THIS.existe_campo(tcCampo) ;
                OR VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo).establecer_setter(tlValor)
    ENDFUNC

    **/
    * Establece el estado getter de todos los campos.
    *
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses bool establecer_campo_getter(string tcCampo, bool tlValor)
    *       Para establecer el estado getter de un campo.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_getter_todos
        LPARAMETERS tlValor

        IF PARAMETERS() != 1 OR VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF

        LOCAL loCampo, lcCampo

        FOR EACH loCampo IN THIS.oCampos
            lcCampo = loCampo.obtener_nombre()    && Nombre del campo.

            IF !THIS.establecer_campo_getter(lcCampo, tlValor) THEN
                RETURN .F.
            ENDIF
        ENDFOR
    ENDFUNC

    **/
    * Establece el estado setter de todos los campos.
    *
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses bool establecer_campo_setter(string tcCampo, bool tlValor)
    *       Para establecer el estado setter de un campo.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_setter_todos
        LPARAMETERS tlValor

        IF PARAMETERS() != 1 OR VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF

        LOCAL loCampo, lcCampo

        FOR EACH loCampo IN THIS.oCampos
            lcCampo = loCampo.obtener_nombre()    && Nombre del campo.

            IF !THIS.establecer_campo_setter(lcCampo, tlValor) THEN
                RETURN .F.
            ENDIF
        ENDFOR
    ENDFUNC

    **/
    * Establece el valor de un campo.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param mixed tvValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses bool existe_campo(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_valor
        LPARAMETERS tcCampo, tvValor

        IF PARAMETERS() != 2 ;
                OR !THIS.existe_campo(tcCampo) ;
                OR !INLIST(VARTYPE(tvValor), 'C', 'D', 'L', 'N', 'T') THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo).establecer_valor(tvValor)
    ENDFUNC

    **/
    * Devuelve el valor de un campo.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @return mixed Si se ejecuta correctamente, devuelve uno de los siguientes
    *               tipos de datos: 'C', 'D', 'L', 'N' o 'T'. En caso contrario,
    *               devuelve NULL.
    * @uses bool existe_campo(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION obtener_campo_valor
        LPARAMETERS tcCampo

        IF PARAMETERS() != 1 OR !THIS.existe_campo(tcCampo) THEN
            RETURN NULL
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo).obtener_valor()
    ENDFUNC

    **/
    * Devuelve un objeto con todas las propiedades de un campo.
    *
    * Propiedades: nombre, tipo, ancho, decimales, sin_signo, requerido, valor,
    * getter, setter, etiqueta y ultimo_error.
    *
    * Para acceder a los datos del objeto se deben utilizar los métodos getters
    * correspondientes (ej: obtener_nombre(), obtener_tipo(), etc.).
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @return mixed object si el campo existe;
    *              .F. si ocurre un error.
    * @uses bool existe_campo(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION obtener_campo
        LPARAMETERS tcCampo

        IF PARAMETERS() != 1 OR !THIS.existe_campo(tcCampo) THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo)
    ENDFUNC
ENDDEFINE
