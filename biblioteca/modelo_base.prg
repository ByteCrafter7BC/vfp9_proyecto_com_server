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
    * @method mixed campo_obtener(string tcCampo)
    * @method object campo_obtener_todos()
    * @method bool es_igual(object toModelo)
    * @method bool establecer(string tcCampo)
    * @method mixed obtener(string tcCampo)
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
    * @uses bool es_numero(int tnNumero, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es numérico y se encuentra dentro de un
    *       rango específico.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses bool campo_cargar()
    *       Para cargar los campos a la propiedad protegida 'oCampos'.
    * @uses bool campo_establecer_valor(string tcCampo, mixed tvValor)
    *       Para establecer el valor de un campo.
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tlVigente

        IF PARAMETERS() != 3 ;
                OR !es_numero(tnCodigo, 0) ;
                OR !es_cadena(tcNombre, 0) ;
                OR !es_logico(tlVigente) THEN
            RETURN .F.
        ENDIF

        IF !THIS.campo_cargar() THEN
            RETURN .F.
        ENDIF

        tcNombre = UPPER(ALLTRIM(tcNombre))

        IF !THIS.campo_establecer_valor('codigo', tnCodigo) ;
                OR !THIS.campo_establecer_valor('nombre', tcNombre) ;
                OR !THIS.campo_establecer_valor('vigente', tlVigente) THEN
            RETURN .F.
        ENDIF
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
    * @return mixed object si el campo existe; .F. si ocurre un error.
    * @uses bool campo_existe(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    FUNCTION campo_obtener
        LPARAMETERS tcCampo

        IF PARAMETERS() != 1 OR !THIS.campo_existe(tcCampo) THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo)
    ENDFUNC

    **/
    * Devuelve un objeto con todos los campos del modelo.
    *
    * @return object Objeto de tipo 'Collection'.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    FUNCTION campo_obtener_todos
        RETURN THIS.oCampos
    ENDFUNC

    **/
    * Compara si dos objetos modelo son idénticos.
    *
    * Compara las propiedades 'código', 'nombre' y 'vigente' del objeto actual
    * con las del otro objeto modelo.
    *
    * @param object toModelo Modelo con el que se va a comparar.
    * @return bool .T. si los objetos son idénticos, o .F. si no lo son.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses mixed campo_obtener_valor(string tcCampo)
    *       Para obtener el valor de un campo.
    */
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF PARAMETERS() != 1 OR !es_objeto(toModelo, THIS.Name) THEN
            RETURN .F.
        ENDIF

        LOCAL lnCodigo, lcNombre, llVigente

        WITH THIS
            lnCodigo = .campo_obtener_valor('codigo')
            lcNombre = .campo_obtener_valor('nombre')
            llVigente = .campo_obtener_valor('vigente')
        ENDWITH

        IF toModelo.obtener('codigo') != lnCodigo ;
                OR toModelo.obtener('nombre') != lcNombre ;
                OR toModelo.obtener('vigente') != llVigente THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Establece el valor de un campo, si la propiedad setter es igual a .T.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @param mixed tvValor Valor del campo a asignar.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    * @uses bool campo_existe(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses mixed campo_obtener(string tcCampo)
    *       Para obtener un objeto con todas las propiedades de un campo.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    */
    FUNCTION establecer
        LPARAMETERS tcCampo, tvValor

        IF PARAMETERS() != 2 OR !THIS.campo_existe(tcCampo) THEN
            RETURN .F.
        ENDIF

        LOCAL loCampo
        loCampo = THIS.campo_obtener(tcCampo)

        IF !es_objeto(loCampo) ;
                OR !loCampo.permitir_setter() ;
                OR VARTYPE(tvValor) != loCampo.obtener_tipo() THEN
            RETURN .F.
        ENDIF

        RETURN loCampo.establecer_valor(tvValor)
    ENDFUNC

    **/
    * Devuelve el valor de un campo, si la propiedad getter es igual a .T.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @return mixed Si se ejecuta correctamente, devuelve uno de los siguientes
    *               tipos de datos: 'C', 'D', 'L', 'N' o 'T'. En caso contrario,
    *               devuelve NULL.
    * @uses bool campo_existe(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses mixed campo_obtener(string tcCampo)
    *       Para obtener un objeto con todas las propiedades de un campo.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    */
    FUNCTION obtener
        LPARAMETERS tcCampo

        IF PARAMETERS() != 1 OR !THIS.campo_existe(tcCampo) THEN
            RETURN NULL
        ENDIF

        LOCAL loCampo
        loCampo = THIS.campo_obtener(tcCampo)

        IF !es_objeto(loCampo) OR !loCampo.permitir_getter() THEN
            RETURN NULL
        ENDIF

        RETURN loCampo.obtener_valor()
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool campo_cargar()
    * @method bool campo_establecer_getter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_getter_todos(bool tlValor)
    * @method bool campo_establecer_setter(string tcCampo, bool tlValor)
    * @method bool campo_establecer_setter_todos(bool tlValor)
    * @method bool campo_establecer_valor(string tcCampo, mixed tvValor)
    * @method bool campo_existe(string tcCampo)
    * @method mixed campo_obtener_valor(string tcCampo)
    */

    **/
    * Carga los campos a la propiedad protegida 'oCampos'.
    *
    * @return bool .T. si la carga se completa correctamente;
    *              .F. si ocurre un error.
    * @uses mixed campo_obtener_todos(string tcModelo)
    *       Para cargar los campos del modelo.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION campo_cargar
        LOCAL loCampos
        loCampos = campo_obtener_todos(THIS.Name)

        IF !es_objeto(loCampos) OR loCampos.Count == 0 THEN
            RETURN .F.
        ENDIF

        THIS.oCampos = loCampos
    ENDFUNC

    **/
    * Establece el estado getter de un campo.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses bool campo_existe(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION campo_establecer_getter
        LPARAMETERS tcCampo, tlValor

        IF PARAMETERS() != 2 ;
                OR !THIS.campo_existe(tcCampo) ;
                OR !es_logico(tlValor) THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo).establecer_getter(tlValor)
    ENDFUNC

    **/
    * Establece el estado getter de todos los campos.
    *
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION campo_establecer_getter_todos
        LPARAMETERS tlValor

        IF PARAMETERS() != 1 OR !es_logico(tlValor) THEN
            RETURN .F.
        ENDIF

        LOCAL loCampo

        FOR EACH loCampo IN THIS.oCampos
            IF !loCampo.establecer_getter(tlValor) THEN
                RETURN .F.
            ENDIF
        ENDFOR
    ENDFUNC

    **/
    * Establece el estado setter de un campo.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses bool campo_existe(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION campo_establecer_setter
        LPARAMETERS tcCampo, tlValor

        IF PARAMETERS() != 2 ;
                OR !THIS.campo_existe(tcCampo) ;
                OR !es_logico(tlValor) THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo).establecer_setter(tlValor)
    ENDFUNC

    **/
    * Establece el estado setter de todos los campos.
    *
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION campo_establecer_setter_todos
        LPARAMETERS tlValor

        IF PARAMETERS() != 1 OR !es_logico(tlValor) THEN
            RETURN .F.
        ENDIF

        LOCAL loCampo

        FOR EACH loCampo IN THIS.oCampos
            IF !loCampo.establecer_setter(tlValor) THEN
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
    * @uses bool campo_existe(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION campo_establecer_valor
        LPARAMETERS tcCampo, tvValor

        IF PARAMETERS() != 2 ;
                OR !THIS.campo_existe(tcCampo) ;
                OR !INLIST(VARTYPE(tvValor), 'C', 'D', 'L', 'N', 'T') THEN
            RETURN .F.
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo).establecer_valor(tvValor)
    ENDFUNC

    **/
    * Verifica si un campo existe en la propiedad protegida 'oCampos'.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @return bool .T. si el campo existe o si ocurre un error;
    *              .F. si el campo no existe.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION campo_existe
        LPARAMETERS tcCampo

        IF PARAMETERS() != 1 ;
                OR !es_cadena(tcCampo) ;
                OR !es_objeto(THIS.oCampos) THEN
            RETURN .T.
        ENDIF

        RETURN THIS.oCampos.GetKey(tcCampo) > 0
    ENDFUNC

    **/
    * Devuelve el valor de un campo.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @return mixed Si se ejecuta correctamente, devuelve uno de los siguientes
    *               tipos de datos: 'C', 'D', 'L', 'N' o 'T'. En caso contrario,
    *               devuelve NULL.
    * @uses bool campo_existe(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'oCampos'.
    * @uses object oCampos Almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION campo_obtener_valor
        LPARAMETERS tcCampo

        IF PARAMETERS() != 1 OR !THIS.campo_existe(tcCampo) THEN
            RETURN NULL
        ENDIF

        RETURN THIS.oCampos.Item(tcCampo).obtener_valor()
    ENDFUNC
ENDDEFINE
