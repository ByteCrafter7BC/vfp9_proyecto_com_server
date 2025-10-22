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
* @file es_numero.prg
* @package prog
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Valida si un valor es num�rico y se encuentra dentro de un rango espec�fico.
*
* @param int tnNumero El n�mero a validar.
* @param int [tnMinimo] El valor m�nimo permitido (inclusive).
*                       Si no es num�rico o es negativo, se establece en 1.
* @param int [tnMaximo] El valor m�ximo permitido (inclusive).
*                       Si no es num�rico o es negativo, se establece en 99999.
* @return bool .T. si el valor es num�rico y est� dentro del rango [tnMinimo,
*              tnMaximo]; .F. si no es num�rico o est� fuera del rango.
* @example
*     && Validar si 5 est� entre 1 y 10.
*     ? es_numero(5, 1, 10)    && Devuelve .T.
* @example
*     && Validar si 15 est� entre 1 y 10.
*     ? es_numero(15, 1, 10)    && Devuelve .F.
* @example
*     && Usar valores por defecto (1-99999).
*     ? es_numero(500)    && Devuelve .T.
*     ? es_numero(100000)    && Devuelve .F.
*/
FUNCTION es_numero
    LPARAMETERS tnNumero, tnMinimo, tnMaximo

    IF VARTYPE(tnNumero) != 'N' THEN
        RETURN .F.
    ENDIF

    IF VARTYPE(tnMinimo) != 'N' OR tnMinimo < 0 THEN
        tnMinimo = 1
    ENDIF

    IF VARTYPE(tnMaximo) != 'N' OR tnMaximo < 0 THEN
        tnMaximo = 99999
    ENDIF

    IF tnMinimo > tnMaximo THEN
        RETURN .F.
    ENDIF

    RETURN BETWEEN(tnNumero, tnMinimo, tnMaximo)
ENDFUNC
