**/
* es_digito() funci�n
*
* Derechos de autor (C) 2000-2025 Jos� Acu�a <jacuna.dev@gmail.com>
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

**/
* Determina si los caracteres de la expresi�n de caracteres especificada
* son d�gitos (del 0 al 9).
*
* @param string tcExpresion
* Especifica la expresi�n de caracteres que es_digito() prueba.
*
* @return boolean
* es_digito() devuelve true (.T.) si los caracteres de la expresi�n de
* caracteres especificada son d�gitos (del 0 al 9); de lo contrario,
* es_digito() devuelve false (.F.).
*/

FUNCTION es_digito
    PARAMETERS tcExpresion

    * inicio { validaciones del par�metro }
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

    IF lnNumero == 0 OR lnLetra > 0 OR lnSimbolo > 0 THEN
        RETURN .F.
    ENDIF
ENDFUNC
