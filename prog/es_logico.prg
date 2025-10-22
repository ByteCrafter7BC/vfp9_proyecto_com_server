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
* @file es_logico.prg
* @package prog
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Valida si un valor es de tipo lógico.
*
* @param bool tlVigente El valor a validar.
* @return bool .T. si el valor es de tipo lógico; .F. en caso contrario.
* @example
*     ? es_logico(llVigente)    && Devuelve .T.
*     ? es_logico(123)          && Devuelve .F.
*     ? es_logico('abc')        && Devuelve .F.
*/
FUNCTION es_logico
    LPARAMETERS tlLogico
    RETURN VARTYPE(tlLogico) == 'L'
ENDFUNC
