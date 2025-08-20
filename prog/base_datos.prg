**/
* base_datos() procedimiento
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

**------------------------------------------------------------------------------
CREATE TABLE maquinas (;
    codigo N(3), ;
    nombre C(30), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE

**------------------------------------------------------------------------------
CREATE TABLE marcas1 (;
    codigo N(4), ;
    nombre C(30), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE

**------------------------------------------------------------------------------
CREATE TABLE marcas2 (;
    codigo N(4), ;
    nombre C(30), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE

**------------------------------------------------------------------------------
CREATE TABLE modelos (;
    codigo N(4), ;
    nombre C(30), ;
    maquina N(4), ;
    marca N(4), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE
