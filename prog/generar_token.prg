**/
* generar_token.prg
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
* Genera un token �nico basado en la fecha/hora actual y un identificador
* �nico del sistema.
*
* La funci�n combina la representaci�n textual de la fecha y hora actual
* en formato compacto con el valor retornado por SYS(2015), que representa un
* identificador �nico de sesi�n.
* El resultado es una cadena que puede utilizarse como token para prop�sitos
* de autenticaci�n, trazabilidad o identificaci�n temporal.
*
* @return string  Cadena que representa el token generado, compuesta por
*                 fecha/hora y un identificador �nico del sistema.
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
