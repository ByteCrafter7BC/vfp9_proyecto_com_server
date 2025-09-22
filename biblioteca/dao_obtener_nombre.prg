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
* @file dao_obtener_nombre.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @see dao_obtener_por_codigo()
*/

**/
* Obtiene el nombre de un registro espec�fico a partir de su c�digo.
*
* Esta funci�n utiliza 'dao_obtener_por_codigo()' para obtener el objeto
* correspondiente al c�digo dado. Si el objeto es v�lido, se invoca su m�todo
* 'obtener_nombre()' para recuperar el nombre.
*
* @param string tcModelo Nombre o alias de la tabla (modelo) a consultar.
* @param int tnCodigo C�digo num�rico del registro cuyo nombre se desea obtener.
*
* @return string Nombre del registro. Si el registro no fue encontrado, devuelve
*                una cadena vac�a.
*/
FUNCTION dao_obtener_nombre
    LPARAMETERS tcModelo, tnCodigo

    LOCAL loModelo
    loModelo = dao_obtener_por_codigo(tcModelo, tnCodigo)

    IF VARTYPE(loModelo) != 'O' THEN
        RETURN SPACE(0)
    ENDIF

    RETURN loModelo.obtener_nombre()
ENDFUNC
