**/
* Función principal (debe coincidir con el nombre del archivo).
*
* Devuelve el ancho del campo de un modelo.
*
* @param tcModelo Nombre del modelo a buscar.
* @param tcCampo Nombre del campo del cual se quiere obtener el ancho.
* @return int número mayor que cero si logra obtener el ancho;
*             cero en caso contrario.
* @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
*       Para validar el tipo de dato cadena.
* @uses mixed campo_obtener_todos(string tcModelo)
*       Para obtener un objeto de tipo 'Collection' con todos los campos del
*       modelo especificado.
* @uses bool es_objeto(object toObjeto, string [tcClase])
*       Para validar el tipo de dato objeto.
* @uses mixed campo_obtener(string tcCampo)
*       Para obtener un objeto con todas las propiedades de un campo.
*/
FUNCTION campo_obtener_ancho
    LPARAMETERS tcModelo, tcCampo

    IF !es_cadena(tcModelo) OR !es_cadena(tcCampo) THEN
        RETURN 0
    ENDIF

    tcModelo = LOWER(ALLTRIM(tcModelo))

    PRIVATE poCampos, poCampo
    poCampos = campo_obtener_todos(tcModelo)

    IF !es_objeto(poCampos) OR poCampos.Count == 0 THEN
        RETURN 0
    ENDIF

    poCampo = campo_obtener(tcCampo)

    IF !es_objeto(poCampo) THEN
        RETURN 0
    ENDIF

    RETURN poCampo.obtener_ancho()
ENDFUNC

**/
* Verifica si un campo existe en la variable privada 'poCampos'.
*
* @param string tcCampo Nombre del campo (ej.: 'codigo', 'nombre').
* @return bool .T. si el campo existe o si ocurre un error;
*              .F. si el campo no existe.
* @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
*       Para validar el tipo de dato cadena.
* @uses bool es_objeto(object toObjeto, string [tcClase])
*       Para validar el tipo de dato objeto.
* @uses object poCampos Almacena la estructura de la tabla.
*/
FUNCTION campo_existe
    LPARAMETERS tcCampo

    IF !es_cadena(tcCampo) OR !es_objeto(poCampos) THEN
        RETURN .T.
    ENDIF

    RETURN poCampos.GetKey(tcCampo) > 0
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
*       Para verifica si un campo existe en la variable privada 'poCampos'.
* @uses object poCampos Almacena la estructura de la tabla.
*/
FUNCTION campo_obtener
    LPARAMETERS tcCampo

    IF !campo_existe(tcCampo) THEN
        RETURN .F.
    ENDIF

    RETURN poCampos.Item(tcCampo)
ENDFUNC
