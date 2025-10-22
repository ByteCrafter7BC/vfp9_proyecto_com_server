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
* @file dao_existe_codigo.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @uses dao_obtener_por_codigo
*/

**/
* Verifica si un registro existe en la base de datos buscándolo por su código.
*
* Esta función actúa como un contenedor (wrapper) de 'dao_obtener_por_codigo'.
* Intenta obtener un objeto modelo y, basándose en si la operación fue exitosa,
* determina la existencia del registro.
*
* @param string tcModelo Nombre o alias de la tabla (modelo) donde se realizará
*                        la búsqueda.
* @param int tnCodigo Código numérico único del registro a verificar.
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
