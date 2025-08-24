**/
* validador_ciudades.prg
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

#INCLUDE 'constantes.h'

DEFINE CLASS validador_ciudades AS validador_base OF validador_base.prg
    PROTECTED cErrorDepartamen
    PROTECTED cErrorSifen

    **--------------------------------------------------------------------------
    FUNCTION es_valido
        IF BETWEEN(THIS.nBandera, 1, 2) THEN
            IF !EMPTY(THIS.cErrorCodigo) ;
                    OR !EMPTY(THIS.cErrorNombre) ;
                    OR !EMPTY(THIS.cErrorDepartamen) ;
                    OR !EMPTY(THIS.cErrorSifen) ;
                    OR !EMPTY(THIS.cErrorVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            RETURN !THIS.oRepositorio.esta_relacionado( ;
                THIS.oModelo.obtener_codigo())
        ENDIF
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_departamen
        RETURN IIF(VARTYPE(THIS.cErrorDepartamen) == 'C', ;
            THIS.cErrorDepartamen, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_error_sifen
        RETURN IIF(VARTYPE(THIS.cErrorSifen) == 'C', THIS.cErrorSifen, '')
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar
        validador_base::validar()

        WITH THIS
            .cErrorDepartamen = .validar_departamen()
            .cErrorSifen = .validar_sifen()
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_nombre
        LOCAL lcEtiqueta, lcNombre, loModelo
        lcEtiqueta = 'Nombre: '
        lcNombre = THIS.oModelo.obtener_nombre()

        IF EMPTY(lcNombre) THEN
            RETURN lcEtiqueta + NO_BLANCO
        ENDIF

        IF LEN(lcNombre) > THIS.nAnchoNombre THEN
            RETURN lcEtiqueta + ;
                STRTRAN(LONGITUD_MAXIMA, '{}', ALLTRIM(STR(THIS.nAnchoNombre)))
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_departamen
        LOCAL lcEtiqueta, lnDepartamen, loModelo
        lcEtiqueta = 'Departamento: '

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        lnDepartamen = THIS.oModelo.obtener_departamen()

        IF lnDepartamen <= 0 THEN
            RETURN lcEtiqueta + MAYOR_QUE_CERO
        ENDIF

        IF lnDepartamen > 999 THEN
            RETURN lcEtiqueta + STRTRAN(MENOR_QUE, '{}', ALLTRIM(STR(999 + 1)))
        ENDIF

        loModelo = repositorio_obtener_por_codigo('depar', lnDepartamen)

        IF VARTYPE(loModelo) != 'O' THEN
            RETURN lcEtiqueta + ;
                STRTRAN(NO_EXISTE, '{}', ALLTRIM(STR(lnDepartamen)))
        ENDIF

        IF !loModelo.esta_vigente() THEN
            RETURN lcEtiqueta + ;
                STRTRAN(NO_VIGENTE, '{}', ALLTRIM(STR(lnDepartamen)))
        ENDIF

        loModelo = THIS.oRepositorio.obtener_por_nombre(lcNombre, lnDepartamen)

        IF THIS.nBandera == 1 THEN    && Agregar
            IF VARTYPE(loModelo) == 'O' THEN
                RETURN 'Nombre: ' + YA_EXISTE
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF VARTYPE(loModelo) == 'O' ;
                        AND loModelo.obtener_codigo() != ;
                            THIS.oModelo.obtener_codigo() THEN
                    RETURN 'Nombre: ' + YA_EXISTE
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC

    **--------------------------------------------------------------------------
    PROTECTED FUNCTION validar_sifen
        LOCAL lcEtiqueta, lnSifen, loModelo
        lcEtiqueta = 'Sifen: '

        IF !EMPTY(THIS.cErrorNombre) THEN
            RETURN THIS.cErrorNombre
        ENDIF

        IF !EMPTY(THIS.cErrorDepartamen) THEN
            RETURN THIS.cErrorDepartamen
        ENDIF

        lnSifen = THIS.oModelo.obtener_sifen()

        IF lnSifen <= 0 THEN
            RETURN lcEtiqueta + MAYOR_QUE_CERO
        ENDIF

        IF lnSifen > 99999 THEN
            RETURN lcEtiqueta + ;
                STRTRAN(MENOR_QUE, '{}', ALLTRIM(STR(99999 + 1)))
        ENDIF

        loModelo = ;
            NEWOBJECT('sifen_ciudades', 'sifen_ciudades.prg', '', lnSifen)

        IF VARTYPE(loModelo) != 'O' THEN
            RETURN lcEtiqueta + STRTRAN(NO_EXISTE, '{}', ALLTRIM(STR(lnSifen)))
        ENDIF

        loModelo = THIS.oRepositorio.obtener_por_sifen(lnSifen)

        IF THIS.nBandera == 1 THEN    && Agregar
            IF VARTYPE(loModelo) == 'O' THEN
                RETURN lcEtiqueta + YA_EXISTE
            ENDIF
        ELSE
            IF THIS.nBandera == 2 THEN    && Modificar
                IF VARTYPE(loModelo) == 'O' ;
                        AND loModelo.obtener_codigo() != ;
                            THIS.oModelo.obtener_codigo() THEN
                    RETURN lcEtiqueta + YA_EXISTE
                ENDIF
            ENDIF
        ENDIF

        RETURN SPACE(0)
    ENDFUNC
ENDDEFINE
