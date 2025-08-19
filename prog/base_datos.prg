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
