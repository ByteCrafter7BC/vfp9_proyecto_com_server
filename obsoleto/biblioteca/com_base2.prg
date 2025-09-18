DEFINE CLASS com_base AS Session
    * Propiedades.
    PROTECTED cResultado
    PROTECTED oUtiles

    PROTECTED oConexion
    PROTECTED oRepositorio

    PROTECTED cClaseConexion
    PROTECTED cClaseModelo
    PROTECTED cClaseRepositorio
    PROTECTED cClaseValidador
    PROTECTED cModulo

    * Inicialización de propiedades.
    DataSession = 2    && 2 - Sesión de datos privada.

    **/
    * Constructor.
    *
    * @return boolean true (default)
    */
    PROTECTED FUNCTION Init
        * Ejecuta los comandos SET apropiados para los servidores COM.
        SET CPDIALOG OFF
        SET DELETED ON
        SET EXACT ON
        SET EXCLUSIVE ON
        SET REPROCESS TO 2 SECONDS
        SET RESOURCE OFF
        SET SAFETY OFF

        THIS.oUtiles = CREATEOBJECT('Utiles')
    ENDFUNC

    **/
    * Verifica la integridad referencial de un registro.
    *
    * @param integer tnCodigo
    * Código a ser verificado.
    *
    * @return boolean
    * true si está relacionado u ocurre un error y false en caso contrario.
    */
    FUNCTION EstaRelacionado(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve true si un registro está relacionado u ocurre un error, false en caso contrario.'

        LOCAL llRelacionado
        llRelacionado = .T.

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('IR') AND ;
                THIS.EstablecerRepositorio() THEN
            llRelacionado = THIS.oRepositorio.EstaRelacionado(tnCodigo)
        ENDIF

        * Devuelve el resultado.
        RETURN llRelacionado
    ENDFUNC

    **/
    * Verifica si un código existe.
    *
    * @param integer tnCodigo
    * Código a ser verificado.
    *
    * @return boolean
    * true si existe u ocurre un error y false en caso contrario.
    */
    FUNCTION CodigoExiste(tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Devuelve true si existe el código u ocurre un error, false en caso contrario.'

        LOCAL llExiste
        llExiste = .T.

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            llExiste = THIS.oRepositorio.CodigoExiste(tnCodigo)
        ENDIF

        * Devuelve el resultado.
        RETURN llExiste
    ENDFUNC

    **/
    * Verifica si un nombre existe.
    *
    * @param string tcNombre
    * Nombre a ser verificado.
    *
    * @return boolean
    * true si existe u ocurre un error y false en caso contrario.
    */
    FUNCTION NombreExiste(tcNombre AS String) AS Logical ;
        HELPSTRING 'Devuelve true si existe el nombre u ocurre un error, false en caso contrario.'

        LOCAL llExiste
        llExiste = .T.

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            llExiste = THIS.oRepositorio.NombreExiste(tcNombre)
        ENDIF

        * Devuelve el resultado.
        RETURN llExiste
    ENDFUNC

    **/
    * Realiza una búsqueda por código.
    *
    * @param integer tnCodigo
    * Código a buscar.
    *
    * @return string
    * Cadena XML con los datos de un registro.
    */
    FUNCTION ObtenerPorCodigo(tnCodigo AS Integer) AS String ;
        HELPSTRING 'Devuelve una cadena XML con los datos de un registro.'

        LOCAL lcXML

        * Crea el cursor que contendrá el resultado de la búsqueda.
        THIS.CrearCursorResultado()

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.CargarObjetoAlCursorResultado( ;
                THIS.oRepositorio.ObtenerPorCodigo(tnCodigo))
        ENDIF

        * Convierte el cursor de resultado de la búsqueda en una cadena de
        * caracteres XML.
        CURSORTOXML(THIS.cResultado, 'lcXML', 0, 0, 0, '1')
        USE IN (THIS.cResultado)

        * Devuelve el resultado.
        RETURN lcXML
    ENDFUNC

    **/
    * Realiza una búsqueda por nombre.
    *
    * @param string tcNombre
    * Nombre a buscar.
    *
    * @return string
    * Cadena XML con los datos de un registro.
    */
    FUNCTION ObtenerPorNombre(tcNombre AS String) AS String ;
        HELPSTRING 'Devuelve una cadena XML con los datos de un registro.'

        LOCAL lcXML

        * Crea el cursor que contendrá el resultado de la búsqueda.
        THIS.CrearCursorResultado()

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.CargarObjetoAlCursorResultado( ;
                THIS.oRepositorio.ObtenerPorNombre(tcNombre))
        ENDIF

        * Convierte el cursor de resultado de la búsqueda en una cadena de
        * caracteres XML.
        CURSORTOXML(THIS.cResultado, 'lcXML', 0, 0, 0, '1')
        USE IN (THIS.cResultado)

        * Devuelve el resultado.
        RETURN lcXML
    ENDFUNC

    **/
    * Devuelve todos los datos de todos los registros.
    *
    * @return string
    * Cadena XML con todos los datos de todos los registros.
    */
    FUNCTION ObtenerTodos(tcCondicionFiltrado AS String) AS String ;
        HELPSTRING ;
            'Devuelve una cadena XML con todos los datos de todos los registros.'

        LOCAL lcCursor, lcXML
        lcCursor = THIS.oUtiles.CreaTemp()

        * Crea el cursor que contendrá el resultado de la búsqueda.
        THIS.CrearCursorResultado()

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.oRepositorio.ObtenerTodos(lcCursor, tcCondicionFiltrado)

            * Copia los registros del cursor temporal al cursor de resultado de
            * la búsqueda.
            IF USED(lcCursor) THEN
                SELECT (lcCursor)
                SCAN ALL
                    SCATTER MEMVAR MEMO
                    INSERT INTO (THIS.cResultado) FROM MEMVAR
                ENDSCAN

                SELECT (lcCursor)
                USE
            ENDIF
        ENDIF

        * Convierte el cursor de resultado de la búsqueda en una cadena de
        * caracteres XML.
        CURSORTOXML(THIS.cResultado, 'lcXML', 0, 0, 0, '1')
        USE IN (THIS.cResultado)

        * Devuelve el resultado.
        RETURN lcXML
    ENDFUNC

    **/
    * Devuelve todos los datos de los registros que coincidan con el criterio de
    * búsqueda.
    *
    * @return string
    * Cadena XML con todos los datos de los registros que coincidan con el
    * criterio de búsqueda.
    */
    FUNCTION Obtener(tcExpresion AS String, ;
            tcCondicionFiltrado AS String) AS String ;
        HELPSTRING ;
            'Devuelve una cadena XML con los registros que coincidan con el criterio de búsqueda.'

        LOCAL lcCursor, lcXML
        lcCursor = THIS.oUtiles.CreaTemp()

        * Crea el cursor que contendrá el resultado de la búsqueda.
        THIS.CrearCursorResultado()

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.oRepositorio.Obtener(tcExpresion, lcCursor, ;
                tcCondicionFiltrado)

            * Copia los registros del cursor temporal al cursor de resultado de
            * la búsqueda.
            IF USED(lcCursor) THEN
                SELECT (lcCursor)
                SCAN ALL
                    SCATTER MEMVAR MEMO
                    INSERT INTO (THIS.cResultado) FROM MEMVAR
                ENDSCAN

                SELECT (lcCursor)
                USE
            ENDIF
        ENDIF

        * Convierte el cursor de resultado de la búsqueda en una cadena de
        * caracteres XML.
        CURSORTOXML(THIS.cResultado, 'lcXML', 0, 0, 0, '1')
        USE IN (THIS.cResultado)

        * Devuelve el resultado.
        RETURN lcXML
    ENDFUNC

    **/
    * Devuelve un objeto de transferencia de datos (DTO) vacío.
    *
    * El patrón DTO tiene como finalidad de crear un objeto plano (POJO) con una
    * serie de atributos que puedan ser enviados o recuperados del servidor en
    * una sola invocación, de tal forma que un DTO puede contener información de
    * múltiples fuentes o tablas y concentrarlas en una única clase simple.
    * https://www.oscarblancarteblog.com/2018/11/30/data-transfer-object-dto-patron-diseno/
    *
    * @return object
    * Objeto de transferencia de datos (DTO) si tiene éxito y objeto vacío (objeto
    * sin propiedades ni métodos) en caso contrario.
    */
    FUNCTION ObtenerDTO AS Object ;
        HELPSTRING ;
            'Devuelve un objeto plano (POJO) con una serie de atributos que puedan ser enviados o recuperados del servidor.'

        LOCAL loDTO
        loDTO = THIS.ObtenerModeloVacio()

        IF VARTYPE(loDTO) != 'O' THEN
            loDTO = CREATEOBJECT('EMPTY')
        ENDIF

        RETURN loDTO
    ENDFUNC

    **/
    * Agrega un nuevo registro a la base de datos.
    *
    * @param integer tnUsuario
    * Código del usuario.
    *
    * @param object toDTO
    * Objeto a ser agregado.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    FUNCTION Agregar(tnUsuario AS Integer, toDTO AS Object) AS Logical ;
        HELPSTRING 'Agrega un nuevo registro a la base de datos.'

        * Determina si el usuario tiene permiso para agregar registros.
        IF !THIS.UsuarioPuedeAgregar(tnUsuario) THEN
            RETURN .F.
        ENDIF

        * Determina si el validador es válido.
        IF !THIS.ValidarClaseValidador() THEN
            RETURN .F.
        ENDIF

        LOCAL llAgregado, loValidadorFactory, loValidador
        llAgregado = .F.
        loValidadorFactory = CREATEOBJECT(THIS.cClaseValidador)
        loValidador = loValidadorFactory.CrearValidador(toDTO, 1)

        IF VARTYPE(loValidador) == 'O' AND loValidador.EsValido() THEN
            * Agrega un nuevo registro a la base de datos.
            IF THIS.EstablecerConexion('MANTENIMIENTO') AND ;
                    THIS.EstablecerRepositorio() THEN
                llAgregado = THIS.oRepositorio.Agregar(toDTO)
            ENDIF
        ENDIF

        * Devuelve el resultado.
        RETURN llAgregado
    ENDFUNC

    **/
    * Modifica un registro de la base de datos.
    *
    * @param integer tnUsuario
    * Código del usuario.
    *
    * @param object toDTO
    * Objeto a ser modificado.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    FUNCTION Modificar(tnUsuario AS Integer, toDTO AS Object) AS Logical ;
        HELPSTRING 'Modifica un registro de la base de datos.'

        * Determina si el usuario tiene permiso para agregar registros.
        IF !THIS.UsuarioPuedeModificar(tnUsuario) THEN
            RETURN .F.
        ENDIF

        * Si el registro esta relacionado se asegura de que el valor del
        * campo 'nombre' no cambie.
        toDTO = THIS.VerificarDTO(toDTO)

        * Determina si el validador es válido.
        IF !THIS.ValidarClaseValidador() THEN
            RETURN .F.
        ENDIF

        LOCAL llModificado, loValidadorFactory, loValidador
        llModificado = .F.
        loValidadorFactory = CREATEOBJECT(THIS.cClaseValidador)
        loValidador = loValidadorFactory.CrearValidador(toDTO, 2)

        IF VARTYPE(loValidador) == 'O' AND loValidador.EsValido() THEN
            * Modifica un registro de la base de datos.
            IF THIS.EstablecerConexion('MANTENIMIENTO') AND ;
                    THIS.EstablecerRepositorio() THEN
                llModificado = THIS.oRepositorio.Modificar(toDTO)
            ENDIF
        ENDIF

        * Devuelve el resultado.
        RETURN llModificado
    ENDFUNC

    **/
    * Borra un registro de la base de datos.
    *
    * @param integer tnUsuario
    * Código del usuario.
    *
    * @param integer tnCodigo
    * Código a ser borrado.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    FUNCTION Borrar(tnUsuario AS Integer, tnCodigo AS Integer) AS Logical ;
        HELPSTRING 'Borra un registro de la base de datos.'

        * Determina si el usuario tiene permiso para agregar registros.
        IF !THIS.UsuarioPuedeBorrar(tnUsuario) THEN
            RETURN .F.
        ENDIF

        LOCAL llBorrado
        llBorrado = .F.

        * Borra un registro de la base de datos.
        IF THIS.EstablecerConexion('MANTENIMIENTO') AND ;
                THIS.EstablecerRepositorio() THEN
            llBorrado = THIS.oRepositorio.Borrar(tnCodigo)
        ENDIF

        * Devuelve el resultado.
        RETURN llBorrado
    ENDFUNC

    **/
    * Establece el objeto 'oConexion'.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerConexion
        LPARAMETERS tcTipo

        * inicio { validaciones del parámetro }
        IF !THIS.oUtiles.ValidarTexto(tcTipo, 2, 13) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        LOCAL loConexionFactory, loConexion

        TRY
            loConexionFactory = CREATEOBJECT(THIS.cClaseConexion)

            IF VARTYPE(loConexionFactory) == 'O' THEN
                loConexion = loConexionFactory.CrearConexion(tcTipo)
            ENDIF
        CATCH TO loExcepcion
        ENDTRY

        IF VARTYPE(loConexion) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oConexion = loConexion
    ENDFUNC

    **/
    * Establece el objeto 'oRepositorio'.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerRepositorio
        LOCAL loDAOFactory, loRepositorio

        TRY
            loDAOFactory = CREATEOBJECT(THIS.cClaseRepositorio)

            IF VARTYPE(loDAOFactory) == 'O' THEN
                loRepositorio = loDAOFactory.CrearDAO(THIS.oConexion)
            ENDIF
        CATCH TO loExcepcion
        ENDTRY

        IF VARTYPE(loRepositorio) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oRepositorio = loRepositorio
    ENDFUNC

    **/
    * Crea el cursor que contendrá el resultado de la búsqueda.
    *
    * @return boolean true (default)
    */
    PROTECTED PROCEDURE CrearCursorResultado
        THIS.cResultado = THIS.oUtiles.CreaTemp()

        CREATE CURSOR (THIS.cResultado) ( ;
            codigo N(4), ;
            nombre C(30), ;
            vigente L(1) ;
        )
    ENDPROC

    **/
    * Carga los datos de un objeto (value object) al cursor de resultado de la
    * búsqueda.
    *
    * @return boolean true (default)
    */
    PROTECTED PROCEDURE CargarObjetoAlCursorResultado
        LPARAMETERS toModelo

        LOCAL loExcepcion

        IF VARTYPE(toModelo) == 'O' THEN
            TRY
                SELECT (THIS.cResultado)
                APPEND BLANK
                REPLACE codigo WITH toModelo.ObtenerCodigo(), ;
                        nombre WITH toModelo.ObtenerNombre(), ;
                        vigente WITH toModelo.EstaVigente()
            CATCH TO loExcepcion
            ENDTRY
        ENDIF
    ENDPROC

    **/
    * Determina si la propiedad 'cClaseModelo' es válida.
    *
    * @return boolean
    * true si es válida y false en caso contrario.
    */
    PROTECTED FUNCTION ValidarClaseModelo
        LOCAL llEsValido, loModelo
        llEsValido = .F.

        IF VARTYPE(THIS.cClaseModelo) == 'C' AND !EMPTY(THIS.cClaseModelo) THEN
            TRY
                loModelo = CREATEOBJECT(THIS.cClaseModelo)

                IF VARTYPE(loModelo) == 'O' THEN
                    llEsValido = .T.
                ENDIF
            CATCH TO loExcepcion
            ENDTRY
        ENDIF

        RETURN llEsValido
    ENDFUNC

    **/
    * Devuelve una instancia de la clase modelo; establecida en la
    * propiedad 'cClaseModelo'.
    *
    * @return object|boolean
    * object si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION ObtenerModeloVacio
        LOCAL loModelo
        loModelo = .F.

        IF THIS.ValidarClaseModelo() THEN
            loModelo = CREATEOBJECT(THIS.cClaseModelo)
        ENDIF

        RETURN loModelo
    ENDFUNC

    **/
    * Determina si la propiedad 'cClaseValidador' es válida.
    *
    * @return boolean
    * true si es válida y false en caso contrario.
    */
    PROTECTED FUNCTION ValidarClaseValidador
        LOCAL llEsValido, loValidador
        llEsValido = .F.

        IF VARTYPE(THIS.cClaseValidador) == 'C' AND ;
                !EMPTY(THIS.cClaseValidador) AND ;
                THIS.ValidarClaseModelo() THEN
            TRY
                loValidador = CREATEOBJECT(THIS.cClaseValidador)

                IF VARTYPE(loValidador) == 'O' THEN
                    llEsValido = .T.
                ENDIF
            CATCH TO loExcepcion
            ENDTRY
        ENDIF

        RETURN llEsValido
    ENDFUNC

    **/
    * Verifica si un usuario puede agregar registros.
    *
    * @param integer tnUsuario
    * Código del usuario.
    *
    * @return boolean
    * true si tiene permiso para agregar registros y false en caso contrario.
    */
    PROTECTED FUNCTION UsuarioPuedeAgregar
        LPARAMETERS tnUsuario

        LOCAL llAgregar
        llAgregar = .F.

        toPermiso = CREATEOBJECT('Permiso')

        IF VARTYPE(toPermiso) == 'O' THEN
            llAgregar = toPermiso.PuedeAgregar(tnUsuario, THIS.cModulo)
        ENDIF

        RETURN llAgregar
    ENDFUNC

    **/
    * Verifica si un usuario puede modificar registros.
    *
    * @param integer tnUsuario
    * Código del usuario.
    *
    * @return boolean
    * true si tiene permiso para modificar registros y false en caso contrario.
    */
    PROTECTED FUNCTION UsuarioPuedeModificar
        LPARAMETERS tnUsuario

        LOCAL llModificar
        llModificar = .F.

        toPermiso = CREATEOBJECT('Permiso')

        IF VARTYPE(toPermiso) == 'O' THEN
            llModificar = toPermiso.PuedeModificar(tnUsuario, THIS.cModulo)
        ENDIF

        RETURN llModificar
    ENDFUNC

    **/
    * Verifica si un usuario puede borrar registros.
    *
    * @param integer tnUsuario
    * Código del usuario.
    *
    * @return boolean
    * true si tiene permiso para borrar registros y false en caso contrario.
    */
    PROTECTED FUNCTION UsuarioPuedeBorrar
        LPARAMETERS tnUsuario

        LOCAL llBorrar
        llBorrar = .F.

        toPermiso = CREATEOBJECT('Permiso')

        IF VARTYPE(toPermiso) == 'O' THEN
            llBorrar = toPermiso.PuedeBorrar(tnUsuario, THIS.cModulo)
        ENDIF

        RETURN llBorrar
    ENDFUNC

    **/
    * Verifica que los campos que no deben modificarse permanezcan así.
    *
    * @param object toDTO
    * Objeto a ser verificado.
    *
    * @return object
    * Objeto de transferencia de datos (DTO).
    */
    PROTECTED FUNCTION VerificarDTO
        LPARAMETERS toDTO

        LOCAL llEstaRelacionado, loModelo
        llEstaRelacionado = THIS.EstaRelacionado(toDto.ObtenerCodigo())

        IF llEstaRelacionado THEN
            * Realiza la búsqueda.
            IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                    THIS.EstablecerRepositorio() THEN
                loModelo = ;
                    THIS.oRepositorio.ObtenerPorCodigo(toDto.ObtenerCodigo())
            ENDIF
        ENDIF

        IF VARTYPE(loModelo) == 'O' THEN
            toDTO.EstablecerNombre(loModelo.ObtenerNombre())
        ENDIF

        RETURN toDTO
    ENDFUNC
ENDDEFINE
