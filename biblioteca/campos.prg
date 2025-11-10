DEFINE CLASS campos AS Custom
    * @var array Arreglo bidimensional que almacena la lista de campos y las
    *            instancias de sus respectivos objetos.
    * @structure [n, 1] = nombre del campo, [n, 2] = objeto campo.
    PROTECTED aCampos[1,2]

    **/
    * @section MÉTODOS PÚBLICOS
    * @method bool agregar(string tcNombre, string tcTipo, int tnAncho, ;
                           int tnDecimales, string tcEtiqueta)
    * @method int cantidad()
    * @method bool es_requerido(string tcCampo)
    * @method bool es_sin_signo(string tcCampo)
    * @method bool establecer_getter(string tcCampo, bool tlValor)
    * @method bool establecer_getter_todos(bool tlValor)
    * @method bool establecer_requerido(string tcCampo, bool tlValor)
    * @method bool establecer_setter(string tcCampo, bool tlValor)
    * @method bool establecer_setter_todos(bool tlValor)
    * @method bool establecer_sin_signo(string tcCampo, bool tlValor)
    * @method bool establecer_ultimo_error(string tcCampo, string tcValor)
    * @method bool establecer_valor(string tcCampo, mixed tvValor)
    * @method bool existe(string tcCampo)
    * @method mixed obtener(string tcCampo)
    * @method int obtener_ancho(string tcCampo)
    * @method int obtener_decimales(string tcCampo)
    * @method string obtener_etiqueta(string tcCampo)
    * @method string obtener_tipo(string tcCampo)
    * @method string obtener_ultimo_error(string tcCampo)
    * @method mixed obtener_valor(string tcCampo)
    * @method bool permitir_getter(string tcCampo, tlValor)
    * @method bool permitir_setter(string tcCampo, tlValor)
    */

    **/
    * Agrega un campo a la propiedad protegida 'aCampos'.
    *
    * @param string tcNombre Nombre del campo (ej.: 'codigo', 'nombre').
    * @param string tcTipo Tipo de dato del campo (ej.: 'C', 'D', 'L', 'N').
    * @param int tnAncho Ancho del campo (ej.: 4, 30, 1).
    * @param int tnDecimales Cantidad de posiciones decimales en caso de
    *                        tcTipo == 'N'.
    * @param string tcEtiqueta Etiqueta del campo (ej.: 'Código: ', 'Nombre: ').
    * @return bool .T. si el campo se agrega correctamente;
    *              .F. si ocurre un error.
    * @uses bool es_objeto(object toObjeto, string [tcClase])
    *       Para validar si un valor es un objeto y, opcionalmente, corresponde
    *       a una clase específica.
    * @uses bool existe(string tcCampo)
    *       Para verifica si un campo existe en la propiedad protegida
    *       'aCampos'.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses array aCampos Arreglo bidimensional que almacena la lista de campos
    *       y las instancias de sus respectivos objetos.
    */
    FUNCTION agregar
        LPARAMETERS tcNombre, tcTipo, tnAncho, tnDecimales, tcEtiqueta

        LOCAL loCampo, lnFila
        loCampo = NEWOBJECT('campo', 'campo.prg', '', ;
            tcNombre, tcTipo, tnAncho, tnDecimales, tcEtiqueta)

        IF !es_objeto(loCampo) OR THIS.existe(tcNombre) THEN
            RETURN .F.
        ENDIF

        lnFila = IIF(!es_logico(THIS.aCampos), ALEN(THIS.aCampos, 1) + 1, 1)

        DIMENSION THIS.aCampos[lnFila, 2]
        THIS.aCampos[lnFila, 1] = tcNombre
        THIS.aCampos[lnFila, 2] = loCampo
    ENDFUNC

    **/
    * Devuelve la cantidad de campos.
    *
    * @return int número mayor que cero si logra obtener la cantidad;
    *             cero en caso contrario.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses array aCampos Arreglo bidimensional que almacena la lista de campos
    *       y las instancias de sus respectivos objetos.
    */
    FUNCTION cantidad
        IF es_logico(THIS.aCampos) THEN
            RETURN 0
        ENDIF

        RETURN ALEN(THIS.aCampos, 1)
    ENDFUNC

    **/
    * Verifica si un campo existe en la propiedad protegida 'aCampos'.
    *
    * @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
    * @return bool .T. si el campo existe;
    *              .F. si el campo no existe o si ocurre un error.
    * @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
    *       Para validar si un valor es una cadena de caracteres y su longitud
    *       está dentro de un rango específico.
    * @uses bool es_logico(bool tlLogico)
    *       Para validar si un valor es de tipo lógico.
    * @uses array aCampos Arreglo bidimensional que almacena la lista de campos
    *       y las instancias de sus respectivos objetos.
    */
    FUNCTION existe
        LPARAMETERS tcCampo

        IF !es_cadena(tcCampo) OR es_logico(THIS.aCampos) THEN
            RETURN .F.
        ENDIF

        RETURN ASCAN(THIS.aCampos, tcCampo, -1, -1, 1, 14) > 0
    ENDFUNC
ENDDEFINE
