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
* @file dao_existe_codigo.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @uses dao_obtener_por_codigo
*/

**/
* Verifica si un registro existe en la base de datos busc�ndolo por su c�digo.
*
* Esta funci�n act�a como un contenedor (wrapper) de 'dao_obtener_por_codigo'.
* Intenta obtener un objeto modelo y, bas�ndose en si la operaci�n fue exitosa,
* determina la existencia del registro.
*
* @param string tcModelo Nombre o alias de la tabla (modelo) donde se realizar�
*                        la b�squeda.
* @param int tnCodigo C�digo num�rico �nico del registro a verificar.
* @return bool .T. si se encuentra un objeto modelo, es decir, el registro
*              existe; .F. en caso contrario.
*/
FUNCTION dao_existe_codigo
    LPARAMETERS tcModelo, tnCodigo

    LOCAL loModelo
    loModelo = dao_obtener_por_codigo(tcModelo, tnCodigo)

    IF VARTYPE(loModelo) != 'O' THEN
        RETURN .F.
    ENDIF
ENDFUNC
