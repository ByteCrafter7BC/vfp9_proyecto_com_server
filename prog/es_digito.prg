**/
* es_digito.prg
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
* Verifica si una expresi�n contiene �nicamente caracteres num�ricos.
*
* La funci�n acepta una cadena o un valor num�rico. Si el par�metro es de
* tipo num�rico, se considera v�lido autom�ticamente. Si es una cadena, se
* valida que no est� vac�a ni contenga espacios, y luego se analiza car�cter
* por car�cter para asegurarse de que todos sean d�gitos.
* Retorna .T. si la expresi�n est� compuesta exclusivamente por d�gitos.
*
* @param string|int tcExpresion  Cadena o n�mero a evaluar. Las cadenas no
*                                deben contener espacios ni s�mbolos.
*
* @return bool  .T. si la expresi�n es num�rica v�lida (todos los caracteres
*               son d�gitos o el tipo es num�rico).
*               .F. si contiene letras, espacios, s�mbolos o si el par�metro
*               es inv�lido.
*
* @example
*     es_digito('12345')   && Retorna .T.
*     es_digito('12a45')   && Retorna .F.
*     es_digito(67890)     && Retorna .T.
*     es_digito('12 45')   && Retorna .F. (por el espacio).
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
