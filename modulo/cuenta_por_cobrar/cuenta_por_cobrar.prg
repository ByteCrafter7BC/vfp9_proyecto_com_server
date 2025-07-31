#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS CuentaPorCobrar AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'ConexionCuentaPorCobrarFactory'
    cClaseRepositorio = 'CuentaPorCobrarDAOFactory'

    **/
    * Realiza una búsqueda por código de cliente.
    *
    * @param integer tnCodigo
    * Código a buscar.
    *
    * @param string tcCondicionFiltrado (opcional)
    * Condición de filtrado de registros.
    *
    * @return string
    * Cadena XML con todas las cuentas por cobrar de un cliente.
    */
    * @Override
    FUNCTION ObtenerPorCodigo(tnCodigo AS Integer, ;
            tcCondicionFiltrado AS String) AS String ;
        HELPSTRING ;
            'Devuelve una cadena XML con todas las cuentas por cobrar de un cliente.'

        LOCAL lcCursor, lcXML
        lcCursor = THIS.oUtiles.CreaTemp()

        * Crea el cursor que contendrá el resultado de la búsqueda.
        THIS.CrearCursorResultado()

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.oRepositorio.ObtenerPorCodigo(tnCodigo, lcCursor, ;
                tcCondicionFiltrado)

            * Copia los registros del cursor temporal al cursor de resultado de
            * la búsqueda.
            IF USED(lcCursor) THEN
                SELECT (lcCursor)
                SCAN ALL
                    SCATTER MEMVAR MEMO
                    m.nrofact = ;
                        THIS.oUtiles.FormatearNumeroFacturaVenta(m.nrodocu)
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
    * Crea el cursor que contendrá el resultado de la búsqueda.
    *
    * @return boolean true (default)
    */
    * @Override
    PROTECTED PROCEDURE CrearCursorResultado
        THIS.cResultado = THIS.oUtiles.CreaTemp()

        CREATE CURSOR (THIS.cResultado) ( ;
            tipodocu N(1), ;
            nrodocu N(7), ;
            nrofact C(15), ;
            cuota C(7), ;
            fecha_emi D(8), ;
            fecha_vto D(8), ;
            saldo N(14,2), ;
            dias N(5), ;
            cod_moneda N(4), ;
            moneda C(30), ;
            simbolo C(4), ;
            decimales L(1), ;
            cod_cliente N(5), ;
            cliente C(56), ;
            ruc C(15), ;
            direccion C(60), ;
            departamen C(30), ;
            ciudad C(30), ;
            telefono C(30) ;
        )
    ENDPROC

ENDDEFINE