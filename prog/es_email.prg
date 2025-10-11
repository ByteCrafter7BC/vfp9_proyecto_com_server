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
* Determina si una expresi�n de cadena de caracteres es una direcci�n de correo
* electr�nico v�lida.
*
* @param string tcExpresion
* Especifica la expresi�n de cadena de caracteres que es_email() prueba.
*
* @return bool
* es_email() devuelve verdadero (.T.) si la expresi�n de cadena de caracteres
* especificada es una direcci�n de correo electr�nico v�lida; de lo contrario,
* es_email() devuelve falso (.F.).
*/
FUNCTION es_email
    LPARAMETERS tcExpresion

    * inicio { validaciones del par�metro }
    IF PARAMETERS() < 1 THEN
        RETURN .F.
    ENDIF

    IF VARTYPE(tcExpresion) != 'C' THEN
        RETURN .F.
    ENDIF

    IF EMPTY(tcExpresion) THEN
        RETURN .F.
    ENDIF

    IF OCCURS(CHR(32), tcExpresion) != 0 THEN
        RETURN .F.
    ENDIF

    IF !BETWEEN(LEN(tcExpresion), 10, 80) THEN
        RETURN .F.
    ENDIF
    * fin { validaciones del par�metro }

    LOCAL loRegExp
    loRegExp = CREATEOBJECT('VBScript.RegExp')

    IF VARTYPE(loRegExp) != 'O' THEN
        RETURN .F.
    ENDIF

    loRegExp.Pattern = '^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$'

    RETURN loRegExp.Test(tcExpresion)
ENDFUNC
