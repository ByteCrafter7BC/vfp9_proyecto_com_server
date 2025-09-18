**/
* interfaz_dao.prg
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
