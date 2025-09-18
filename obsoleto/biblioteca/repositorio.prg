**/
* repositorio.prg
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

DEFINE CLASS repositorio AS Custom
    PROTECTED aRepositorio[1, 2]    && columna1 = modelo | columna2 = repositorio

    **--------------------------------------------------------------------------
    FUNCTION Init
        DIMENSION THIS.aRepositorio[14, 2]

        WITH THIS
            .aRepositorio[01, 1] = 'barrios'
            .aRepositorio[02, 1] = 'ciudades'
            .aRepositorio[03, 1] = 'cobrador'
            .aRepositorio[04, 1] = 'depar'
            .aRepositorio[05, 1] = 'familias'
            .aRepositorio[06, 1] = 'maquinas'
            .aRepositorio[07, 1] = 'marcas1'
            .aRepositorio[08, 1] = 'marcas2'
            .aRepositorio[09, 1] = 'mecanico'
            .aRepositorio[10, 1] = 'modelos'
            .aRepositorio[11, 1] = 'proceden'
            .aRepositorio[12, 1] = 'rubros1'
            .aRepositorio[13, 1] = 'rubros2'
            .aRepositorio[14, 1] = 'vendedor'
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener
        LPARAMETERS tcModelo

        IF VARTYPE(tcModelo) == 'C' AND !EMPTY(tcModelo) THEN
            tcModelo = LOWER(ALLTRIM(tcModelo))
        ELSE
            RETURN .F.
        ENDIF

        LOCAL lnFila
        lnFila = ASCAN(THIS.aRepositorio, tcModelo, -1, -1, 1, 14)

        IF lnFila <= 0 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.aRepositorio[lnFila, 2]) != 'O' THEN
            THIS.aRepositorio[lnFila, 2] = THIS.crear(tcModelo)
        ENDIF

        IF VARTYPE(THIS.aRepositorio[lnFila, 2]) != 'O' THEN
            RETURN .F.
        ENDIF

        RETURN THIS.aRepositorio[lnFila, 2]
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION crear
        LPARAMETERS tcModelo

        IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
            RETURN .F.
        ENDIF

        IF ASCAN(THIS.aRepositorio, tcModelo, -1, -1, 1, 14) <= 0 THEN
            RETURN .F.
        ENDIF

        LOCAL lcClase, loObjeto, loExcepcion, lcMensaje
        lcClase = 'repositorio_' + LOWER(ALLTRIM(tcModelo))

        TRY
            loObjeto = NEWOBJECT(lcClase, lcClase + '.prg')
        CATCH TO loExcepcion
            registrar_error('repositorio', 'crear', loExcepcion.Message)
        ENDTRY

        RETURN loObjeto
    ENDFUNC
ENDDEFINE
