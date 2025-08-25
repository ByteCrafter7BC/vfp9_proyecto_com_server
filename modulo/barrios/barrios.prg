**/
* barrios.prg
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

DEFINE CLASS barrios AS modelo_base OF modelo_base.prg
    PROTECTED nDepartamen
    PROTECTED nCiudad

    **--------------------------------------------------------------------------
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnDepartamen, tnCiudad, tlVigente

        IF !modelo_base::Init(tnCodigo, tcNombre, tlVigente) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnDepartamen) != 'N' ;
                OR VARTYPE(tnCiudad) != 'N' THEN
            RETURN .F.
        ENDIF

        WITH THIS
            .nDepartamen = tnDepartamen
            .nCiudad = tnCiudad
        ENDWITH
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_departamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION obtener_ciudad
        RETURN THIS.nCiudad
    ENDFUNC

    **--------------------------------------------------------------------------
    FUNCTION es_igual
        LPARAMETERS toModelo

        IF !modelo_base::es_igual(toModelo) THEN
            RETURN .F.
        ENDIF

        IF toModelo.obtener_departamen() != THIS.nDepartamen ;
                OR toModelo.obtener_ciudad() != THIS.nCiudad THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
