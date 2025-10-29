**/
* Devuelve una cadena de caracteres que contiene la lista de campos del modelo.
*
* @param tcModelo Nombre del modelo a buscar.
* @return string Si se ejecuta correctamente, devuelve la lista de campos.
*                En caso contrario, devuelve una cadena vacía.
* @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
*       Para validar el tipo de dato cadena.
* @uses mixed campo_obtener_todos(string tcModelo)
*       Para obtener un objeto de tipo 'Collection' con todos los campos del
*       modelo especificado.
* @uses bool es_objeto(object toObjeto, string [tcClase])
*       Para validar el tipo de dato objeto.
*/
FUNCTION campo_obtener_lista
    LPARAMETERS tcModelo

    IF PARAMETERS() != 1 OR !es_cadena(tcModelo) THEN
        RETURN SPACE(0)
    ENDIF

    tcModelo = LOWER(ALLTRIM(tcModelo))

    LOCAL loCampos, lcLista, loCampo
    loCampos = campo_obtener_todos(tcModelo)
    lcLista = ''

    IF !es_objeto(loCampos) OR loCampos.Count == 0 THEN
        RETURN SPACE(0)
    ENDIF

    FOR EACH loCampo IN loCampos
        IF !EMPTY(lcLista) THEN
            lcLista = lcLista + ', '
        ENDIF

        lcLista = lcLista + loCampo.obtener_nombre()
    ENDFOR

    RETURN lcLista
ENDFUNC
