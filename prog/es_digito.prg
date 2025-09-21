**/
* es_digito.prg
*
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
* Verifica si una expresión contiene únicamente caracteres numéricos.
*
* La función acepta una cadena o un valor numérico. Si el parámetro es de
* tipo numérico, se considera válido automáticamente. Si es una cadena, se
* valida que no esté vacía ni contenga espacios, y luego se analiza carácter
* por carácter para asegurarse de que todos sean dígitos.
* Retorna .T. si la expresión está compuesta exclusivamente por dígitos.
*
* @param string|int tcExpresion  Cadena o número a evaluar. Las cadenas no
*                                deben contener espacios ni símbolos.
*
* @return bool  .T. si la expresión es numérica válida (todos los caracteres
*               son dígitos o el tipo es numérico).
*               .F. si contiene letras, espacios, símbolos o si el parámetro
*               es inválido.
*
* @example
*     es_digito('12345')   && Retorna .T.
*     es_digito('12a45')   && Retorna .F.
*     es_digito(67890)     && Retorna .T.
*     es_digito('12 45')   && Retorna .F. (por el espacio).
*/
FUNCTION es_digito
    PARAMETERS tcExpresion

    * inicio { validaciones del parámetro }
    IF PARAMETERS() < 1 THEN
        RETURN .F.
    ENDIF

    IF VARTYPE(tcExpresion) != 'C' THEN
        IF VARTYPE(tcExpresion) == 'N' THEN
            RETURN .T.
        ENDIF

        RETURN .F.
    ENDIF

    IF EMPTY(tcExpresion) ;
            OR OCCURS(CHR(32), tcExpresion) != 0 THEN
        RETURN .F.
    ENDIF
    * fin { validaciones del parámetro }

    LOCAL lnNumero, lnLetra, lnSimbolo, lnContador, lcCaracter
    STORE 0 TO lnNumero, lnLetra, lnSimbolo

    FOR lnContador = 1 TO LEN(tcExpresion)
        lcCaracter = SUBSTR(tcExpresion, lnContador, 1)

        IF ISDIGIT(lcCaracter) THEN
            lnNumero = lnNumero + 1
        ELSE
            IF ISALPHA(lcCaracter) THEN
                lnLetra = lnLetra + 1
            ELSE
                lnSimbolo = lnSimbolo + 1
            ENDIF
        ENDIF
    ENDFOR

    IF lnNumero == 0 OR lnLetra > 0 OR lnSimbolo > 0 THEN
        RETURN .F.
    ENDIF
ENDFUNC
