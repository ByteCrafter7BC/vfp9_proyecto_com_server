**/
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
* @file es_cadena.prg
* @package prog
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Valida si un valor es una cadena de caracteres y su longitud est� dentro de
* un rango espec�fico.
*
* @param string tcCadena La cadena de caracteres a validar.
* @param int [tnMinimo] El valor m�nimo permitido (inclusive). Valor 0 (cero)
*                       permite cadenas vac�as. Por defecto es 1.
* @param int [tnMaximo] El valor m�ximo permitido (inclusive).
*                       Por defecto es 50.
* @return bool .T. si el valor es una cadena de caracteres y est� dentro del
*              rango [tnMinimo, tnMaximo];
*              .F. si no es una cadena de caracteres o est� fuera del rango.
* @example
*     ? es_cadena('Hola', 3, 10)    && Devuelve .T.
*     ? es_cadena('')               && Devuelve .F.
*     ? es_cadena(123)              && Devuelve .F.
*/
FUNCTION es_cadena
    LPARAMETERS tcCadena, tnMinimo, tnMaximo

    IF VARTYPE(tcCadena) != 'C' THEN
        RETURN .F.
    ENDIF

    IF VARTYPE(tnMinimo) != 'N' OR tnMinimo < 0 THEN
        tnMinimo = 1
    ENDIF

    IF VARTYPE(tnMaximo) != 'N' OR tnMaximo < 0 THEN
        tnMaximo = 50
    ENDIF

    IF tnMinimo > tnMaximo THEN
        RETURN .F.
    ENDIF

    IF tnMinimo > 0 AND EMPTY(tcCadena) THEN
        RETURN .F.
    ENDIF

    RETURN BETWEEN(LEN(tcCadena), tnMinimo, tnMaximo)
ENDFUNC
