**/
* generar_token.prg
*
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
* Genera un token único basado en la fecha/hora actual y un identificador
* único del sistema.
*
* La función combina la representación textual de la fecha y hora actual
* en formato compacto con el valor retornado por SYS(2015), que representa un
* identificador único de sesión.
* El resultado es una cadena que puede utilizarse como token para propósitos
* de autenticación, trazabilidad o identificación temporal.
*
* @return string  Cadena que representa el token generado, compuesta por
*                 fecha/hora y un identificador único del sistema.
*
* @example
*     generar_token() && Retorna algo como '20250917084730_7a30iudic'.
*/
FUNCTION generar_token
    LOCAL lcDateTime, lcSys2015
    lcDateTime = TTOC(DATETIME(), 1)
    lcSys2015 = LOWER(SYS(2015))

    RETURN lcDateTime + lcSys2015
ENDFUNC
