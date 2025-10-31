**/
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
* Clase principal que act�a como una F�brica (Factory) para crear objetos DAO
* (Data Access Object) espec�ficos.
*
* Utiliza un patr�n Singleton para gestionar la creaci�n y el acceso a las
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
    * @section M�TODOS P�BLICOS
    * @method mixed obtener_fabrica_dao(int tnCualFabrica)
    * @method mixed obtener(string tcModelo)
    */

    **/
    * Devuelve la instancia de la f�brica DAO espec�fica para un tipo de base
    * de datos.
    *
    * @param int tnCualFabrica Constante que identifica el tipo de base de
    *                          datos, ejemplos:
    *                          BD_DBF       = 1 (Base de datos DBF nativa).
    *                          BD_FIREBIRD  = 2 (Base de datos Firebird).
    *                          BD_MYSQL     = 3 (Base de datos MySQL).
    *                          BD_POSTGRES  = 4 (Base de datos PostgreSQL).
    * @return mixed object Instancia de la clase f�brica DAO espec�fica;
    *               .F. si el par�metro es inv�lido o si la instancia no se
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
    * Devuelve la instancia del objeto DAO para un modelo espec�fico.
    *
    * Si la instancia del DAO para el modelo ya existe, la devuelve. De lo
    * contrario, la crea, la almacena en el arreglo 'aDao' y luego la devuelve.
    *
    * @param string tcModelo Nombre del modelo (entidad) para el cual se
    *                        requiere el objeto DAO (ejemplos: 'ciudades',
    *                        'clientes', 'proveedores', etc.).
    * @return mixed object Instancia del objeto DAO del modelo solicitado;
    *               .F. si el modelo es inv�lido o si el objeto DAO no pudo ser
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
    * @section M�TODOS PROTEGIDOS
    * @method bool Init()
    * @method mixed crear(string tcModelo)
    */

    **/
    * Constructor de la clase.
    *
    * Inicializa el arreglo bidimensional 'aDao' con una lista de modelos
    * predefinidos y sus respectivas implementaciones de DAO.
    *
    * @return bool .T. si la inicializaci�n fue completada correctamente;
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
    * Crea una instancia del objeto DAO para un modelo espec�fico.
    *
    * @param string tcModelo Nombre del modelo (entidad) para el que se crear�
    *                        la instancia del DAO.
    * @return mixed object Instancia del objeto DAO creado;
    *               .F. si el modelo es inv�lido o si la instancia no pudo ser
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
