**/
* interfaz_dao.prg
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

DEFINE CLASS interfaz_dao AS Custom
    FUNCTION existe_codigo
        LPARAMETERS tnCodigo
        RETURN .T.
    ENDFUNC

    FUNCTION existe_nombre
        LPARAMETERS tcNombre
        RETURN .T.
    ENDFUNC

    FUNCTION esta_vigente
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    FUNCTION esta_relacionado
        LPARAMETERS tnCodigo
        RETURN .T.
    ENDFUNC

    FUNCTION contar
        LPARAMETERS tcCondicionFiltro
        RETURN .F.
    ENDFUNC

    FUNCTION obtener_nuevo_codigo
        RETURN .F.
    ENDFUNC

    FUNCTION obtener_por_codigo
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    FUNCTION obtener_por_nombre
        LPARAMETERS tcNombre
        RETURN .F.
    ENDFUNC

    FUNCTION obtener_todos
        LPARAMETERS tcCondicionFiltro, tcOrden
        RETURN .F.
    ENDFUNC

    FUNCTION obtener_ultimo_error
        RETURN .F.
    ENDFUNC

    FUNCTION agregar
        LPARAMETERS toModelo
        RETURN .F.
    ENDFUNC

    FUNCTION modificar
        LPARAMETERS toModelo
        RETURN .F.
    ENDFUNC

    FUNCTION borrar
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                            PROTECTED METHODS                            *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    PROTECTED FUNCTION configurar
        RETURN .F.
    ENDFUNC

    PROTECTED FUNCTION conectar
        RETURN .F.
    ENDFUNC

    PROTECTED FUNCTION desconectar
        RETURN .F.
    ENDFUNC
ENDDEFINE
