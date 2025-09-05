**/
* base_datos.prg
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

**------------------------------------------------------------------------------
CREATE TABLE barrios (;
    codigo N(5), ;
    nombre C(30), ;
    departamen N(3), ;
    ciudad N(5), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE

**------------------------------------------------------------------------------
CREATE TABLE depar (;
    codigo N(3), ;
    nombre C(30), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE

**------------------------------------------------------------------------------
CREATE TABLE ciudades (;
    codigo N(5), ;
    nombre C(30), ;
    departamen N(3), ;
    sifen N(5), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE

**------------------------------------------------------------------------------
CREATE TABLE cobrador (;
    codigo N(3), ;
    nombre C(30), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE

**------------------------------------------------------------------------------
CREATE TABLE familias (;
    codigo N(4), ;
    nombre C(30), ;
    p1 N(6,2), ;
    p2 N(6,2), ;
    p3 N(6,2), ;
    p4 N(6,2), ;
    p5 N(6,2), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE

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
CREATE TABLE mecanico (;
    codigo N(3), ;
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

**------------------------------------------------------------------------------
CREATE TABLE proceden (;
    codigo N(4), ;
    nombre C(30), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE

**------------------------------------------------------------------------------
CREATE TABLE rubros1 (;
    codigo N(4), ;
    nombre C(30), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE

**------------------------------------------------------------------------------
CREATE TABLE rubros2 (;
    codigo N(4), ;
    nombre C(30), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE

**------------------------------------------------------------------------------
CREATE TABLE vendedor (;
    codigo N(3), ;
    nombre C(30), ;
    vigente L(1) ;
)

INDEX ON codigo TAG 'indice1' FOR !DELETED() &&CANDIDATE
INDEX ON UPPER(nombre) TAG 'indice2' FOR !DELETED() &&CANDIDATE
