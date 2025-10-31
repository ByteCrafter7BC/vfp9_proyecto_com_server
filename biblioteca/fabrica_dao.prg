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
* @file fabrica_dao.prg
* @package biblioteca
* @author ByteCrafter7BC <bytecrafter7bc@gmail.com>
* @version 1.0.0
* @since 1.0.0
* @abstract
* @class fabrica_dao
* @extends Custom
* @uses constantes.h, fabrica_dao_dbf
*/

**/
* Clase principal que actúa como una Fábrica (Factory) para crear objetos DAO
* (Data Access Object) específicos.
*
* Utiliza un patrón Singleton para gestionar la creación y el acceso a las
* implementaciones de los objetos DAO, asegurando que solo se instancie
* una vez cada tipo de objeto.
*/
#INCLUDE 'constantes.h'

DEFINE CLASS fabrica_dao AS Custom
    **/
    * @var string Prefijo para los nombres de las clases DAO.
    * @example 'dao_dbf_', 'dao_firebird_', 'dao_mysql_', 'dao_postgres_', etc.
    */
    PROTECTED cPrefijoDao

    **/
    * @var array Arreglo bidimensional que almacena la lista de modelos y las
    *            instancias de sus respectivos objetos DAO.
    * @structure [n, 1] = nombre del modelo, [n, 2] = objeto DAO.
    */
    PROTECTED aDao[1, 2]

    **/
    * @section MÉTODOS PÚBLICOS
    * @method mixed obtener_fabrica_dao(int tnCualFabrica)
    * @method mixed obtener(string tcModelo)
    */

    **/
    * Devuelve la instancia de la fábrica DAO específica para un tipo de base
    * de datos.
    *
    * @param int tnCualFabrica Constante que identifica el tipo de base de
    *                          datos, ejemplos:
    *                          BD_DBF       = 1 (Base de datos DBF nativa).
    *                          BD_FIREBIRD  = 2 (Base de datos Firebird).
    *                          BD_MYSQL     = 3 (Base de datos MySQL).
    *                          BD_POSTGRES  = 4 (Base de datos PostgreSQL).
    * @return mixed object Instancia de la clase fábrica DAO específica;
    *               .F. si el parámetro es inválido o si la instancia no se
    *               pudo crear.
    */
    FUNCTION obtener_fabrica_dao
        LPARAMETERS tnCualFabrica

        IF VARTYPE(tnCualFabrica) != 'N' OR !BETWEEN(tnCualFabrica, 1, 4) THEN
            RETURN .F.
        ENDIF

        LOCAL lcFabricaDao, loFabricaDao

        DO CASE
        CASE tnCualFabrica == BD_DBF
            lcFabricaDao = 'fabrica_dao_dbf'
        CASE tnCualFabrica == BD_FIREBIRD
            lcFabricaDao = 'fabrica_dao_firebird'
        CASE tnCualFabrica == BD_MYSQL
            lcFabricaDao = 'fabrica_dao_mysql'
        CASE tnCualFabrica == BD_POSTGRES
            lcFabricaDao = 'fabrica_dao_postgres'
        ENDCASE

        IF VARTYPE(lcFabricaDao) == 'C' AND !EMPTY(lcFabricaDao) THEN
            TRY
                loFabricaDao = NEWOBJECT(lcFabricaDao, lcFabricaDao + '.prg')
            CATCH TO loException
                registrar_error('fabrica_dao', 'obtener_fabrica_dao',
                    loExcepcion.Message)
            ENDTRY
        ENDIF

        RETURN loFabricaDao
    ENDFUNC

    **/
    * Devuelve la instancia del objeto DAO para un modelo específico.
    *
    * Si la instancia del DAO para el modelo ya existe, la devuelve. De lo
    * contrario, la crea, la almacena en el arreglo 'aDao' y luego la devuelve.
    *
    * @param string tcModelo Nombre del modelo (entidad) para el cual se
    *                        requiere el objeto DAO (ejemplos: 'ciudades',
    *                        'clientes', 'proveedores', etc.).
    * @return mixed object Instancia del objeto DAO del modelo solicitado;
    *               .F. si el modelo es inválido o si el objeto DAO no pudo ser
    *               creado.
    */
    FUNCTION obtener
        LPARAMETERS tcModelo

        IF VARTYPE(tcModelo) == 'C' AND !EMPTY(tcModelo) THEN
            tcModelo = LOWER(ALLTRIM(tcModelo))
        ELSE
            RETURN .F.
        ENDIF

        LOCAL lnFila
        lnFila = ASCAN(THIS.aDao, tcModelo, -1, -1, 1, 14)

        IF lnFila <= 0 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(THIS.aDao[lnFila, 2]) != 'O' THEN
            THIS.aDao[lnFila, 2] = THIS.crear(tcModelo)
        ENDIF

        IF VARTYPE(THIS.aDao[lnFila, 2]) != 'O' THEN
            RETURN .F.
        ENDIF

        RETURN THIS.aDao[lnFila, 2]
    ENDFUNC

    **/
    * @section MÉTODOS PROTEGIDOS
    * @method bool Init()
    * @method mixed crear(string tcModelo)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa el arreglo bidimensional 'aDao' con una lista de modelos
    * predefinidos y sus respectivas implementaciones de DAO.
    *
    * @return bool .T. si la inicialización fue completada correctamente;
    *              .F. en caso contrario.
    */
    PROTECTED FUNCTION Init
        DIMENSION THIS.aDao[16, 2]

        WITH THIS
            .aDao[01, 1] = 'barrios'
            .aDao[02, 1] = 'ciudades'
            .aDao[03, 1] = 'cobrador'
            .aDao[04, 1] = 'depar'
            .aDao[05, 1] = 'familias'
            .aDao[06, 1] = 'maquinas'
            .aDao[07, 1] = 'marcas1'
            .aDao[08, 1] = 'marcas2'
            .aDao[09, 1] = 'mecanico'
            .aDao[10, 1] = 'modelos'
            .aDao[11, 1] = 'proceden'
            .aDao[12, 1] = 'proveedo'
            .aDao[13, 1] = 'rubros1'
            .aDao[14, 1] = 'rubros2'
            .aDao[15, 1] = 'sifen_ciudades'
            .aDao[16, 1] = 'vendedor'
        ENDWITH
    ENDFUNC

    **/
    * Crea una instancia del objeto DAO para un modelo específico.
    *
    * @param string tcModelo Nombre del modelo (entidad) para el que se creará
    *                        la instancia del DAO.
    * @return mixed object Instancia del objeto DAO creado;
    *               .F. si el modelo es inválido o si la instancia no pudo ser
    *               creada.
    * @throws Exception Si no puede crear la instancia del DAO.
    */
    PROTECTED FUNCTION crear
        LPARAMETERS tcModelo

        IF VARTYPE(tcModelo) != 'C' OR EMPTY(tcModelo) THEN
            RETURN .F.
        ENDIF

        IF ASCAN(THIS.aDao, tcModelo, -1, -1, 1, 14) <= 0 THEN
            RETURN .F.
        ENDIF

        LOCAL lcClase, loObjeto, loExcepcion
        lcClase = THIS.cPrefijoDao + LOWER(ALLTRIM(tcModelo))

        TRY
            loObjeto = NEWOBJECT(lcClase, lcClase + '.prg')
        CATCH TO loExcepcion
            registrar_error('fabrica_dao', 'crear', loExcepcion.Message)
        ENDTRY

        RETURN loObjeto
    ENDFUNC
ENDDEFINE
