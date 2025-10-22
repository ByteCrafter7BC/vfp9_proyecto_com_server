DEFINE CLASS validador_proveedor AS Custom
    **/
    * @var array Arreglo bidimensional que almacena la estructura de la tabla.
    * @structure [n, 1] = nombre del campo (ej.: 'codigo', 'nombre', 'vigente'),
    *            [n, 2] = tipo de dato el campo (ej.: 'C', 'D', 'L', 'N', 'T'),
    *            [n, 3] = ancho del campo (ej.: 4, 30, 1),
    *            [n, 4] = decimales (posiciones decimales en caso de tipo 'N'),
    *            [n, 5] = etiqueta (ej.: 'Código: ', 'Nombre: ', 'Vigente: '),
    *            [n, 6] = nombre de la propiedad de la clase (ej.: 'nCodigo'),
    *            [n, 7] = getter de la clase (ej.: 'obtener_codigo'),
    *            [n, 8] = setter de la clase (ej.: 'establecer_codigo').
    */

    **/
    * Carga los campos a una propiedad de tipo arreglo de clase.
    *
    * Este método es llamado por el constructor ('Init').
    *
    * @return bool .T. si la carga se completa correctamente;
    *              .F. si ocurre un error.
    * @override
    */
    PROTECTED FUNCTION cargar_campos
        LOCAL lcCampo

        IF !THIS.agregar_campo('codigo', 'N', 05,, 'Código: ') THEN
            RETURN .F.
        ENDIF

        IF !THIS.agregar_campo('nombre', 'C', 40,, 'Nombre: ') THEN
            RETURN .F.
        ENDIF

        IF !THIS.agregar_campo('direc1', 'C', 60,, 'Dirección 1: ') THEN
            RETURN .F.
        ENDIF

        IF !THIS.agregar_campo('direc2', 'C', 60,, 'Dirección 2: ') THEN
            RETURN .F.
        ENDIF

        * Establece todos los campos sin signo (unsigned).
        IF !THIS.establecer_campo_sin_signo('codigo', .T.) ;
                OR !THIS.establecer_campo_sin_signo('dias_plazo', .T.) THEN
            RETURN .F.
        ENDIF

        * Establece todos los campos requeridos.
        IF !THIS.establecer_campo_requerido('codigo', .T.) ;
                OR !THIS.establecer_campo_requerido('nombre', .T.) ;
                OR !THIS.establecer_campo_requerido('ruc', .T.) THEN
            RETURN .F.
        ENDIF

        * Establece todos los getter y setter a verdadero (.T.).
        FOR lnContador = 1 TO ALEN(THIS.aCampo, 1)
            lcCampo = THIS.aCampo[lnContador, 01]    && Nombre del campo.

            IF !THIS.establecer_campo_getter(lcCampo, .T.) ;
                    OR !THIS.establecer_campo_setter(lcCampo, .T.) THEN
                RETURN .F.
            ENDIF
        ENDFOR


        THIS.aEstructuraTabla[05, 1] = 'ciudad'
        THIS.aEstructuraTabla[05, 2] = 'C'
        THIS.aEstructuraTabla[05, 3] = 25
        THIS.aEstructuraTabla[05, 5] = 'Ciudad: '

        THIS.aEstructuraTabla[06, 1] = 'telefono'
        THIS.aEstructuraTabla[06, 2] = 'C'
        THIS.aEstructuraTabla[06, 3] = 40
        THIS.aEstructuraTabla[06, 5] = 'Teléfono: '

        THIS.aEstructuraTabla[07, 1] = 'fax'
        THIS.aEstructuraTabla[07, 2] = 'C'
        THIS.aEstructuraTabla[07, 3] = 25
        THIS.aEstructuraTabla[07, 5] = 'Fax: '

        THIS.aEstructuraTabla[08, 1] = 'e_mail'
        THIS.aEstructuraTabla[08, 2] = 'C'
        THIS.aEstructuraTabla[08, 3] = 60
        THIS.aEstructuraTabla[08, 5] = 'E-mail: '
        THIS.aEstructuraTabla[08, 6] = 'cEmail'
        THIS.aEstructuraTabla[08, 7] = 'obtener_email'
        THIS.aEstructuraTabla[08, 8] = 'establecer_email'

        THIS.aEstructuraTabla[09, 1] = 'ruc'
        THIS.aEstructuraTabla[09, 2] = 'C'
        THIS.aEstructuraTabla[09, 3] = 15
        THIS.aEstructuraTabla[09, 5] = 'RUC: '

        THIS.aEstructuraTabla[10, 1] = 'dias_plazo'
        THIS.aEstructuraTabla[10, 2] = 'N'
        THIS.aEstructuraTabla[10, 3] = 3
        THIS.aEstructuraTabla[10, 5] = 'Crédito (días): '

        THIS.aEstructuraTabla[11, 1] = 'dueno'
        THIS.aEstructuraTabla[11, 2] = 'C'
        THIS.aEstructuraTabla[11, 3] = 40
        THIS.aEstructuraTabla[11, 5] = 'Propietario: '

        THIS.aEstructuraTabla[12, 1] = 'teldueno'
        THIS.aEstructuraTabla[12, 2] = 'C'
        THIS.aEstructuraTabla[12, 3] = 25
        THIS.aEstructuraTabla[12, 5] = 'Número de teléfono del Propietario: '

        THIS.aEstructuraTabla[13, 1] = 'gtegral'
        THIS.aEstructuraTabla[13, 2] = 'C'
        THIS.aEstructuraTabla[13, 3] = 40
        THIS.aEstructuraTabla[13, 5] = 'Gerente General: '

        THIS.aEstructuraTabla[14, 1] = 'telgg'
        THIS.aEstructuraTabla[14, 2] = 'C'
        THIS.aEstructuraTabla[14, 3] = 25
        THIS.aEstructuraTabla[14, 5] = ;
            'Número de teléfono del Gerente General: '

        THIS.aEstructuraTabla[15, 1] = 'gteventas'
        THIS.aEstructuraTabla[15, 2] = 'C'
        THIS.aEstructuraTabla[15, 3] = 40
        THIS.aEstructuraTabla[15, 5] = 'Gerente de Ventas: '

        THIS.aEstructuraTabla[16, 1] = 'telgv'
        THIS.aEstructuraTabla[16, 2] = 'C'
        THIS.aEstructuraTabla[16, 3] = 25
        THIS.aEstructuraTabla[16, 5] = ;
            'Número de teléfono del Gerente de Ventas: '

        THIS.aEstructuraTabla[17, 1] = 'gtemkg'
        THIS.aEstructuraTabla[17, 2] = 'C'
        THIS.aEstructuraTabla[17, 3] = 40
        THIS.aEstructuraTabla[17, 5] = 'Gerente de Marketing: '

        THIS.aEstructuraTabla[18, 1] = 'telgm'
        THIS.aEstructuraTabla[18, 2] = 'C'
        THIS.aEstructuraTabla[18, 3] = 25
        THIS.aEstructuraTabla[18, 5] = ;
            'Número de teléfono del Gerente de Marketing: '

        THIS.aEstructuraTabla[19, 1] = 'stecnico'
        THIS.aEstructuraTabla[19, 2] = 'C'
        THIS.aEstructuraTabla[19, 3] = 40
        THIS.aEstructuraTabla[19, 5] = 'Servicio Técnico: '

        THIS.aEstructuraTabla[20, 1] = 'stdirec1'
        THIS.aEstructuraTabla[20, 2] = 'C'
        THIS.aEstructuraTabla[20, 3] = 60
        THIS.aEstructuraTabla[20, 5] = 'Dirección 1 del Servicio Técnico: '

        THIS.aEstructuraTabla[21, 1] = 'direc2'
        THIS.aEstructuraTabla[21, 2] = 'C'
        THIS.aEstructuraTabla[21, 3] = 60
        THIS.aEstructuraTabla[21, 5] = 'Dirección 2 del Servicio Técnico: '

        THIS.aEstructuraTabla[22, 1] = 'sttel'
        THIS.aEstructuraTabla[22, 2] = 'C'
        THIS.aEstructuraTabla[22, 3] = 25
        THIS.aEstructuraTabla[22, 5] = ;
            'Número de teléfono del Servicio Técnico: '

        THIS.aEstructuraTabla[23, 1] = 'sthablar1'
        THIS.aEstructuraTabla[23, 2] = 'C'
        THIS.aEstructuraTabla[23, 3] = 60
        THIS.aEstructuraTabla[23, 5] = ;
            'Nombre del contacto del Servicio Técnico: '

        THIS.aEstructuraTabla[24, 1] = 'vendedor1'
        THIS.aEstructuraTabla[24, 2] = 'C'
        THIS.aEstructuraTabla[24, 3] = 40
        THIS.aEstructuraTabla[24, 5] = ;
            'Nombre del vendedor de la línea de artículos 1: '

        THIS.aEstructuraTabla[25, 1] = 'larti1'
        THIS.aEstructuraTabla[25, 2] = 'C'
        THIS.aEstructuraTabla[25, 3] = 25
        THIS.aEstructuraTabla[25, 5] = 'Línea de artículos 1: '

        THIS.aEstructuraTabla[26, 1] = 'tvend1'
        THIS.aEstructuraTabla[26, 2] = 'C'
        THIS.aEstructuraTabla[26, 3] = 25
        THIS.aEstructuraTabla[26, 5] = ;
            'Número de teléfono del vendedor de la línea de artículos 1: '

        THIS.aEstructuraTabla[27, 1] = 'vendedor2'
        THIS.aEstructuraTabla[27, 2] = 'C'
        THIS.aEstructuraTabla[27, 3] = 40
        THIS.aEstructuraTabla[27, 5] = ;
            'Nombre del vendedor de la línea de artículos 2: '

        THIS.aEstructuraTabla[28, 1] = 'larti2'
        THIS.aEstructuraTabla[28, 2] = 'C'
        THIS.aEstructuraTabla[28, 3] = 25
        THIS.aEstructuraTabla[28, 5] = 'Línea de artículos 2: '

        THIS.aEstructuraTabla[29, 1] = 'tvend2'
        THIS.aEstructuraTabla[29, 2] = 'C'
        THIS.aEstructuraTabla[29, 3] = 25
        THIS.aEstructuraTabla[29, 5] = ;
            'Número de teléfono del vendedor de la línea de artículos 2: '

        THIS.aEstructuraTabla[30, 1] = 'vendedor3'
        THIS.aEstructuraTabla[30, 2] = 'C'
        THIS.aEstructuraTabla[30, 3] = 40
        THIS.aEstructuraTabla[30, 5] = ;
            'Nombre del vendedor de la línea de artículos 3: '

        THIS.aEstructuraTabla[31, 1] = 'larti3'
        THIS.aEstructuraTabla[31, 2] = 'C'
        THIS.aEstructuraTabla[31, 3] = 25
        THIS.aEstructuraTabla[31, 5] = 'Línea de artículos 3: '

        THIS.aEstructuraTabla[32, 1] = 'tvend3'
        THIS.aEstructuraTabla[32, 2] = 'C'
        THIS.aEstructuraTabla[32, 3] = 25
        THIS.aEstructuraTabla[32, 5] = ;
            'Número de teléfono del vendedor de la línea de artículos 3: '

        THIS.aEstructuraTabla[33, 1] = 'vendedor4'
        THIS.aEstructuraTabla[33, 2] = 'C'
        THIS.aEstructuraTabla[33, 3] = 40
        THIS.aEstructuraTabla[33, 5] = ;
            'Nombre del vendedor de la línea de artículos 4: '

        THIS.aEstructuraTabla[34, 1] = 'larti4'
        THIS.aEstructuraTabla[34, 2] = 'C'
        THIS.aEstructuraTabla[34, 3] = 25
        THIS.aEstructuraTabla[34, 5] = 'Línea de artículos 4: '

        THIS.aEstructuraTabla[35, 1] = 'tvend4'
        THIS.aEstructuraTabla[35, 2] = 'C'
        THIS.aEstructuraTabla[35, 3] = 25
        THIS.aEstructuraTabla[35, 5] = ;
            'Número de teléfono del vendedor de la línea de artículos 4: '

        THIS.aEstructuraTabla[36, 1] = 'vendedor5'
        THIS.aEstructuraTabla[36, 2] = 'C'
        THIS.aEstructuraTabla[36, 3] = 40
        THIS.aEstructuraTabla[36, 5] = ;
            'Nombre del vendedor de la línea de artículos 5: '

        THIS.aEstructuraTabla[37, 1] = 'larti5'
        THIS.aEstructuraTabla[37, 2] = 'C'
        THIS.aEstructuraTabla[37, 3] = 25
        THIS.aEstructuraTabla[37, 5] = 'Línea de artículos 5: '

        THIS.aEstructuraTabla[38, 1] = 'tvend5'
        THIS.aEstructuraTabla[38, 2] = 'C'
        THIS.aEstructuraTabla[38, 3] = 25
        THIS.aEstructuraTabla[38, 5] = ;
            'Número de teléfono del vendedor de la línea de artículos 5: '

        THIS.aEstructuraTabla[39, 1] = 'saldo_actu'
        THIS.aEstructuraTabla[39, 2] = 'N'
        THIS.aEstructuraTabla[39, 3] = 12
        THIS.aEstructuraTabla[39, 5] = 'Saldo actual PYG: '

        THIS.aEstructuraTabla[40, 1] = 'saldo_usd'
        THIS.aEstructuraTabla[40, 2] = 'N'
        THIS.aEstructuraTabla[40, 3] = 12
        THIS.aEstructuraTabla[40, 4] = 2
        THIS.aEstructuraTabla[40, 5] = 'Saldo actual USD: '

        THIS.aEstructuraTabla[41, 1] = 'vigente'
        THIS.aEstructuraTabla[41, 2] = 'L'
        THIS.aEstructuraTabla[41, 3] = 1
        THIS.aEstructuraTabla[41, 5] = 'Vigente: '
    ENDFUNC

    PROTECTED FUNCTION agregar_campo
        LPARAMETERS tcCampo, tcTipo, tnAncho, tnDecimales, tcEtiqueta

        * inicio { validaciones de parámetros }
        IF PARAMETERS() < 4 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' ;
                OR tcTipo != 'C' ;
                OR tnAncho != 'N' ;
                OR tcEtiqueta != 'C' THEN
            RETURN .F.
        ENDIF

        IF EMPTY(tcCampo) ;
                OR EMPTY(tcTipo) ;
                OR EMPTY(tnAncho) ;
                OR EMPTY(tcEtiqueta) THEN
            RETURN .F.
        ENDIF

        * Character, Date, Logical, Numeric, Datetime
        IF !INLIST(tcTipo, 'C', 'D', 'L', 'N', 'T') THEN
            RETURN .F.
        ENDIF

        IF tcTipo == 'N' THEN
            IF !INLIST(VARTYPE(tnDecimales), 'L', 'N') THEN
                RETURN .F.
            ENDIF

            IF VARTYPE(tnDecimales) == 'N' THEN
                IF tnDecimales + 2 >= tnAncho THEN
                    RETURN .F.
                ENDIF
            ELSE
                tnDecimales = 0
            ENDIF
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL llSinSigno, llRequerido, llGetter, llSetter, ;
              lcUltimoError, lvValor, lnFila

        STORE .F. TO llSinSigno, llRequerido, llGetter, llSetter
        lcUltimoError = ''

        * Valor predeterminado para el campo.
        DO CASE
        CASE tcTipo == 'C'
            lvValor = ''
        CASE tcTipo == 'D'
            lvValor = {}
        CASE tcTipo == 'L'
            lvValor = .F.
        CASE tcTipo == 'N'
            lvValor = 0
        CASE tcTipo == 'T'
            lvValor = CTOT('')
        ENDCASE

        lnFila = IIF(VARTYPE(THIS.aCampo) != 'L', ALEN(THIS.aCampo, 1) + 1, 1)

        DIMENSION THIS.aCampo[lnFila, 11]
        THIS.aCampo[lnFila, 01] = tcCampo
        THIS.aCampo[lnFila, 02] = tcTipo
        THIS.aCampo[lnFila, 03] = tnAncho
        THIS.aCampo[lnFila, 04] = tnDecimales
        THIS.aCampo[lnFila, 05] = llSinSigno
        THIS.aCampo[lnFila, 06] = llRequerido
        THIS.aCampo[lnFila, 07] = lvValor
        THIS.aCampo[lnFila, 08] = llGetter
        THIS.aCampo[lnFila, 09] = llSetter
        THIS.aCampo[lnFila, 10] = tcEtiqueta
        THIS.aCampo[lnFila, 11] = lcUltimoError


        * [n, 01] = nombre del campo (ej.: 'codigo', 'nombre', 'vigente'),
        * [n, 02] = tipo de dato el campo (ej.: 'C', 'D', 'L', 'N', 'T'),
        * [n, 03] = ancho del campo (ej.: 4, 30, 1),
        * [n, 04] = decimales (posiciones decimales en caso de tipo 'N'),
        * [n, 05] = sin signo (unsigned) (en caso de tipo 'N'),
        * [n, 06] = requerido (en caso de tipo 'N' debe ser > 0;
        *          en caso de tipo 'C' no puede quedar en blanco),
        * [n, 07] = valor del campo,
        * [n, 08] = getter (ej.: .T. para habilitar el getter),
        * [n, 09] = setter (ej.: .F. para deshabilitar el setter).
        * [n, 10] = etiqueta (ej.: 'Código: ', 'Nombre: ', 'Vigente: '),
        * [n, 11] = ultimo error (ej.: 'Debe ser mayor que cero').

    ENDFUNC

    PROTECTED FUNCTION establecer_campo_requerido
        LPARAMETERS tcCampo, tlValor

        * inicio { validaciones de parámetros }
        IF PARAMETERS() < 2 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' ;
                OR VARTYPE(tlValor) != 'L' ;
                OR EMPTY(tcCampo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL lnPos
        lnPos = ASCAN(THIS.aCampo, tcCampo, -1, -1, 1, 9)

        IF lnPos <= 0 THEN
            RETURN .F.
        ENDIF

        THIS.aCampo[lnPos, 06] = tlValor    && requerido.
    ENDFUNC

    PROTECTED FUNCTION establecer_campo_getter
        LPARAMETERS tcCampo, tlValor

        * inicio { validaciones de parámetros }
        IF PARAMETERS() < 2 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' ;
                OR VARTYPE(tlValor) != 'L' ;
                OR EMPTY(tcCampo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL lnPos
        lnPos = ASCAN(THIS.aCampo, tcCampo, -1, -1, 1, 9)

        IF lnPos <= 0 THEN
            RETURN .F.
        ENDIF

        THIS.aCampo[lnPos, 08] = tlValor    && getter.
    ENDFUNC

    PROTECTED FUNCTION establecer_campo_setter
        LPARAMETERS tcCampo, tlValor

        * inicio { validaciones de parámetros }
        IF PARAMETERS() < 2 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' ;
                OR VARTYPE(tlValor) != 'L' ;
                OR EMPTY(tcCampo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL lnPos
        lnPos = ASCAN(THIS.aCampo, tcCampo, -1, -1, 1, 9)

        IF lnPos <= 0 THEN
            RETURN .F.
        ENDIF

        THIS.aCampo[lnPos, 09] = tlValor    && setter.
    ENDFUNC

    PROTECTED FUNCTION establecer_campo_sin_signo
        LPARAMETERS tcCampo, tlValor

        * inicio { validaciones de parámetros }
        IF PARAMETERS() < 2 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCampo) != 'C' ;
                OR VARTYPE(tlValor) != 'L' ;
                OR EMPTY(tcCampo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL lnPos
        lnPos = ASCAN(THIS.aCampo, tcCampo, -1, -1, 1, 9)

        IF lnPos == 0 THEN
            RETURN .F.
        ENDIF

        THIS.aCampo[lnPos, 05] = tlValor    && sin signo (unsigned).
    ENDFUNC

    PROTECTED FUNCTION existe_campo
        LPARAMETERS tcCampo

        * inicio { validaciones }
        IF VARTYPE(tcCampo) != 'C' OR EMPTY(tcCampo) THEN
            RETURN .T.
        ENDIF

        IF VARTYPE(THIS.aCampo) == 'L' THEN
            RETURN .F.
        ENDIF
        * fin { validaciones }

        LOCAL lnPos
        lnPos = ASCAN(THIS.aCampo, tcCampo, -1, -1, 1, 9)

        IF lnPos == 0 THEN
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE
