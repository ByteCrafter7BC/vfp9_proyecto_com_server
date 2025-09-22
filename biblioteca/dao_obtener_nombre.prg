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
* @file dao_obtener_nombre.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @see dao_obtener_por_codigo()
*/

**/
* Obtiene el nombre de un registro específico a partir de su código.
*
* Esta función utiliza 'dao_obtener_por_codigo()' para obtener el objeto
* correspondiente al código dado. Si el objeto es válido, se invoca su método
* 'obtener_nombre()' para recuperar el nombre.
*
* @param string tcModelo Nombre o alias de la tabla (modelo) a consultar.
* @param int tnCodigo Código numérico del registro cuyo nombre se desea obtener.
*
* @return string Nombre del registro. Si el registro no fue encontrado, devuelve
*                una cadena vacía.
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
