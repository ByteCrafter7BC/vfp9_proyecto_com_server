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
* @file es_objeto.prg
* @package prog
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Valida si un valor es un objeto y, opcionalmente, corresponde a una clase
* espec�fica.
*
* @param object toObjeto El objeto a validar.
* @param string [tcClase] La clase a la que el objeto debe corresponder.
* @return bool .T. si el valor es un objeto v�lido y, opcionalmente,
*              corresponde a la clase especificada;
*              .F. si no es objeto o no corresponde a la clase especificada.
* @example
*     ? es_objeto(loCliente)                && Devuelve .T.
*     ? es_objeto(loCliente, 'clientes')    && Devuelve .T.
*     ? es_objeto(loCliente, 'proveedo')    && Devuelve .F.
*     ? es_objeto(123)                      && Devuelve .F.
*     ? es_objeto('abc')                    && Devuelve .F.
*/
FUNCTION es_objeto
    LPARAMETERS toObjeto, tcClase

    IF VARTYPE(toObjeto) != 'O' THEN
        RETURN .F.
    ENDIF

    IF es_cadena(tcClase) THEN
        IF LOWER(toObjeto.Class) != LOWER(tcClase) THEN
            RETURN .F.
        ENDIF
    ENDIF
ENDFUNC
