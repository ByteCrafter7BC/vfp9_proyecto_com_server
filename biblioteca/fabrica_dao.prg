**/
* fabrica_dao.prg
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

**/
* @abstract_class
* F�brica para crear y gestionar objetos de acceso a datos (DAO).
* Implementa el patr�n Factory Method para diferentes motores de base de datos.
*/

#INCLUDE 'constantes.h'

DEFINE CLASS fabrica_dao AS Custom
    **/
    * Prefijo para los nombres de clases DAO.
    * Ejemplos: 'dao_dbf_', 'dao_firebird_', 'dao_mysql_', 'dao_postgres_', etc.
    * @protected
    * @var Character
    */
    PROTECTED cPrefijoDao

    **/
    * Matriz que almacena los objetos DAO creados.
    * Estructura: [n, 1] = nombre del modelo, [n, 2] = objeto DAO.
    * @protected
    * @var Array
    */
    PROTECTED aDao[1, 2]

    **/
    * @method obtener_fabrica_dao
    *
    * @purpose Obtener una f�brica de DAO espec�fica seg�n el tipo de base de
    *          datos.
    *
    * @access public
    *
    * @param tnCualFabrica {Numeric} Representa el tipo de base de datos:
    *                                BD_DBF       = 1 (Base de datos DBF nativa)
    *                                BD_FIREBIRD  = 2 (Base de datos Firebird)
    *                                BD_MYSQL     = 3 (Base de datos MySQL)
    *                                BD_POSTGRES  = 4 (Base de datos PostgreSQL)
    *
    * @return {Object|Logical} Object instancia de la f�brica de DAO solicitada.
    *                          .F. si el par�metro es inv�lido o no se puede
    *                              crear la f�brica.
    *
    * @description Esta funci�n act�a como Factory Method para crear instancias
    *              de f�bricas de DAO espec�ficas seg�n el motor de base de
    *              datos.
    *              Utiliza el patr�n de dise�o Factory para desacoplar la
    *              creaci�n de objetos del c�digo cliente.
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
    * @method obtener
    *
    * @purpose Obtiene el objeto DAO para un modelo espec�fico (patr�n
    *          Singleton).
    *
    * @access public
    *
    * @param tcModelo {Character} Nombre del modelo/tabla solicitado.
    *
    * @return {Object|Logical} Object instancia del DAO solicitado.
    *                          .F. si no existe o error.
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

    **/ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
    *                            PROTECTED METHODS                            *
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

    **/
    * @constructor
    *
    * @method Init
    *
    * @purpose Constructor de la clase.
    *
    * @access protected
    *
    * @return {Logical} .T. si �xito, .F. si falla.
    *
    * @description Inicializa la matriz de DAOs.
    *
    */
    PROTECTED FUNCTION Init
        DIMENSION THIS.aDao[14, 2]

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
            .aDao[12, 1] = 'rubros1'
            .aDao[13, 1] = 'rubros2'
            .aDao[14, 1] = 'vendedor'
        ENDWITH
    ENDFUNC

    **/
    * @method crear
    *
    * @purpose Crea una nueva instancia del DAO para el modelo especificado.
    *
    * @access protected
    *
    * @param tcModelo {Character} Nombre del modelo/tabla a instanciar.
    *
    * @return {Object|Logical} Object instancia del DAO.
    *                          .F. si falla.
    *
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
