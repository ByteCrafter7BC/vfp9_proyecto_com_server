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
* @file es_numero.prg
* @package prog
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Valida si un valor es numérico y se encuentra dentro de un rango específico.
*
* @param int tnNumero El número a validar.
* @param int [tnMinimo] El valor mínimo permitido (inclusive).
*                       Si no es numérico o es negativo, se establece en 1.
* @param int [tnMaximo] El valor máximo permitido (inclusive).
*                       Si no es numérico o es negativo, se establece en 99999.
* @return bool .T. si el valor es numérico y está dentro del rango [tnMinimo,
*              tnMaximo]; .F. si no es numérico o está fuera del rango.
* @example
*     && Validar si 5 está entre 1 y 10.
*     ? es_numero(5, 1, 10)    && Devuelve .T.
* @example
*     && Validar si 15 está entre 1 y 10.
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
