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
* @file referencial_obtener_nombre.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
*/

**/
* Devuelve el nombre de un registro referencial a partir de su código.
*
* @param string tcModelo Nombre del modelo o tabla de la que se desea
*                        obtener el nombre.
* @param int tnCodigo Código del registro a buscar.
* @return string Nombre del registro, mensaje de error si el parámetro es
*                inválido, o un mensaje de 'No existe' si el código no
*                existe.
* @uses constantes.h
* @uses bool es_cadena(string tcCadena, int [tnMinimo], int [tnMaximo])
*       Para validar el tipo de dato cadena.
* @uses bool es_numero(string tnNumero, int [tnMinimo], int [tnMaximo])
*       Para validar el tipo de dato cadena.
* @uses string dao_obtener_nombre(string tcModelo, int tnCodigo)
*       Para obtener el nombre de un registro específico a partir de su código.
*/
#INCLUDE 'constantes.h'

FUNCTION referencial_obtener_nombre
    LPARAMETERS tcModelo, tnCodigo

    IF !es_cadena(tcModelo) THEN
        RETURN STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tcModelo')
    ENDIF

    IF !es_numero(tnCodigo, 0) THEN
        RETURN STRTRAN(MSG_PARAM_INVALIDO, '{}', 'tnCodigo')
    ENDIF

    IF tnCodigo == 0 THEN
        RETURN SPACE(0)
    ENDIF

    LOCAL lcNombre
    lcNombre = dao_obtener_nombre(tcModelo, tnCodigo)

    IF EMPTY(lcNombre) THEN
        RETURN MSG_NO_EXISTE
    ENDIF

    RETURN lcNombre
ENDFUNC
