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
* @file cerrar_dbf.prg
* @package prog
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Cierra una tabla DBF previamente abierta en el entorno de trabajo.
*
* Valida que el nombre de la tabla sea una cadena no vacía. Si la tabla está
* abierta, se cierra utilizando el comando USE IN. Si la tabla no está abierta
* o el parámetro es inválido, no se realiza ninguna acción.
*
* @param string tcTabla Nombre de la tabla (sin extensión .dbf) o alias que se
*                       desea cerrar.
* @return bool .T. si el parámetro es válido (independientemente de si la
*              tabla estaba abierta).
*              .F. si el parámetro es inválido (tipo incorrecto o cadena
*              vacía).
* @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
*       Para validar si un valor es una cadena de caracteres y su longitud
*       está dentro de un rango específico.
* @example
*     cerrar_dbf('clientes') && Cierra la tabla clientes.dbf si está abierta.
*/
FUNCTION cerrar_dbf
    LPARAMETERS tcTabla

    IF PARAMETERS() != 1 OR !es_cadena(tcTabla) THEN
        RETURN .F.
    ENDIF

    IF USED(tcTabla) THEN
        USE IN (tcTabla)
    ENDIF
ENDFUNC
