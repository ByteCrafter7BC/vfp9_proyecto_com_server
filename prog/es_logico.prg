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
* @file es_logico.prg
* @package prog
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Valida si un valor es de tipo l�gico.
*
* @param bool tlVigente El valor a validar.
* @return bool .T. si el valor es de tipo l�gico; .F. en caso contrario.
* @example
*     ? es_logico(llVigente)    && Devuelve .T.
*     ? es_logico(123)          && Devuelve .F.
*     ? es_logico('abc')        && Devuelve .F.
*/
FUNCTION es_logico
    LPARAMETERS tlLogico
    RETURN VARTYPE(tlLogico) == 'L'
ENDFUNC
