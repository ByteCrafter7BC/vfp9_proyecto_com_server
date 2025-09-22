**/
* es_alfa.prg
*
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
* Verifica si una expresi�n contiene �nicamente caracteres alfab�ticos (sin
* espacios, d�gitos ni s�mbolos).
*
* La funci�n valida que el par�metro sea una cadena no vac�a y sin espacios.
* Luego recorre cada car�cter de la expresi�n y clasifica si es letra, n�mero
* o s�mbolo. Retorna .T. �nicamente si todos los caracteres son letras y no
* hay ning�n n�mero ni s�mbolo.
*
* @param string tcExpresion Cadena a evaluar. Debe estar compuesta solo por
*                           letras sin espacios.
*
* @return bool .T. si la expresi�n contiene exclusivamente letras.
*              .F. si contiene espacios, n�meros, s�mbolos o si el par�metro
*              es inv�lido.
*
* @example
*     es_alfa('VisualFox') && Retorna .T.
*     es_alfa('Fox123')    && Retorna .F.
*     es_alfa('Fox Pro')   && Retorna .F. (por el espacio).
*/
FUNCTION es_alfa
    PARAMETERS tcExpresion

    * inicio { validaciones del par�metro }
    IF PARAMETERS() < 1 THEN
        RETURN .F.
    ENDIF

    IF VARTYPE(tcExpresion) != 'C' ;
            OR EMPTY(tcExpresion) ;
            OR OCCURS(CHR(32), tcExpresion) != 0 THEN
        RETURN .F.
    ENDIF
    * fin { validaciones del par�metro }

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

    IF lnNumero > 0 OR lnLetra == 0 OR lnSimbolo > 0 THEN
        RETURN .F.
    ENDIF
ENDFUNC
