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
    * @var array Arreglo bidimensional que almacena la estructura de la tabla.
    * @structure
    *     [n, 01] = nombre del campo (ej.: 'codigo', 'nombre', 'vigente'),
    *     [n, 02] = tipo de dato del campo (ej.: 'C', 'D', 'L', 'N', 'T'),
    *     [n, 03] = ancho del campo (ej.: 4, 30, 1),
    *     [n, 04] = decimales (posiciones decimales en caso de tipo 'N'),
    *     [n, 05] = sin signo (unsigned) (en caso de tipo 'N'),
    *     [n, 06] = requerido (en caso de tipo 'N' debe ser > 0;
    *               en caso de tipo 'C' no puede quedar en blanco),
    *     [n, 07] = valor del campo,
    *     [n, 08] = getter (ej.: .T. para habilitar el getter),
    *     [n, 09] = setter (ej.: .F. para deshabilitar el setter).
    *     [n, 10] = etiqueta (ej.: 'Código: ', 'Nombre: ', 'Vigente: '),
    *     [n, 11] = ultimo error (ej.: 'Debe ser mayor que cero',
    *               'No puede quedar en blanco.').
    */
    PROTECTED aCampo[1]

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
    *       Para cargar los campos a la propiedad protegida de tipo arreglo
    *       'aCampo'.
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
    *               tipos de datos 'C', 'D', 'L', 'N' o 'T';
    *               NULL en caso contrario.
    * @uses mixed obtener_campo(string tcCampo)
    *       Para obtener un objeto con todas las propiedades de un campo.
    */
    FUNCTION obtener
        LPARAMETERS tcCampo

        * inicio { validaciones del parámetro }
        IF PARAMETERS() != 1 THEN
            RETURN NULL
        ENDIF

        IF VARTYPE(tcCampo) != 'C' OR EMPTY(tcCampo) THEN
            RETURN NULL
        ENDIF
        * fin { validaciones del parámetro }

        LOCAL loCampo
        loCampo = THIS.obtener_campo(tcCampo)

        IF VARTYPE(loCampo) != 'O' THEN
            RETURN NULL
        ENDIF

        IF !loCampo.getter THEN
            RETURN NULL
        ENDIF

        RETURN loCampo.valor
    ENDFUNC

    **/
    * Establece el valor de un campo, si la propiedad setter es igual a .T.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @param mixed tvValor Valor del campo a asignar.
    * @return bool .T. si el valor se establece correctamente;
    *              .F. en caso contrario.
    * @uses mixed obtener_campo(string tcCampo)
    *       Para obtener un objeto con todas las propiedades de un campo.
    * @uses bool establecer_campo_valor(string tcCampo, mixed tvValor)
    *       Para establecer el valor de un campo.
    */
    FUNCTION establecer
        LPARAMETERS tcCampo, tvValor

        * inicio { validaciones de parámetros }
        IF PARAMETERS() != 2 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' OR EMPTY(tcCampo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL loCampo
        loCampo = THIS.obtener_campo(tcCampo)

        IF VARTYPE(loCampo) != 'O' THEN
            RETURN .F.
        ENDIF

        IF !loCampo.setter THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tvValor) != loCampo.tipo THEN
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
    * @method bool agregar_campo(string tcCampo, string tcTipo, int tnAncho, ;
                                 int tnDecimales, string tcEtiqueta)
    * @method bool existe_campo(string tcCampo)
    * @method int posicion_campo(string tcCampo)
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
    * Carga los campos a la propiedad protegida de tipo arreglo 'aCampo'.
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
    *       Para agregar un campo a la propiedad protegida de tipo arreglo
    *       'aCampo'.
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
    * Agrega un campo a la propiedad protegida de tipo arreglo 'aCampo'.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param string tcTipo Tipo de dato del campo (ej.: 'C', 'D', 'L', 'N').
    * @patam int tnAncho Ancho del campo (ej.: 4, 30, 1),
    * @param int [tnDecimales] Posiciones decimales en caso de tipo 'N'.
    * @param string tcEtiqueta Etiqueta del campo (ej.: 'Código: ', 'Nombre: ').
    * @return bool .T. si el campo se agrega correctamente;
    *              .F. si ocurre un error.
    * @uses bool existe_campo(string tcCampo)
    *       Para verificar si un campo existe en la propiedad protegida de
    *       tipo arreglo 'aCampo'.
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION agregar_campo
        LPARAMETERS tcCampo, tcTipo, tnAncho, tnDecimales, tcEtiqueta

        * inicio { validaciones de parámetros }
        IF PARAMETERS() < 4 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' ;
                OR VARTYPE(tcTipo) != 'C' ;
                OR VARTYPE(tnAncho) != 'N' ;
                OR VARTYPE(tcEtiqueta) != 'C' THEN
            RETURN .F.
        ENDIF

        IF EMPTY(tcCampo) ;
                OR EMPTY(tcTipo) ;
                OR EMPTY(tnAncho) ;
                OR EMPTY(tcEtiqueta) THEN
            RETURN .F.
        ENDIF

        IF THIS.existe_campo(tcCampo) THEN
            RETURN .F.
        ENDIF

        * Character, Date, Logical, Numeric, Datetime
        IF !INLIST(tcTipo, 'C', 'D', 'L', 'N', 'T') THEN
            RETURN .F.
        ENDIF

        IF tcTipo == 'N' THEN
            IF !INLIST(VARTYPE(tnDecimales), 'L', 'N') THEN
                RETURN .F.
            ENDIF

            IF VARTYPE(tnDecimales) == 'N' THEN
                IF tnDecimales + 2 >= tnAncho THEN
                    RETURN .F.
                ENDIF
            ELSE
                tnDecimales = 0
            ENDIF
        ELSE
            tnDecimales = 0
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

        lnFila = IIF(VARTYPE(THIS.aCampo) != 'L', ALEN(THIS.aCampo, 1) + 1, 1)
        DIMENSION THIS.aCampo[lnFila, 11]
        **/
        * Estructura de la propiedad protegida de tipo arreglo 'aCampo'.
        *
        * [n, 01] = nombre del campo (ej.: 'codigo', 'nombre', 'vigente'),
        * [n, 02] = tipo de dato del campo (ej.: 'C', 'D', 'L', 'N', 'T'),
        * [n, 03] = ancho del campo (ej.: 4, 30, 1),
        * [n, 04] = decimales (posiciones decimales en caso de tipo 'N'),
        * [n, 05] = sin signo (unsigned) (en caso de tipo 'N'),
        * [n, 06] = requerido (en caso de tipo 'N' debe ser > 0;
        *           en caso de tipo 'C' no puede quedar en blanco),
        * [n, 07] = valor del campo,
        * [n, 08] = getter (ej.: .T. para habilitar el getter),
        * [n, 09] = setter (ej.: .F. para deshabilitar el setter).
        * [n, 10] = etiqueta (ej.: 'Código: ', 'Nombre: ', 'Vigente: '),
        * [n, 11] = ultimo error (ej.: 'Debe ser mayor que cero.',
        *           'No puede quedar en blanco.').
        */
        THIS.aCampo[lnFila, 01] = tcCampo
        THIS.aCampo[lnFila, 02] = tcTipo
        THIS.aCampo[lnFila, 03] = tnAncho
        THIS.aCampo[lnFila, 04] = tnDecimales
        THIS.aCampo[lnFila, 05] = llSinSigno
        THIS.aCampo[lnFila, 06] = llRequerido
        THIS.aCampo[lnFila, 07] = lvValor
        THIS.aCampo[lnFila, 08] = llGetter
        THIS.aCampo[lnFila, 09] = llSetter
        THIS.aCampo[lnFila, 10] = tcEtiqueta
        THIS.aCampo[lnFila, 11] = lcUltimoError
    ENDFUNC

    **/
    * Verifica si un campo existe en la propiedad protegida de tipo arreglo
    * 'aCampo'.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @return bool .T. si el campo existe o si ocurre un error;
    *              .F. si el campo no existe.
    * @uses int posicion_campo(string tcCampo)
    *       Para obtener la posición de un campo dentro de la propiedad
    *       protegida de tipo arreglo 'aCampo'.
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION existe_campo
        LPARAMETERS tcCampo

        * inicio { validaciones }
        IF VARTYPE(tcCampo) != 'C' OR EMPTY(tcCampo) THEN
            RETURN .T.
        ENDIF

        IF VARTYPE(THIS.aCampo) == 'L' THEN
            RETURN .F.
        ENDIF
        * fin { validaciones }

        RETURN THIS.posicion_campo(tcCampo) > 0
    ENDFUNC

    **/
    * Devuelve la posición de un campo dentro de la propiedad protegida de tipo
    * arreglo 'aCampo'.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @return int Si el campo existe, devuelve un número mayor que cero;
    *             de lo contrario, devuelve cero.
    *             En caso de error, devuelve -1.
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION posicion_campo
        LPARAMETERS tcCampo

        * inicio { validaciones }
        IF VARTYPE(tcCampo) != 'C' OR EMPTY(tcCampo) THEN
            RETURN -1    && Error.
        ENDIF

        IF VARTYPE(THIS.aCampo) == 'L' THEN
            RETURN 0    && No existe.
        ENDIF
        * fin { validaciones }

        RETURN ASCAN(THIS.aCampo, tcCampo, -1, -1, 1, 9)
    ENDFUNC

    **/
    * Establece si un campo de tipo numérico acepta números negativos.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses int posicion_campo(string tcCampo)
    *       Para obtener la posición de un campo dentro de la propiedad
    *       protegida de tipo arreglo 'aCampo'.
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_sin_signo
        LPARAMETERS tcCampo, tlValor

        * inicio { validaciones de parámetros }
        IF PARAMETERS() != 2 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' ;
                OR VARTYPE(tlValor) != 'L' ;
                OR EMPTY(tcCampo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL lnPos
        lnPos = THIS.posicion_campo(tcCampo)

        IF lnPos <= 0 THEN
            RETURN .F.
        ENDIF

        THIS.aCampo[lnPos, 05] = tlValor    && Sin signo (unsigned).
    ENDFUNC

    **/
    * Establece si un campo es requerido.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses int posicion_campo(string tcCampo)
    *       Para obtener la posición de un campo dentro de la propiedad
    *       protegida de tipo arreglo 'aCampo'.
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_requerido
        LPARAMETERS tcCampo, tlValor

        * inicio { validaciones de parámetros }
        IF PARAMETERS() != 2 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' ;
                OR VARTYPE(tlValor) != 'L' ;
                OR EMPTY(tcCampo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL lnPos
        lnPos = THIS.posicion_campo(tcCampo)

        IF lnPos <= 0 THEN
            RETURN .F.
        ENDIF

        THIS.aCampo[lnPos, 06] = tlValor    && Requerido.
    ENDFUNC

    **/
    * Establece el estado getter de un campo.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses int posicion_campo(string tcCampo)
    *       Para obtener la posición de un campo dentro de la propiedad
    *       protegida de tipo arreglo 'aCampo'.
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_getter
        LPARAMETERS tcCampo, tlValor

        * inicio { validaciones de parámetros }
        IF PARAMETERS() != 2 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' ;
                OR VARTYPE(tlValor) != 'L' ;
                OR EMPTY(tcCampo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL lnPos
        lnPos = THIS.posicion_campo(tcCampo)

        IF lnPos <= 0 THEN
            RETURN .F.
        ENDIF

        THIS.aCampo[lnPos, 08] = tlValor    && Getter.
    ENDFUNC

    **/
    * Establece el estado setter de un campo.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses int posicion_campo(string tcCampo)
    *       Para obtener la posición de un campo dentro de la propiedad
    *       protegida de tipo arreglo 'aCampo'.
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_setter
        LPARAMETERS tcCampo, tlValor

        * inicio { validaciones de parámetros }
        IF PARAMETERS() != 2 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' ;
                OR VARTYPE(tlValor) != 'L' ;
                OR EMPTY(tcCampo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL lnPos
        lnPos = THIS.posicion_campo(tcCampo)

        IF lnPos <= 0 THEN
            RETURN .F.
        ENDIF

        THIS.aCampo[lnPos, 09] = tlValor    && Setter.
    ENDFUNC

    **/
    * Establece el estado getter de todos los campos.
    *
    * @param tlValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses bool establecer_campo_getter(string tcCampo, bool tlValor)
    *       Para establecer el estado getter de un campo.
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_getter_todos
        LPARAMETERS tlValor

        * inicio { validaciones del parámetro }
        IF PARAMETERS() != 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        LOCAL lnContador, lcCampo

        FOR lnContador = 1 TO ALEN(THIS.aCampo, 1)
            lcCampo = THIS.aCampo[lnContador, 01]    && Nombre del campo.

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
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_setter_todos
        LPARAMETERS tlValor

        * inicio { validaciones del parámetro }
        IF PARAMETERS() != 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tlValor) != 'L' THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        LOCAL lnContador, lcCampo

        FOR lnContador = 1 TO ALEN(THIS.aCampo, 1)
            lcCampo = THIS.aCampo[lnContador, 01]    && Nombre del campo.

            IF !THIS.establecer_campo_setter(lcCampo, tlValor) THEN
                RETURN .F.
            ENDIF
        ENDFOR
    ENDFUNC

    **/
    * Establece el valor de un campo.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @param tvValor Valor a asignar.
    * @return bool .T. si el valor se asigna correctamente;
    *              .F. en caso contrario.
    * @uses int posicion_campo(string tcCampo)
    *       Para obtener la posición de un campo dentro de la propiedad
    *       protegida de tipo arreglo 'aCampo'.
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION establecer_campo_valor
        LPARAMETERS tcCampo, tvValor

        * inicio { validaciones de parámetros }
        IF PARAMETERS() != 2 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' OR EMPTY(tcCampo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL lnPos, lcTipo
        lnPos = THIS.posicion_campo(tcCampo)

        IF lnPos <= 0 THEN
            RETURN .F.
        ENDIF

        lcTipo = THIS.aCampo[lnPos, 02]    && Tipo de dato del campo.

        IF VARTYPE(tvValor) != lcTipo THEN
            RETURN .F.
        ENDIF

        THIS.aCampo[lnPos, 07] = tvValor    && Valor del campo.
    ENDFUNC

    **/
    * Devuelve el valor de un campo.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @return mixed Si se ejecuta correctamente, devuelve uno de los siguientes
    *               tipos de datos 'C', 'D', 'L', 'N' o 'T';
    *               NULL en caso contrario.
    * @uses int posicion_campo(string tcCampo)
    *       Para obtener la posición de un campo dentro de la propiedad
    *       protegida de tipo arreglo 'aCampo'.
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION obtener_campo_valor
        LPARAMETERS tcCampo

        * inicio { validaciones del parámetro }
        IF PARAMETERS() != 1 THEN
            RETURN NULL
        ENDIF

        IF VARTYPE(tcCampo) != 'C' OR EMPTY(tcCampo) THEN
            RETURN NULL
        ENDIF
        * fin { validaciones del parámetro }

        LOCAL lnPos
        lnPos = THIS.posicion_campo(tcCampo)

        IF lnPos <= 0 THEN
            RETURN NULL
        ENDIF

        RETURN THIS.aCampo[lnPos, 07]    && Valor del campo.
    ENDFUNC

    **/
    * Devuelve un objeto con todas las propiedades de un campo.
    *
    * Propiedades: nombre, tipo, ancho, decimales, sin_signo, requerido, valor,
    * getter, setter, etiqueta y ultimo_error.
    *
    * @param string tcCampo Nombre del campo a buscar.
    * @return mixed object si el campo existe;
    *              .F. si ocurre un error.
    * @uses int posicion_campo(string tcCampo)
    *       Para obtener la posición de un campo dentro de la propiedad
    *       protegida de tipo arreglo 'aCampo'.
    * @uses array aCampo
    *       Arreglo bidimensional que almacena la estructura de la tabla.
    */
    PROTECTED FUNCTION obtener_campo
        LPARAMETERS tcCampo

        * inicio { validaciones del parámetro }
        IF PARAMETERS() != 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' OR EMPTY(tcCampo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        LOCAL lnPos, loCampo
        lnPos = THIS.posicion_campo(tcCampo)

        IF lnPos <= 0 THEN
            RETURN .F.
        ENDIF

        loCampo = CREATEOBJECT('Empty')

        ADDPROPERTY(loCampo, 'nombre', THIS.aCampo[lnPos, 01])
        ADDPROPERTY(loCampo, 'tipo', THIS.aCampo[lnPos, 02])
        ADDPROPERTY(loCampo, 'ancho', THIS.aCampo[lnPos, 03])
        ADDPROPERTY(loCampo, 'decimales', THIS.aCampo[lnPos, 04])
        ADDPROPERTY(loCampo, 'sin_signo', THIS.aCampo[lnPos, 05])
        ADDPROPERTY(loCampo, 'requerido', THIS.aCampo[lnPos, 06])
        ADDPROPERTY(loCampo, 'valor', THIS.aCampo[lnPos, 07])
        ADDPROPERTY(loCampo, 'getter', THIS.aCampo[lnPos, 08])
        ADDPROPERTY(loCampo, 'setter', THIS.aCampo[lnPos, 09])
        ADDPROPERTY(loCampo, 'etiqueta', THIS.aCampo[lnPos, 10])
        ADDPROPERTY(loCampo, 'ultimo_error', THIS.aCampo[lnPos, 11])

        RETURN loCampo
    ENDFUNC
ENDDEFINE
