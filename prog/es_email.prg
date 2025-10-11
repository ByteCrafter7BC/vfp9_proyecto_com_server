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
* Determina si una expresión de cadena de caracteres es una dirección de correo
* electrónico válida.
*
* @param string tcExpresion
* Especifica la expresión de cadena de caracteres que es_email() prueba.
*
* @return bool
* es_email() devuelve verdadero (.T.) si la expresión de cadena de caracteres
* especificada es una dirección de correo electrónico válida; de lo contrario,
* es_email() devuelve falso (.F.).
*/
FUNCTION es_email
    LPARAMETERS tcExpresion

    * inicio { validaciones del parámetro }
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
    * fin { validaciones del parámetro }

    LOCAL loRegExp
    loRegExp = CREATEOBJECT('VBScript.RegExp')

    IF VARTYPE(loRegExp) != 'O' THEN
        RETURN .F.
    ENDIF

    loRegExp.Pattern = '^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$'

    RETURN loRegExp.Test(tcExpresion)
ENDFUNC
