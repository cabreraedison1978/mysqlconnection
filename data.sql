use ganga;

SET FOREIGN_KEY_CHECKS = 0;

-- 1. Tabla tipo[cite: 1]
DROP TABLE IF EXISTS tipo;
CREATE TABLE tipo (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    estado VARCHAR(3) NOT NULL DEFAULT 'ACT',
    descripcion VARCHAR(50) NOT NULL,
    tipo INT NULL,
    padre INT NULL,
    data1 VARCHAR(50) NULL,
    data2 VARCHAR(50) NULL,
    data3 VARCHAR(50) NULL,
    CONSTRAINT fk_tipo_tipo FOREIGN KEY (tipo) REFERENCES tipo(id),
    CONSTRAINT fk_tipo_padre FOREIGN KEY (padre) REFERENCES tipo(id)
);

-- = = = = = = = = = = = = = = = = = = = PARAMETROS DE PERSONA = = = = = = = = = = = = = = = = = = = 
select @id := ifnull(max(id), 0) + 1
from tipo;

insert into tipo(descripcion) values ('Paises'), ('Persona'), ('Direccion');

DROP TABLE IF EXISTS paramPersona;
create table paramPersona(
 pais INT NOT NULL,
 persona INT NOT NULL,
 direccion INT NOT NULL,
    CONSTRAINT fk_paramPersona_pais FOREIGN KEY (pais) REFERENCES tipo(id),
    CONSTRAINT fk_paramPersona_persona FOREIGN KEY (persona) REFERENCES tipo(id),
    CONSTRAINT fk_paramPersona_direccion FOREIGN KEY (direccion) REFERENCES tipo(id)
);
insert into paramPersona values (@id, @id + 1, @id + 2);

-- = = = = = = = = = = = = = = = = = = = PARAMETROS DE ARTICULO = = = = = = = = = = = = = = = = = = = 
select @id := ifnull(max(id), 0) + 1
from tipo;

insert into tipo(descripcion) values ('Artículo'), ('Unidad'), ('Marca');

DROP TABLE IF EXISTS paramArticulo;
create table paramArticulo(
    articulo INT NOT NULL,
 unidad INT NOT NULL,
 marca INT NOT NULL,
    CONSTRAINT fk_paramArticulo_articulo FOREIGN KEY (articulo) REFERENCES tipo(id),
    CONSTRAINT fk_paramArticulo_unidad FOREIGN KEY (unidad) REFERENCES tipo(id),
    CONSTRAINT fk_paramArticulo_marca FOREIGN KEY (marca) REFERENCES tipo(id)
);
insert into paramArticulo values (@id, @id + 1, @id + 2);

-- = = = = = = = = = = = = = = = = = = PARAMETROS DE DOCUMENTOS = = = = = = = = = = = = = = = = = =
select @id := ifnull(max(id), 0) + 1
from tipo;

insert into tipo(descripcion) values ('Módulos'), ('Documentos'), ('Canales'), ('Región')
, ('División'), ('Sucursal'), ('Bodega'), ('Log');

DROP TABLE IF EXISTS paramDocum;
create table paramDocum(
    modulo INT NOT NULL,
 documento INT NOT NULL,
 canal INT NOT NULL,
 region INT NOT NULL,
 division INT NOT NULL,
 sucursal INT NOT NULL,
 bodega INT NOT NULL,
 log INT NOT NULL,
    CONSTRAINT fk_paramDocum_modulo FOREIGN KEY (modulo) REFERENCES tipo(id),
    CONSTRAINT fk_paramDocum_documento FOREIGN KEY (documento) REFERENCES tipo(id),
    CONSTRAINT fk_paramDocum_canal FOREIGN KEY (canal) REFERENCES tipo(id),
    CONSTRAINT fk_paramDocum_region FOREIGN KEY (region) REFERENCES tipo(id),
    CONSTRAINT fk_paramDocum_division FOREIGN KEY (division) REFERENCES tipo(id),
    CONSTRAINT fk_paramDocum_sucursal FOREIGN KEY (sucursal) REFERENCES tipo(id),
    CONSTRAINT fk_paramDocum_bodega FOREIGN KEY (bodega) REFERENCES tipo(id),
    CONSTRAINT fk_paramDocum_log FOREIGN KEY (log) REFERENCES tipo(id)
);
insert into paramDocum values (@id, @id + 1, @id + 2, @id + 3, @id + 4, @id + 5, @id + 6, @id + 7);

-- = = = = = = = = = = = = = = = = = = = DE paramPersona = = = = = = = = = = = = = = = = = = =
select @pais := pais, @tipo := persona, @direccion := direccion
from paramPersona;

insert into tipo (descripcion, padre) values ('ECUADOR', @pais), ('CHINA POPULAR', @pais)
, ('COLOMBIA', @pais), ('INDIA', @pais), ('JAPON', @pais), ('Cédula', @tipo), ('RUC', @tipo)
, ('Pasaporte', @tipo), ('Consumidor final', @tipo), ('Oficina', @direccion), ('Casa', @direccion)
, ('Bodega', @direccion);

-- = = = = = = = = = = = = = = = = = = = DE paramArticulo = = = = = = = = = = = = = = = = = = =
select @articulo := articulo, @unidad := unidad, @marca := marca
from paramArticulo;

insert into tipo (descripcion, padre) values ('Producto Terminado', @articulo)
, ('Materia Prima', @articulo), ('Envases', @articulo), ('Etiquetas', @articulo)
, ('Semi elaborados', @articulo), ('Proveeduria', @articulo), ('Estado ticket', @articulo)
, ('Detalle diario', @articulo), ('Detalle CXC', @articulo), ('Detalle CXP', @articulo)
, ('Detalle banco', @articulo), ('Unidad', @unidad), ('Kilo', @unidad), ('Litro', @unidad);

insert into tipo(descripcion, padre, data1) values ('ADINA', @marca, '192')
, ('ALPHACELL', @marca, '107'), ('Apple', @marca, '557'), ('ARTESANO', @marca, '176')
, ('ASUS', @marca, '204'), ('AZAR', @marca, '98'), ('BAJAJ ', @marca, '172')
, ('BAZZUKA', @marca, '130'), ('BLACK&DECKER', @marca, '30'), ('BMX', @marca, '128')
, ('BONHOEFFER', @marca, '201'), ('BROTHER', @marca, '206'), ('BULTACO ', @marca, '169')
, ('CANON', @marca, '48'), ('CERAMICA ANDINA', @marca, '05'), ('CHAIDE', @marca, '55')
, ('CLARO', @marca, '69'), ('CONSTRUFERIAS S.A.', @marca, '160'), ('CUMMINS', @marca, '186')
, ('DAEWOO', @marca, '46'), ('DAYTONA', @marca, '123'),  ('DELL', @marca, '205')
, ('DIRECTV', @marca, '125'), ('DUOCELL', @marca, '167'), ('DURATEX', @marca, '81')
, ('DUREX', @marca, '197'), ('DYNAMIC', @marca, '14'), ('EASYCOM', @marca, '75')
, ('ECASA', @marca, '09'), ('ECOGAS', @marca, '148'), ('ELECTROLUX', @marca, '18')
, ('ELECTROMOTO', @marca, '170'), ('EMBARGO', @marca, '93'), ('EPSON', @marca, '74')
, ('E-SANCHEZ', @marca, '16'), ('ESSEN', @marca, '180'), ('Factory Bike - YCF', @marca, '145')
, ('FERREZACA', @marca, '191'), ('FORZA', @marca, '200'), ('G&E', @marca, '31')
, ('GENERAC', @marca, '113'), ('GENERICA', @marca, '181'), ('GLOBAL', @marca, '102')
, ('GOOGLE', @marca, '129'), ('GRUNTIK', @marca, '13'), ('HACEB', @marca, '58')
, ('HANDICAN', @marca, '39'), ('HAOJUE', @marca, '185'), ('HIDEA', @marca, '193')
, ('HISENSE', @marca, '173'), ('HONDA', @marca, '116'), ('HONEYWELL', @marca, '126')
, ('HONOR', @marca, '178'), ('HOTPOINT', @marca, '07'), ('HP', @marca, '202'), ('HUSSAR', @marca, '28')
, ('HYUNDAI', @marca, '78'), ('ICESA/GOLDSTAR AUDIO-VIDEO', @marca, '03'), ('IMACO', @marca, '105')
, ('INDUFRIAL', @marca, '65'), ('INDUGLOBAL', @marca, '109'), ('INDURAMA', @marca, '04')
, ('INFINITY', @marca, '151'), ('INFINIX', @marca, '174'), ('INNOVATECORP S.A', @marca, '114')
, ('IT TECH GROUP', @marca, '153'), ('JBL', @marca, '194'), ('JENNY BRAVO LOOR', @marca, '124')
, ('JIEDA', @marca, '104'), ('JINCHENG', @marca, '50'), ('JVC', @marca, '54')
, ('Kärcher', @marca, '118'), ('KEC CORP.', @marca, '61'), ('KENWOOD', @marca, '51')
, ('KIKO TOYS', @marca, '26'), ('KING', @marca, '84'), ('KitchenAid', @marca, '43')
, ('KLIPXTREME', @marca, '198'), ('KODAK', @marca, '27'), ('KP ELECTRONICS', @marca, '121')
, ('LENOVO', @marca, '203'), ('LEXMARK', @marca, '71'), ('LG', @marca, '33'), ('LONCIN', @marca, '208')
, ('LONGJIA', @marca, '29'), ('LONGTIME', @marca, '195'), ('LOUD', @marca, '150')
, ('MABE', @marca, '01'), ('MAXELL', @marca, '56'), ('MIDEA', @marca, '137'), ('MIMET', @marca, '57')
, ('MISC. EXTRANJEROS', @marca, '40'), ('MISC. NACIONALES', @marca, '20'), ('MOTOR 1', @marca, '112')
, ('MOTOROLA', @marca, '163'), ('MOVISTAR', @marca, '103'), ('MOXAL', @marca, '171')
, ('MP3', @marca, '136'), ('MTAUDIO', @marca, '86'), ('MUEBLERIA PALITO', @marca, '122')
, ('MXQ', @marca, '141'), ('MYTEK', @marca, '143'), ('NATIONAL', @marca, '79')
, ('NOKIA', @marca, '158'), ('NUKLEO', @marca, '199'), ('NUMARK', @marca, '132')
, ('OLYMPUS', @marca, '119'), ('OMNITEK', @marca, '24'), ('OPPO', @marca, '162')
, ('OPTICA LOS ANDES', @marca, '190'), ('OSTER', @marca, '32'), ('PACKTRON', @marca, '159')
, ('PANDA', @marca, '94'), ('PAOLO', @marca, '207'), ('PAR INTERCONTINENTAL', @marca, '101')
, ('PARAISO', @marca, '117'), ('PATON', @marca, '11'), ('PEGASO', @marca, '155')
, ('PEKEY', @marca, '66'), ('PELOPINCHO "LUNIK S.A"', @marca, '96'), ('PERCESA', @marca, '142')
, ('PHL', @marca, '23'), ('PIONEER', @marca, '19'), ('PIPSA', @marca, '08'), ('PIXELA', @marca, '111')
, ('PLASTICOS INDUSTRIALES PICA', @marca, '120'), ('PREMIER', @marca, '59'), ('PRIMAX', @marca, '42')
, ('PRIMUS', @marca, '209'), ('PROTECCION', @marca, '166'), ('PYREX', @marca, '10')
, ('RANGER', @marca, '156'), ('REALME', @marca, '168'), ('RIVIERA', @marca, '87')
, ('RNB', @marca, '97'), ('ROAD RUNNER', @marca, '82'), ('ROYAL', @marca, '47')
, ('SALVACERO', @marca, '184'), ('SAMSUNG', @marca, '34'), ('SANYO', @marca, '38')
, ('SHARP', @marca, '83'), ('SHINERAY', @marca, '157'), ('SHM', @marca, '188')
, ('SIGMA', @marca, '106'), ('SINGER', @marca, '85'), ('SKULLCANDY', @marca, '135')
, ('SMART HOME', @marca, '196'), ('SMC', @marca, '108'), ('SMG', @marca, '152')
, ('SONY', @marca, '22'), ('STARLINK', @marca, '179'), ('STONE&EQUIPMENT', @marca, '165')
, ('SUMBEAM', @marca, '37'), ('SUMITOMO', @marca, '73'), ('SUPER HAIWA', @marca, '77')
, ('SUPERIOR', @marca, '64'), ('SUZUKI', @marca, '76'), ('TCL', @marca, '175')
, ('TECNO', @marca, '164'), ('TEKOCSA', @marca, '70'), ('THOMART', @marca, '15')
, ('TOHATSU', @marca, '177'), ('TOKAY', @marca, '95'), ('TOSHIBA', @marca, '88')
, ('TOSHIBA', @marca, '35'), ('TUKO', @marca, '127'), ('TV CABLE', @marca, '134')
, ('ULTRFAN', @marca, '115'), ('UMCO', @marca, '17'), ('VANTEC', @marca, '691')
, ('VIRTCORPORACION', @marca, '133'), ('VISION', @marca, '67'), ('VITEL MOBILE', @marca, '189')
, ('VIVICAM', @marca, '110'), ('VMAX', @marca, '183'), ('WATSON', @marca, '147')
, ('Wellspring', @marca, '144'), ('WESTINGHOUSE', @marca, '138'), ('WHIRLPOOL', @marca, '52')
, ('WINDMERE', @marca, '60'), ('WOOD`S', @marca, '80'), ('XIAOMI', @marca, '154')
, ('YORK', @marca, '62'), ('ZTE  FACTORYTECH', @marca, '139');

-- = = = = = = = = = = = = = = = = = = PARAMETROS DE DOCUMENTOS = = = = = = = = = = = = = = = = = =
select @modulo := modulo, @documento := documento, @canal := canal, @region := region
, @division := division, @sucursal := sucursal, @bodega := bodega, @log := log
from paramDocum;

insert into tipo(descripcion, padre, data1) values 
('Inventarios', @modulo, 'inventario/inventario.html'), ('Ventas', @modulo, 'ventas/ventas.html')
, ('CXC', @modulo, 'cxc/cxc.html'), ('Compras', @modulo, 'compras/compras.html')
, ('CXP', @modulo, 'cxp/cxp.html'), ('Bancos', @modulo, 'bancos/bancos.html')
, ('Contabilidad', @modulo, 'contabilidad/contabilidad.html'), ('RRHH', @modulo, 'rrhh/rrhh.html')
, ('Activos Fijos', @modulo, 'activosfijos/activosfijos.html'), ('SAC', @modulo, 'sac/sac.html')
, ('Logística', @modulo, 'logistica/logistica.html')
, ('Proveeduria', @modulo, 'proveeduria/proveeduria.html');

select @id := ifnull(max(id), 0) + 1
from tipo;

insert into tipo(descripcion, padre, data1, data2) values ('Factura', @documento, '1', '01')
, ('Nota de crédito', @documento, '0', '04'), ('Nota de débito', @documento, '1', '05')
, ('Ingreso de bodega', @documento, '1', NULL), ('Egreso de bodega', @documento, '0', NULL)
, ('Comprobante de retención', @documento, '0', '07'), ('Liquidación de compras', @documento, '1', '03')
, ('Guia de remisión', @documento, NULL, '06'), ('Pedido / Cotización', @documento, NULL, NULL)
, ('Couta / letra de factura', @documento, '1', NULL), ('Efectivo', @documento, '0', NULL)
, ('Cheque', @documento, '0', NULL), ('Transferencia (bancos)', @documento, '0', NULL)
, ('Deposito', @documento, '0', NULL), ('Transferencia (inventario)', @documento, NULL, NULL)
, ('Transferencia interna', @documento, NULL, NULL), ('Orden de Producción', @documento, NULL, NULL)
, ('Diario', @documento, NULL, NULL), ('Devolución', @documento, '0', NULL);

DROP TABLE IF EXISTS paramTpDocum;
create table paramTpDocum(
    factura INT NOT NULL,
	nc INT NOT NULL,
	nd INT NOT NULL,
	ib INT NOT NULL,
	eb INT NOT NULL,
    CONSTRAINT fk_paramTpDocum_factura FOREIGN KEY (factura) REFERENCES tipo(id),
    CONSTRAINT fk_paramTpDocum_nc FOREIGN KEY (nc) REFERENCES tipo(id),
    CONSTRAINT fk_paramTpDocum_nd FOREIGN KEY (nd) REFERENCES tipo(id),
    CONSTRAINT fk_paramTpDocum_ib FOREIGN KEY (ib) REFERENCES tipo(id),
    CONSTRAINT fk_paramTpDocum_eb FOREIGN KEY (eb) REFERENCES tipo(id)
);
insert into paramTpDocum values (@id, @id + 1, @id + 2, @id + 3, @id + 4);

select @factura := factura, @nc := nc, @nd := nd, @ib := ib, @eb := eb
from paramTpDocum;

insert into tipo (descripcion, padre) values ('001-916', @canal),  ('001-920', @canal)
,  ('027-901', @canal),  ('029-901', @canal),  ('032-901', @canal),  ('046-901', @canal)
,  ('070-901', @canal),  ('080-901', @canal),  ('082-901', @canal),  ('084-901', @canal)
,  ('086-901', @canal),  ('087-901', @canal),  ('092-901', @canal),  ('096-901', @canal)
,  ('099-901', @canal),  ('099-902', @canal),  ('103-901', @canal),  ('111-901', @canal)
,  ('113-901', @canal),  ('122-901', @canal),  ('123-901', @canal),  ('125-901', @canal)
,  ('127-901', @canal),  ('128-901', @canal),  ('128-902', @canal),  ('129-901', @canal)
,  ('133-901', @canal),  ('138-901', @canal),  ('139-901', @canal),  ('140-901', @canal)
,  ('141-901', @canal),  ('142-901', @canal),  ('144-901', @canal),  ('145-901', @canal)
,  ('148-901', @canal),  ('150-901', @canal),  ('151-901', @canal),  ('157-901', @canal)
,  ('159-901', @canal),  ('160-901', @canal),  ('183-901', @canal),  ('193-902', @canal)
,  ('194-901', @canal),  ('204-901', @canal),  ('209-901', @canal),  ('216-901', @canal)
,  ('220-901', @canal),  ('229-901', @canal),  ('233-901', @canal),  ('233-902', @canal)
,  ('234-901', @canal),  ('234-902', @canal),  ('235-901', @canal),  ('240-901', @canal)
,  ('243-901', @canal),  ('244-901', @canal),  ('246-901', @canal),  ('247-901', @canal)
,  ('248-901', @canal),  ('252-901', @canal),  ('254-901', @canal),  ('257-901', @canal)
,  ('262-901', @canal),  ('262-902', @canal),  ('278-901', @canal),  ('280-901', @canal)
,  ('280-902', @canal),  ('283-902', @canal),  ('285-901', @canal),  ('286-901', @canal)
,  ('287-901', @canal),  ('288-901', @canal),  ('289-901', @canal),  ('309-901', @canal)
,  ('309-902', @canal),  ('311-901', @canal),  ('313-901', @canal),  ('317-901', @canal)
,  ('320-901', @canal),  ('321-901', @canal),  ('321-902', @canal),  ('321-903', @canal)
,  ('323-901', @canal),  ('324-901', @canal),  ('326-901', @canal),  ('327-901', @canal)
,  ('328-901', @canal),  ('330-901', @canal),  ('332-901', @canal),  ('337-901', @canal)
,  ('338-901', @canal),  ('342-901', @canal),  ('343-901', @canal),  ('346-901', @canal)
,  ('348-901', @canal),  ('349-901', @canal),  ('350-901', @canal),  ('351-901', @canal)
,  ('353-901', @canal),  ('354-901', @canal),  ('357-901', @canal),  ('359-901', @canal)
,  ('361-901', @canal),  ('362-901', @canal),  ('367-901', @canal),  ('368-901', @canal);

insert into tipo (descripcion, padre, data1) values ('Costa', @region, '01'),  ('Sierra', @region, '02');

insert into tipo (descripcion, padre) values ('Ganga', @division), ('GMotos', @division)
, ('Taller', @division), ('Servicios', @division);

insert into tipo (estado, descripcion, padre, data1, data2) values 
('ACT', 'BODEGA REGIONAL GYE', @sucursal, '000', '01'), ('ACT', 'MATRIZ', @sucursal, '001', '01')
, ('ACT', 'CREADA POR ELENA FU', @sucursal, '002', '01')
, ('ACT', 'QUITO PRINCIPAL', @sucursal, '003', '02'), ('ACT', 'QUITO BODEGA', @sucursal, '004', '02')
, ('ACT', 'QUITO SUR', @sucursal, '005', '02'), ('ACT', 'AMBATO', @sucursal, '006', '02')
, ('ACT', 'IBARRA', @sucursal, '007', '02'), ('ACT', 'TULCAN', @sucursal, '008', '02')
, ('ACT', 'RECREO 1', @sucursal, '009', '02'), ('ACT', 'ALBORADA ', @sucursal, '011', '01')
, ('ACT', 'MILAGRO 1', @sucursal, '012', '01'), ('ACT', 'BABAHOYO ', @sucursal, '013', '01')
, ('ACT', 'VENTANAS', @sucursal, '014', '01'), ('ACT', 'POLICENTRO 2', @sucursal, '015', '01')
, ('ACT', 'PORTETE', @sucursal, '016', '01'), ('ACT', 'PORTOVIEJO', @sucursal, '017', '01')
, ('ACT', 'MANTA', @sucursal, '018', '01'), ('ACT', 'QUEVEDO', @sucursal, '019', '01')
, ('ACT', 'BOYACA', @sucursal, '020', '01'), ('ACT', 'QUIVENZ', @sucursal, '021', '02')
, ('ACT', 'DAULE', @sucursal, '022', '01'), ('ACT', 'EMPALME', @sucursal, '023', '01')
, ('ACT', 'AGUIRRE', @sucursal, '024', '01'), ('ACT', 'TARQUI', @sucursal, '025', '01')
, ('ACT', 'CHONE', @sucursal, '026', '01'), ('ACT', 'TRONCAL', @sucursal, '027', '01')
, ('ACT', 'PROMOCENTRO', @sucursal, '028', '01'), ('ACT', 'CALIFORNIA', @sucursal, '029', '01')
, ('ACT', 'RIOBAMBA', @sucursal, '030', '02'), ('ACT', 'QCENTRO', @sucursal, '031', '02')
, ('ACT', 'SANGOLQUI 1', @sucursal, '032', '02'), ('ACT', 'LAPRENSA', @sucursal, '033', '02')
, ('ACT', 'STO. DOMINGO', @sucursal, '034', '02'), ('ACT', 'LATACUN', @sucursal, '035', '02')
, ('ACT', 'CARCELEN', @sucursal, '036', '02'), ('ACT', 'ATUNTAQUI', @sucursal, '037', '02')
, ('ACT', 'TULCAN 2', @sucursal, '038', '02'), ('ACT', 'SALCEDO', @sucursal, '039', '02')
, ('ACT', 'LAMARINO', @sucursal, '040', '02'), ('ACT', 'OTAVALO', @sucursal, '041', '02')
, ('ACT', 'MACHACHI', @sucursal, '042', '02'), ('ACT', 'GMORENO', @sucursal, '043', '02')
, ('ACT', 'ESMERALDAS 1', @sucursal, '044', '02'), ('ACT', 'CAYAMBE 1', @sucursal, '045', '02')
, ('ACT', 'QSTADOM2', @sucursal, '046', '02'), ('ACT', 'QCOMIS', @sucursal, '047', '02')
, ('ACT', 'QLAGO', @sucursal, '048', '02'), ('ACT', 'GUANGALA', @sucursal, '049', '01')
, ('ACT', 'CUENCA', @sucursal, '050', '01'), ('ACT', 'PLAYAS', @sucursal, '051', '01')
, ('ACT', 'MACHALA', @sucursal, '052', '01'), ('ACT', '9 DE OCTUBRE 2', @sucursal, '053', '01')
, ('ACT', 'BASTION  POPULAR ', @sucursal, '054', '01')
, ('ACT', 'DES. VENTAJAS', @sucursal, '055', '01'), ('ACT', 'VENEZUELA 2', @sucursal, '056', '02')
, ('ACT', 'MICHELENA', @sucursal, '057', '02'), ('ACT', '9 DE OCTUBRE', @sucursal, '058', '01')
, ('ACT', 'ALBORADA 2', @sucursal, '059', '01'), ('ACT', 'QUITO CARPA', @sucursal, '060', '02')
, ('ACT', 'COCA', @sucursal, '061', '02'), ('ACT', 'GUARANDA', @sucursal, '062', '02')
, ('ACT', 'PORTOVIEJO 2', @sucursal, '063', '01'), ('ACT', 'ALBORADA 3', @sucursal, '064', '01')
, ('ACT', 'EL CARMEN', @sucursal, '065', '02'), ('ACT', '9 DE OCTUBRE 3', @sucursal, '066', '01')
, ('ACT', 'QUININDE', @sucursal, '067', '02'), ('ACT', 'LA TRONCAL 2', @sucursal, '068', '01')
, ('ACT', 'LA LIBERTAD 2', @sucursal, '069', '01'), ('ACT', 'BODEGA ELITE', @sucursal, '070', '01')
, ('ACT', 'FLORIDA NORTE', @sucursal, '071', '01'), ('ACT', 'ESMERALDAS 2', @sucursal, '072', '02')
, ('ACT', 'BODEGA ELITE (QUITO)', @sucursal, '073', '02')
, ('ACT', 'SANGOLQUI 2', @sucursal, '074', '02')
, ('ACT', 'BODEGA DANADOS QUITO', @sucursal, '075', '02'), ('ACT', 'AMBATO 2', @sucursal, '076', '02')
, ('ACT', 'POLICENTRO', @sucursal, '077', '01'), ('ACT', 'MEGATIENDA', @sucursal, '078', '02')
, ('ACT', 'NACIONES UNIDAS', @sucursal, '079', '02'), ('ACT', 'LA LIBERTAD 1', @sucursal, '080', '01')
, ('ACT', 'DURAN', @sucursal, '081', '01'), ('ACT', 'EL PUYO', @sucursal, '082', '02')
, ('ACT', 'COTOCOLLAO', @sucursal, '083', '02'), ('ACT', 'MILAGRO 2', @sucursal, '084', '01')
, ('ACT', 'PUERTEO QUITO', @sucursal, '085', '02'), ('ACT', 'MACAS', @sucursal, '086', '02')
, ('ACT', 'BUENA FE', @sucursal, '087', '01'), ('ACT', 'FERIA DE REMATES', @sucursal, '088', '01')
, ('ACT', 'DURAN 2', @sucursal, '089', '01'), ('ACT', 'FERIA DE DURAN', @sucursal, '090', '01')
, ('ACT', 'NARANJAL', @sucursal, '091', '01'), ('ACT', 'SANTA. ROSA', @sucursal, '092', '01')
, ('ACT', 'ATACAMES', @sucursal, '093', '02'), ('ACT', 'LA 29', @sucursal, '094', '01')
, ('ACT', 'GUAMANI', @sucursal, '095', '02'), ('ACT', 'CHILLOGALLO 1', @sucursal, '096', '02')
, ('ACT', 'SOLANDA', @sucursal, '097', '02'), ('ACT', 'COMITE DEL PUEBLO1', @sucursal, '098', '02')
, ('ACT', 'CARAPUNGO', @sucursal, '099', '02'), ('ACT', 'TENA', @sucursal, '100', '02')
, ('ACT', 'CHIMBACALLE', @sucursal, '101', '02'), ('ACT', 'PEDREGAL', @sucursal, '102', '01')
, ('ACT', 'LA DELICIA', @sucursal, '103', '02'), ('ACT', 'LA CONCORDIA', @sucursal, '104', '02')
, ('ACT', 'CUENCA 2', @sucursal, '105', '01'), ('ACT', 'PARAISO DE LA FLOR', @sucursal, '106', '01')
, ('ACT', 'MALL DEL SUR', @sucursal, '107', '01'), ('ACT', 'RIOCENTRO SUR', @sucursal, '108', '01')
, ('ACT', 'JIPIJAPA', @sucursal, '109', '01'), ('ACT', 'TUMBACO', @sucursal, '110', '02')
, ('ACT', 'FERIA DE REMATES (AMBATO)', @sucursal, '111', '02')
, ('ACT', 'ATUNTAQUI', @sucursal, '112', '02'), ('ACT', 'COTACACHI', @sucursal, '113', '02')
, ('ACT', 'PUERTEO TABACUNDO', @sucursal, '114', '02'), ('ACT', 'FERTISA', @sucursal, '115', '01')
, ('ACT', 'FERIA DE REMATES (IBARRA)', @sucursal, '116', '02')
, ('ACT', 'FERIA DE REMATES (LATACUNGA)', @sucursal, '117', '02')
, ('ACT', 'EL ANGEL', @sucursal, '118', '02'), ('ACT', 'SALCEDO 2', @sucursal, '119', '02')
, ('ACT', 'EL TREBOL', @sucursal, '120', '01'), ('ACT', 'PUERTEO SAN GABRIEL', @sucursal, '121', '02')
, ('ACT', 'SERVICIO AL CLIENTE GYE', @sucursal, '122', '01')
, ('ACT', 'SERVICIO AL CLIENTE UIO', @sucursal, '123', '02')
, ('ACT', 'SAN MIGUEL DE LOS BANCOS', @sucursal, '124', '02')
, ('ACT', 'NO VALE', @sucursal, '125', '02'), ('ACT', 'BAÑOS', @sucursal, '126', '02')
, ('ANU', 'PEDERNALES_NO VALE', @sucursal, '127', '01'), ('ACT', 'PALORA', @sucursal, '128', '02')
, ('ACT', 'SHUSHUFINDI', @sucursal, '129', '02'), ('ACT', 'ZAMORA', @sucursal, '130', '02')
, ('ANU', 'LOJA_NO VALE', @sucursal, '131', '02'), ('ACT', 'AMBATO 3', @sucursal, '132', '02')
, ('ACT', 'VINCES', @sucursal, '133', '01'), ('ACT', 'PASAJE', @sucursal, '134', '01')
, ('ACT', 'EL EMPALME 2', @sucursal, '135', '01'), ('ACT', '.', @sucursal, '136', '02')
, ('ACT', 'AZOGUES', @sucursal, '137', '01'), ('ACT', 'POMASQUI', @sucursal, '138', '02')
, ('ACT', '7 LAGOS', @sucursal, '139', '01'), ('ACT', 'FERIA EXPOPLAZA', @sucursal, '140', '01')
, ('ACT', 'SAC SERVITEC UIO', @sucursal, '141', '02')
, ('ACT', 'SAC SERVITEC GYE', @sucursal, '142', '01'), ('ACT', 'LOJA', @sucursal, '143', '01')
, ('ACT', 'PEDERNALES', @sucursal, '144', '02'), ('ACT', 'PUERTEO GUAJALO', @sucursal, '145', '02')
, ('ACT', 'PUERTEO CIUDADELA IBARRA', @sucursal, '146', '02')
, ('ACT', 'PUERTEO AJAVI', @sucursal, '147', '02')
, ('ACT', 'PUERTEO EL QUINCHE', @sucursal, '148', '02')
, ('ACT', 'FREELANCE QUITO', @sucursal, '149', '02')
, ('ACT', 'PUERTEO CONOCOTO', @sucursal, '150', '02'), ('ACT', 'FREELANCE GYE', @sucursal, '151', '01')
, ('ACT', 'FERIA CARCELEN', @sucursal, '152', '02'), ('ACT', 'IBARRA 2', @sucursal, '153', '02')
, ('ACT', 'SAMBORONDON', @sucursal, '154', '01'), ('ACT', 'UNO POR UNO', @sucursal, '155', '01')
, ('ACT', 'EL FORTIN', @sucursal, '156', '01'), ('ACT', 'PUERTEO CALDERON', @sucursal, '157', '02')
, ('ACT', 'POSTAL EXPRESS', @sucursal, '158', '01')
, ('ACT', 'FERIA DE SANTO DOMINGO', @sucursal, '159', '02'), ('ACT', 'CAÑAR', @sucursal, '160', '01')
, ('ACT', 'FERIA EL CARMEN', @sucursal, '161', '02'), ('ACT', 'BALZAR', @sucursal, '162', '01')
, ('ACT', 'DURAN 3', @sucursal, '163', '01'), ('ACT', 'LA MANA', @sucursal, '164', '02')
, ('ACT', 'LA 38', @sucursal, '165', '01'), ('ACT', 'PUERTEO PIMAMPIRO IBARRA', @sucursal, '166', '02')
, ('ACT', 'SAN ANTONIO DE PICHINCHA', @sucursal, '167', '02')
, ('ACT', 'TRINIPUERTO', @sucursal, '168', '01'), ('ACT', 'EL INCA', @sucursal, '169', '02')
, ('ACT', 'VILLAFLORA', @sucursal, '170', '02'), ('ACT', 'CARCELEN BAJO', @sucursal, '171', '02')
, ('ACT', 'FERIA DE OTAVALO', @sucursal, '172', '02')
, ('ACT', 'BODEGA SERVICIO TECNICO GYE', @sucursal, '173', '01')
, ('ACT', 'BODEGA SERVICIO TECNICO QUITO', @sucursal, '174', '02')
, ('ACT', 'REMATES DE LA GANGA', @sucursal, '175', '01')
, ('ACT', 'LOS ROSALES', @sucursal, '176', '01'), ('ACT', 'PIÑAS', @sucursal, '177', '01')
, ('ACT', 'BODEGA PINGUINO', @sucursal, '178', '01'), ('ACT', 'SALITRE', @sucursal, '179', '01')
, ('ACT', 'POSORJA', @sucursal, '180', '01'), ('ACT', 'EL TRIUNFO', @sucursal, '181', '01')
, ('ACT', 'GUASMO', @sucursal, '182', '01'), ('ACT', 'AEROPUERTO', @sucursal, '183', '02')
, ('ACT', 'EL CHACO', @sucursal, '184', '02'), ('ACT', 'JULIO ANDRADE', @sucursal, '185', '02')
, ('ACT', 'SANTA LUCIA', @sucursal, '186', '01'), ('ACT', 'PEDRO CARBO', @sucursal, '187', '01')
, ('ACT', 'RICAURTE', @sucursal, '188', '01'), ('ACT', 'SAN JUAN', @sucursal, '189', '01')
, ('ACT', 'VALENCIA', @sucursal, '190', '01'), ('ACT', 'ALAUSI', @sucursal, '191', '02')
, ('ACT', 'COLONIAL 2', @sucursal, '192', '02'), ('ACT', '9 DE OCTUBRE 4', @sucursal, '193', '01')
, ('ACT', 'LA FLORESTA', @sucursal, '194', '02'), ('ACT', 'BUCAY', @sucursal, '195', '01')
, ('ACT', 'PATRICIA PILAR', @sucursal, '196', '02'), ('ACT', 'HUAQUILLAS', @sucursal, '197', '01')
, ('ACT', 'EL GUABO', @sucursal, '198', '01'), ('ACT', 'CAYAMBE 2', @sucursal, '199', '02')
, ('ACT', 'LA UNION', @sucursal, '200', '02'), ('ACT', 'MADRID - ESPAÑA', @sucursal, '201', '01')
, ('ACT', 'BARCELONA - ESPAÑA', @sucursal, '202', '01')
, ('ACT', 'MADRID_2 ESPAÑA', @sucursal, '203', '01'), ('ACT', 'BARCELONA 2', @sucursal, '204', '01')
, ('ACT', 'ITALIA', @sucursal, '205', '01'), ('ACT', 'MURCIA - ESPAÑA', @sucursal, '206', '01')
, ('ACT', 'BODEGA DE SEGUNDA VIRTUAL ', @sucursal, '207', '01')
, ('ANU', 'FLAVIO ALFARO (ELIMINADA)', @sucursal, '208', '01')
, ('ACT', 'FLAVIO ALFARO', @sucursal, '209', '02')
, ('ACT', 'JOYA DE LOS SACHAS', @sucursal, '210', '02'), ('ACT', 'BODEGA 3', @sucursal, '211', '01')
, ('ACT', 'GALAPAGOS', @sucursal, '212', '01'), ('ACT', 'PALENQUE', @sucursal, '213', '01')
, ('ACT', 'CALUMA', @sucursal, '214', '01'), ('ACT', 'SAN CARLOS', @sucursal, '215', '01')
, ('ACT', 'RIOBAMBA 2', @sucursal, '216', '02'), ('ACT', 'RECREO 2', @sucursal, '217', '02')
, ('ACT', 'SANGOLQUI 3', @sucursal, '218', '02')
, ('ACT', 'BODEGA PUERTA A PUERTA', @sucursal, '219', '01')
, ('ACT', 'BODEGA CENTRO', @sucursal, '220', '01'), ('ACT', 'SANTO DOMINGO 3', @sucursal, '221', '02')
, ('ACT', 'ESMERALDAS 3', @sucursal, '222', '02'), ('ACT', 'SAN RAFAEL', @sucursal, '223', '02')
, ('ACT', 'SAN LORENZO', @sucursal, '224', '02'), ('ACT', 'MEGA 2', @sucursal, '225', '02')
, ('ACT', 'GUAMANI 2', @sucursal, '226', '02'), ('ACT', 'CALDERON 2', @sucursal, '227', '02')
, ('ACT', 'NARANJITO', @sucursal, '228', '01')
, ('ACT', 'COOP. POLICIA NACIONAL', @sucursal, '229', '02'), ('ACT', 'PUYO_2', @sucursal, '230', '02')
, ('ACT', 'PIFO', @sucursal, '231', '02'), ('ACT', 'AMAGUAÑA', @sucursal, '232', '02')
, ('ACT', 'QUICENTRO SUR', @sucursal, '233', '02'), ('ACT', 'TENA 2', @sucursal, '234', '02')
, ('ACT', 'GUAYLLABAMBA', @sucursal, '235', '02'), ('ACT', 'RIOCENTRO NORTE', @sucursal, '236', '01')
, ('ACT', '9 DE OCTUBRE 5', @sucursal, '237', '01'), ('ACT', 'SIMON BOLIVAR', @sucursal, '238', '01')
, ('ACT', 'BALAO', @sucursal, '239', '01'), ('ACT', 'VILLA CLUB', @sucursal, '240', '01')
, ('ACT', 'YAGUACHI', @sucursal, '241', '01'), ('ACT', 'MEGA 3', @sucursal, '242', '02')
, ('ACT', 'CHONE 2', @sucursal, '243', '02'), ('ANU', 'NN', @sucursal, '244', '01')
, ('ACT', 'PASCUALES', @sucursal, '245', '01'), ('ACT', 'SAN VICENTE', @sucursal, '246', '02')
, ('ACT', 'JAIME ROLDOS', @sucursal, '247', '02'), ('ACT', 'QUEVEDO 2', @sucursal, '248', '01')
, ('ACT', 'MACHALA 2', @sucursal, '249', '01'), ('ACT', 'MONTALVO', @sucursal, '250', '01')
, ('ACT', 'ZARUMA', @sucursal, '251', '01'), ('ACT', 'COLIMES', @sucursal, '252', '01')
, ('ACT', 'LATACUNGA 3', @sucursal, '253', '02'), ('ACT', 'MACHALA 3', @sucursal, '254', '01')
, ('ACT', 'PORTOVIEJO 3', @sucursal, '255', '01'), ('ACT', 'MOCACHE', @sucursal, '256', '01')
, ('ACT', 'CITY MALL', @sucursal, '257', '01'), ('ACT', 'LOMAS DE SARGENTILLO', @sucursal, '258', '01')
, ('ACT', 'SAN MARINO', @sucursal, '259', '01'), ('ACT', 'RIOBAMBA 3', @sucursal, '260', '02')
, ('ACT', 'RECREO GYE', @sucursal, '261', '01'), ('ACT', 'PORTETE Y LA 30', @sucursal, '262', '01')
, ('ACT', 'CHILLOGALLO 2', @sucursal, '263', '02'), ('ACT', 'LA 23 Y LA Q', @sucursal, '264', '01')
, ('ACT', 'CALCETA', @sucursal, '265', '01'), ('ACT', 'PICHINCHA', @sucursal, '266', '01')
, ('ACT', 'AMBATO- PAP1', @sucursal, '267', '02'), ('ACT', 'BABAHOYO 2', @sucursal, '268', '01')
, ('ACT', 'QUINSALOMA', @sucursal, '269', '01'), ('ACT', 'NOBOL', @sucursal, '270', '01')
, ('ACT', 'ECHEANDIA', @sucursal, '271', '01'), ('ACT', 'LA 25 Y LA B', @sucursal, '272', '01')
, ('ACT', 'AMBATO- PAP2', @sucursal, '273', '02'), ('ACT', 'AMBATO- PAP3', @sucursal, '274', '02')
, ('ACT', 'COTOCOLLAO 2', @sucursal, '275', '02'), ('ACT', 'PELILEO', @sucursal, '276', '02')
, ('ACT', 'BALSAS', @sucursal, '277', '01'), ('ACT', 'SANTO DOMINGO- PAP1', @sucursal, '278', '02')
, ('ACT', 'SANTO DOMINGO- PAP2', @sucursal, '279', '02')
, ('ACT', 'SANTO DOMINGO- PAP3', @sucursal, '280', '02')
, ('ACT', 'VALLE DE LOS CHILLOS- PAP1', @sucursal, '281', '02')
, ('ACT', 'VALLE DE LOS CHILLOS- PAP2', @sucursal, '282', '02')
, ('ACT', 'VALLE DE LOS CHILLOS- PAP3', @sucursal, '283', '02')
, ('ACT', 'BABA', @sucursal, '284', '01'), ('ACT', 'NUEVA AURORA', @sucursal, '285', '02')
, ('ACT', 'PLAYAS 2', @sucursal, '286', '01')
, ('ACT', 'BODEGA LOGISTICA COSTA', @sucursal, '287', '02')
, ('ACT', 'MACHALA PP1', @sucursal, '288', '01'), ('ACT', 'MACHALA PP2', @sucursal, '289', '01')
, ('ACT', 'MACHALA PP3', @sucursal, '290', '01'), ('ACT', 'JUAN MONTALVO GYE', @sucursal, '291', '01')
, ('ACT', 'MANTA PP1', @sucursal, '292', '01'), ('ACT', 'PORTOVIEJO PP1', @sucursal, '293', '01')
, ('ACT', 'MANTA PP2', @sucursal, '294', '01'), ('ACT', 'PORTOVIEJO PP2', @sucursal, '295', '01')
, ('ACT', 'MALL EL FORTIN', @sucursal, '296', '01'), ('ACT', 'CAYAMBE 3', @sucursal, '297', '02')
, ('ACT', 'COTOCOLLAO 3', @sucursal, '298', '02'), ('ACT', 'LAS ESCLUSAS', @sucursal, '299', '01')
, ('ACT', 'MARTHA BRIONES', @sucursal, '300', '01'), ('ACT', 'CARLOS FUENTES', @sucursal, '301', '01')
, ('ACT', 'FRANCISCO ARAI', @sucursal, '302', '01'), ('ACT', 'BODILO', @sucursal, '303', '01')
, ('ACT', 'FREELANCE 2', @sucursal, '304', '01'), ('ACT', 'GLOBAL CALL CENTER', @sucursal, '306', '01')
, ('ACT', 'PAULA ARAY', @sucursal, '307', '01'), ('ACT', 'BANDE', @sucursal, '308', '01')
, ('ACT', 'CREDITO COLOCACION DE TARJETAS', @sucursal, '311', '01')
, ('ACT', 'FRANCISCO ARAY 2', @sucursal, '312', '01')
, ('ACT', 'COLOCACION TARJETAS ALMACEN', @sucursal, '313', '01')
, ('ACT', 'BODEGA VIRTUAL SIERRA', @sucursal, '314', '02')
, ('ACT', 'LATACUNGA 2', @sucursal, '315', '02'), ('ACT', 'POLICIA NACIONAL', @sucursal, '316', '02')
, ('ANU', 'PELILEO', @sucursal, '317', '02'), ('ACT', 'BODEGA G4', @sucursal, '320', '01')
, ('ACT', 'BAHIA DE CARAQUEZ PP1', @sucursal, '321', '02')
, ('ACT', 'QUEVEDO PAP 1', @sucursal, '322', '01'), ('ACT', 'QUEVEDO PAP 2', @sucursal, '324', '01')
, ('ACT', 'LA LIBERTAD PAP1', @sucursal, '325', '01')
, ('ACT', 'LA LIBERTAD PAP 2', @sucursal, '326', '01')
, ('ACT', 'LATACUNGA PAP 1', @sucursal, '329', '02')
, ('ACT', 'LATACUNGA PAP 2', @sucursal, '330', '02')
, ('ACT', 'LATACUNGA PAP 3', @sucursal, '332', '02'), ('ACT', 'CAYAMBE PAP 1', @sucursal, '333', '02')
, ('ACT', 'CAYAMBE PAP 2', @sucursal, '334', '02')
, ('ACT', 'SAN GABRIEL PAP 1', @sucursal, '335', '02')
, ('ACT', 'SAN GABRIEL PAP 2', @sucursal, '336', '02'), ('ACT', 'Portoviejo 4', @sucursal, '340', '01')
, ('ACT', 'E-CENTER GYE', @sucursal, '363', '01'), ('ACT', 'E-CENTER UIO', @sucursal, '369', '02')
, ('ACT', 'LA LIBERTAD PAP 3', @sucursal, '370', '01'), ('ACT', 'CHONE PAP 1', @sucursal, '371', '02')
, ('ACT', 'CHONE PAP 2', @sucursal, '372', '02'), ('ACT', 'RIOBAMBA PAP 1', @sucursal, '373', '02')
, ('ACT', 'RIOBAMBA PAP 2', @sucursal, '374', '02')
, ('ACT', 'G - Motos Mega 2', @sucursal, '375', '02')
, ('ACT', 'MPALITO - MATRIZ', @sucursal, '376', '01')
, ('ACT', 'MPALITO - MALL EL FORTÍN', @sucursal, '377', '01')
, ('ACT', 'MPALITO - CENTRO', @sucursal, '378', '01')
, ('ACT', 'MPALITO - RIOCENTRO SUR', @sucursal, '379', '01')
, ('ACT', 'FERIA GANGA', @sucursal, '380', '01'), ('ACT', 'FERIA EL INCA ', @sucursal, '381', '02')
, ('ACT', 'FERIA MEGA 2', @sucursal, '382', '02')
, ('ACT', 'MPALITO - ALBORADA', @sucursal, '383', '01')
, ('ACT', 'CAPTACION DE CLIENTES REF', @sucursal, '384', '01')
, ('ACT', 'EL PORTAL ', @sucursal, '385', '02'), ('ACT', 'DPTO OPERACIONES', @sucursal, '386', '01')
, ('ACT', 'E-COMMERCE GYE', @sucursal, '387', '01'), ('ACT', 'E-COMMERCE UIO', @sucursal, '388', '02')
, ('ACT', 'GMOTOS DAULE', @sucursal, '389', '01'), ('ACT', 'TELEVENTAS GYE', @sucursal, '390', '01')
, ('ACT', 'TELEVENTAS UIO', @sucursal, '391', '02')
, ('ACT', 'BODEGA VIRTUAL MOTOS', @sucursal, '392', '02')
, ('ACT', 'CAYAMBE PAP 3', @sucursal, '393', '02')
, ('ACT', 'FERIA COTOCOLLAO 3', @sucursal, '394', '02')
, ('ACT', 'BODEGA FERIA', @sucursal, '395', '01'), ('ACT', 'OLA - AGUIRRE 2', @sucursal, '396', '01')
, ('ACT', 'OLA - MALL DEL SUR', @sucursal, '397', '01')
, ('ACT', 'OLA - MALL EL FORTIN', @sucursal, '398', '01')
, ('ACT', 'OLA - PASEO DURAN', @sucursal, '399', '01')
, ('ACT', 'OLA - RIOCENTRO SUR', @sucursal, '404', '01')
, ('ACT', 'OLA - HIPER DAULE', @sucursal, '406', '01')
, ('ACT', 'OLA -EL RECREO', @sucursal, '407', '02')
, ('ACT', 'OLA - QUICENTRO SUR', @sucursal, '408', '02')
, ('ACT', 'OLA - ATAHUALPA', @sucursal, '409', '02')
, ('ACT', 'OLA - RECREO 2 PLAZA', @sucursal, '411', '02')
, ('ACT', 'OLA - CHILE', @sucursal, '412', '02')
, ('ACT', 'OLA - ELECTRONICA OUTLET', @sucursal, '413', '02')
, ('ACT', 'OLA - AEROPUERTO OUTLET', @sucursal, '414', '02')
, ('ACT', 'OLA  - - AKI CARAPUNGO', @sucursal, '417', '02')
, ('ACT', 'OLA - EL PORTAL CARAPUNGO', @sucursal, '418', '02')
, ('ACT', 'DESCUENTOS Y VENTAJAS GYE', @sucursal, '419', '01')
, ('ANU', 'BODEGA REMATES', @sucursal, '424', '01'), ('ANU', 'PASCUALES', @sucursal, '425', '01')
, ('ACT', 'MEGA ALMACENES 3', @sucursal, '426', '02'), ('ACT', 'LA ROLDÓS', @sucursal, '427', '02')
, ('ANU', 'MACHALA 2', @sucursal, '428', '01'), ('ACT', 'MUNICIPIO GUAYAQUIL', @sucursal, '429', '01')
, ('ACT', 'FIDEICOMISO JAHER GYE', @sucursal, '430', '01')
, ('ACT', 'FIDEICOMISO JAHER UIO', @sucursal, '434', '02')
, ('ACT', 'DESCUENTOS Y VENTAJAS UIO', @sucursal, '435', '02')
, ('ACT', 'CONSTRUFERIAS - EL FORTIN', @sucursal, '436', '01')
, ('ACT', 'CONSTRUFERIAS - TRINITARI', @sucursal, '437', '01')
, ('ACT', 'FERIA SANGOLQUI 2', @sucursal, '438', '02')
, ('ACT', 'GMOTOS NARANJITO', @sucursal, '439', '01')
, ('ACT', 'CONSTRUFERIAS MONTE SINAÍ', @sucursal, '440', '01')
, ('ACT', 'GMOTOS MACHALA', @sucursal, '441', '01')
, ('ACT', 'SERVIGANGA GYE', @sucursal, '442', '01'), ('ACT', 'SERVIGANGA UIO', @sucursal, '443', '02')
, ('ACT', 'GMOTOS - CUENCA', @sucursal, '444', '01')
, ('ACT', 'GMOTOS BABAHOYO', @sucursal, '445', '01'), ('ACT', 'GMOTOS - DURAN', @sucursal, '446', '01')
, ('ACT', 'CONSTRUFERIAS-EL FORTIN 2', @sucursal, '447', '01')
, ('ACT', 'MALL DEL SOL', @sucursal, '449', '01'), ('ACT', 'GMOTOS QUININDE', @sucursal, '450', '02')
, ('ACT', 'GMOTOS PORTOVIEJO', @sucursal, '451', '01')
, ('ACT', 'GMOTOS LA LIBERTAD', @sucursal, '452', '01')
, ('ACT', 'FERIA GANGA QUITO', @sucursal, '453', '02')
, ('ACT', 'GMOTOS LA PRENSA', @sucursal, '454', '02')
, ('ACT', 'GMOTOS EL EMPALME', @sucursal, '455', '01'), ('ACT', 'GMOTOS MANTA', @sucursal, '456', '01')
, ('ACT', 'GMOTOS MILAGRO', @sucursal, '457', '01')
, ('ACT', 'MUEBLERÍA ARTESANO DURAN', @sucursal, '458', '01')
, ('ACT', 'MUEBLERÍA ARTESANO  GYE', @sucursal, '459', '01')
, ('ACT', 'FERIA GANGA EXPOPLAZA', @sucursal, '460', '01')
, ('ACT', 'GMOTOS PEDREGAL', @sucursal, '461', '01'), ('ACT', 'GMOTOS QUEVEDO', @sucursal, '462', '01')
, ('ACT', 'GMOTOS AMBATO', @sucursal, '463', '02'), ('ACT', 'EL DORADO', @sucursal, '464', '01')
, ('ACT', 'VENTAS MAYOREO GYE', @sucursal, '465', '01')
, ('ACT', 'VENTAS MAYOREO UIO', @sucursal, '466', '02')
, ('ACT', 'GMOTOS EL CARMEN', @sucursal, '467', '02')
, ('ACT', 'GMOTOS LA CONCORDIA', @sucursal, '468', '02')
, ('ACT', 'GMOTOS MICHELENA', @sucursal, '470', '02')
, ('ACT', 'GMOTOS SANTO DOMINGO', @sucursal, '473', '02')
, ('ACT', 'FERIA NACIONES UNIDAS', @sucursal, '476', '02')
, ('ACT', 'MALL DEL NORTE', @sucursal, '477', '01')
, ('ACT', 'MPALITO - CITY MALL', @sucursal, '478', '01')
, ('ACT', 'BODEGA MALL DEL SOL', @sucursal, '479', '01'), ('ACT', 'BODEGA G5', @sucursal, '480', '01')
, ('ACT', 'GMOTOS CHILLOGALLO', @sucursal, '481', '02'), ('ACT', 'CHONGON', @sucursal, '482', '01')
, ('ACT', 'MALL LA AURORA', @sucursal, '483', '01'), ('ACT', 'NINGUNO', @sucursal, '484', '01')
, ('ACT', 'GMOTOS CHONE', @sucursal, '485', '02'), ('ACT', 'DURAN SHOPPING', @sucursal, '486', '01')
, ('ACT', 'GMOTOS PEDERNALES', @sucursal, '487', '02')
, ('ACT', 'GMOTOS PLAYAS', @sucursal, '488', '01')
, ('ACT', 'GMOTOS LA TRONCAL', @sucursal, '489', '01')
, ('ACT', 'SALVACERO MATRIZ', @sucursal, '490', '01'), ('ACT', 'GMOTOS VINCES', @sucursal, '491', '01')
, ('ACT', 'GMOTOS EL TRIUNFO', @sucursal, '492', '01')
, ('ACT', 'GMOTOS RIOBAMBA', @sucursal, '493', '02')
, ('ACT', 'SALVACERO CHONGON ', @sucursal, '494', '01')
, ('ACT', 'SALVACERO BABAHOYO', @sucursal, '495', '01')
, ('ACT', 'GMOTOS EL FORTIN', @sucursal, '496', '01')
, ('ACT', 'GMOTOS SANGOLQUI', @sucursal, '497', '02'), ('ACT', 'admin 500', @sucursal, '500', '01')
, ('ACT', 'Admi CosSi 501', @sucursal, '501', '01')
, ('ACT', 'NACIONES UNIDAS 2', @sucursal, '502', '02'), ('ACT', 'IBARRA 3', @sucursal, '503', '02')
, ('ACT', 'BAHIA DE CARAQUEZ', @sucursal, '504', '02'), ('ACT', 'EL CARMEN 2', @sucursal, '505', '02')
, ('ACT', 'TOSAGUA', @sucursal, '506', '02'), ('ACT', 'CATAMAYO', @sucursal, '507', '01')
, ('ACT', 'ARENILLAS', @sucursal, '508', '01'), ('ACT', 'PILLARO', @sucursal, '509', '02')
, ('ACT', 'SAMBORONDON PAP', @sucursal, '510', '01'), ('ACT', 'QUININDE 2', @sucursal, '511', '02')
, ('ACT', 'SANTO DOMINGO 4', @sucursal, '512', '02'), ('ACT', 'IBARRA PP1', @sucursal, '513', '02')
, ('ACT', 'IBARRA PP2', @sucursal, '514', '02'), ('ACT', 'MOTOFACIL', @sucursal, '515', '02')
, ('ACT', 'ESMERALDAS PAP 1', @sucursal, '516', '02'), ('ACT', 'ATACAMES PP1', @sucursal, '517', '02')
, ('ACT', 'MACHACHI PP1', @sucursal, '518', '02'), ('ACT', 'ESMERALDAS PAP 2', @sucursal, '519', '02')
, ('ACT', 'AMBATO 4-PAP', @sucursal, '520', '02'), ('ACT', 'STO DOMINGO PP4', @sucursal, '521', '02')
, ('ACT', 'MICHELENA-PP1', @sucursal, '522', '02'), ('ACT', 'CARAPUNGO-PP1', @sucursal, '523', '02')
, ('ACT', 'TUMBACO-PP1', @sucursal, '524', '02'), ('ACT', 'GMOTOS NARANJAL', @sucursal, '527', '01')
, ('ACT', 'CHILLOGALLO', @sucursal, '528', '02'), ('ACT', 'FERREZACA - MATRIZ', @sucursal, '529', '01')
, ('ACT', 'GMOTOS SHUSHUFINDI', @sucursal, '530', '02')
, ('ACT', 'GMOTOS PORTETE', @sucursal, '531', '01'), ('ACT', 'GMOTOS TENA', @sucursal, '532', '02')
, ('ACT', 'GMOTOS LAGO AGRIO', @sucursal, '533', '02')
, ('ACT', 'GMOTOS CALIFORNIA', @sucursal, '534', '01')
, ('ACT', 'GMOTOS PASCUALES', @sucursal, '535', '01'), ('ACT', 'FERIA GMOTOS', @sucursal, '537', '01')
, ('ACT', 'FERIA GMOTOS QUITO', @sucursal, '539', '02')
, ('ACT', 'FERIA GANGA UIO', @sucursal, '540', '02'), ('ACT', 'MACHALA PIAZZA', @sucursal, '541', '01')
, ('ACT', 'GMOTOS ATACAMES', @sucursal, '542', '02')
, ('ACT', 'FERIA GANGA GRAN REMATE', @sucursal, '543', '02')
, ('ACT', 'BODEGA CHATARRA', @sucursal, '544', '01')
, ('ACT', 'MPALITO - POLICENTRO', @sucursal, '545', '01')
, ('ACT', 'GMOTOS 9 DE OCTUBRE ', @sucursal, '546', '01')
, ('ACT', 'GMOTOS PUYO  ', @sucursal, '547', '02')
, ('ACT', 'MPALITO - MALL DEL SUR', @sucursal, '548', '01')
, ('ACT', 'super siete virtual', @sucursal, '700', '01')
, ('ACT', 'BODEGA CENTRAL', @sucursal, '999', '01');

insert into tipo(descripcion, padre) values ('En tránsito', @bodega), ('En proceso', @bodega)
, ('CREADO', @log), ('EDITADO', @log), ('ANULADO', @log);

-- = = = = = = = = = = = = = = = = = PARAMETROS DE TIPOS DOCUMENTOS = = = = = = = = = = = = = = = = =
insert into tipo(descripcion, padre) values ('Ganga', @factura), ('Servicios', @factura)
, ('Motos', @factura), ('Taller', @factura), ('Compras', @factura), ('Importaciones', @factura)
, ('Proveduria', @factura);

insert into tipo (descripcion, padre, data1, data2, data3) values 
('DESCUENTO SOBRE VENTAS', @nc,'0', '002', '1'), ('DEVOLUCION DE MERCADERIA', @nc,'0', '003', '1')
, ('RETIRO DE MERCADERIA', @nc,'0', '008', '1'), ('CANJE PUBLICITARIO', @nc,'0', '013', '0')
, ('DESCT.LETRAS-FACTURAS EMPLEADO', @nc,'0', '014', '0')
, ('CANC.CLIENTES OTRAS SUCURSALES', @nc,'0', '021', '0')
, ('DEPURACION DE CARTERA', @nc,'0', '022', '0'), ('RETIRO - GARANTIA EXTENDIA', @nc,'0', '024', '1')
, ('DESISTIMIENTO-GANGA ASEGURADA', @nc,'0', '029', '1')
, ('SEGURO - GANGA ASEGURADA', @nc,'0', '030', '1'), ('PROMOCION - CUOTA GRATIS', @nc,'0', '031', '1')
, ('CANC. POR REFINANCIAMIENTO', @nc,'0', '080', '0')
, ('ANULACION N/D INTERES MORA ', @nc,'0', '085', '0')
, ('ANULACION N/D RECARGO COBRANZA', @nc,'0', '086', '1')
, ('DESCUENTOS - CARTERA LEGAL', @nc,'0', '103', '1'), ('EXONERACION CARTERA', @nc,'0', '116', '1')
, ('PRECANCELACION DE FACTURA', @nc,'0', '118', '1')
, ('GEXT - VALOR NO ASUME POLIZA', @nc,'0', '119', '1')
, ('PROMOCION - CLIENTES NUEVOS', @nc,'0', '121', '1')
, ('FINANCIAMIENTO - NOVACION', @nc,'0', '122', '1'), ('CANCELACION POR NOVACION', @nc,'0', '123', '0')
, ('GEXT - VALOR POLIZA', @nc,'0', '130', '1'), ('TARJETA DE CREDITO - CARTERA ', @nc,'0', '131', '0')
, ('LIQUIDACION CUENTAS - TC', @nc,'0', '132', '0'), ('PROMOCIONES COMERCIALES', @nc,'0', '134', '0')
, ('APLICACION CARTERA - CLIENTES', @nc,'0', '138', '0'), ('INT. MORA', @nd,'1', '001', '0')
, ('DEPURACION DE CARTERA', @nd,'1', '007', '0'), ('CONTABILIDAD', @nd,'1', '009', '0')
, ('ANULACION RECIBO CAJA ', @nd,'1', '011', '0')
, ('CANC.CLIENTES OTRAS SUCURSALES', @nd,'1', '014', '0')
, ('GTIA.EXTENDIDA/PRECIO OFERTA', @nd,'1', '017', '0'), ('VALOR DE DEPRECIACION', @nd,'1', '019', '0')
, ('RECARGO COBRANZA PAGO TARDIO', @nd,'1', '024', '1')
, ('ANULACION N/C CUOTA GRATIS', @nd,'1', '026', '1'), ('ALCANCE CLIENTES - GAS', @nd,'1', '027', '0')
, ('DEVOL. VALOR RETENCION', @nd,'1', '028', '0'), ('ANULACION DE RETENCION', @nd,'1', '029', '1')
, ('EMISION/COBRO E.DE CREDITO', @nd,'1', '030', '1')
, ('FINANCIAMIENTO - NOVACION', @nd,'1', '038', '1')
, ('APLICACIONES CARTERA-CLIENTES', @nd,'1', '051', '0'), ('CORRESP. NO BANCARIO', @nd,'1', '100', '0');

insert into tipo(descripcion, padre, data1) values ('Saldo inicial', @ib, '1')
, ('Otros ingresos', @ib, '1'), ('Otros egresos', @eb, '0');

insert into tipo(descripcion, tipo, padre)
select m.descripcion, t1.id tipo, t1.id padre
from tipo t1, paramDocum p, (
	select 'Maestros' descripcion, 0 orden union all select 'Transacciones', 1 
    union all select 'Reportes', 2 union all select 'Presupuesto', 3 union all 
    select 'Configuraciones', 4
) m
where t1.activo = 1 and t1.estado = 'ACT' and t1.padre = p.modulo
order by 2, m.orden;

-- = = = = = = = = = = = = = = = = = = = = = = VISTAS = = = = = = = = = = = = = = = = = = = = = = 
DROP VIEW IF EXISTS vw_pais;
create view vw_pais as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramPersona p
where t1.activo = 1 and t1.padre = p.pais;

DROP VIEW IF EXISTS vw_tipo_persona;
create view vw_tipo_persona as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramPersona p
where t1.activo = 1 and t1.padre = p.persona;

DROP VIEW IF EXISTS vw_tipo_direccion;
create view vw_tipo_direccion as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramPersona p
where t1.activo = 1 and t1.padre = p.direccion;

DROP VIEW IF EXISTS vw_tipo_articulo;
create view vw_tipo_articulo as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramArticulo p
where t1.activo = 1 and t1.padre = p.articulo;

DROP VIEW IF EXISTS vw_unidad;
create view vw_unidad as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramArticulo p
where t1.activo = 1 and t1.padre = p.unidad;

DROP VIEW IF EXISTS vw_marca;
create view vw_marca as
select t1.id, t1.estado, t1.descripcion, t1.data1 codigo
from tipo t1, paramArticulo p
where t1.activo = 1 and t1.padre = p.marca;

DROP VIEW IF EXISTS vw_modulo;
create view vw_modulo as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramDocum p
where t1.activo = 1 and t1.padre = p.modulo;

DROP VIEW IF EXISTS vw_documento;
create view vw_documento as
select t1.id, t1.estado, t1.descripcion, data1 ingreso, data2 codSRI
from tipo t1, paramDocum p
where t1.activo = 1 and t1.padre = p.documento;

DROP VIEW IF EXISTS vw_canal;
create view vw_canal as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramDocum p
where t1.activo = 1 and t1.padre = p.canal;

DROP VIEW IF EXISTS vw_region;
create view vw_region as
select t1.id, t1.estado, t1.descripcion, t1.data1 codigo
from tipo t1, paramDocum p
where t1.activo = 1 and t1.padre = p.region;

DROP VIEW IF EXISTS vw_division;
create view vw_division as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramDocum p
where t1.activo = 1 and t1.padre = p.division;

DROP VIEW IF EXISTS vw_sucursal;
create view vw_sucursal as
select t1.id, t1.estado, t1.descripcion, t1.data1 codigo, t1.data2 region
from tipo t1, paramDocum p
where t1.activo = 1 and t1.padre = p.sucursal;

DROP VIEW IF EXISTS vw_bodega;
create view vw_bodega as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramDocum p
where t1.activo = 1 and t1.padre = p.bodega;

DROP VIEW IF EXISTS vw_tipo_log;
create view vw_tipo_log as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramDocum p
where t1.activo = 1 and t1.padre = p.log;

drop view if exists vw_tipo_factura;
create view vw_tipo_factura as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramTpDocum p
where t1.activo = 1 and t1.padre = p.factura;

drop view if exists vw_tipo_nc;
create view vw_tipo_nc as
select t1.id, t1.estado, t1.descripcion, t1.data1 ingreso, t1.data2 codigo, t1.data3 esElectronico
from tipo t1, paramTpDocum p
where t1.activo = 1 and t1.padre = p.nc;

drop view if exists vw_tipo_nd;
create view vw_tipo_nd as
select t1.id, t1.estado, t1.descripcion, t1.data1 ingreso, t1.data2 codigo, t1.data3 esElectronico
from tipo t1, paramTpDocum p
where t1.activo = 1 and t1.padre = p.nd;

drop view if exists vw_tipo_ib;
create view vw_tipo_ib as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramTpDocum p
where t1.activo = 1 and t1.padre = p.ib;

drop view if exists vw_tipo_eb;
create view vw_tipo_eb as
select t1.id, t1.estado, t1.descripcion
from tipo t1, paramTpDocum p
where t1.activo = 1 and t1.padre = p.eb;

drop view if exists vw_menu;
create view vw_menu as
select t1.id, t1.estado, t1.descripcion, ifnull(t1.tipo, 0) tipo, null padre, t1.data1 url
from tipo t1, paramdocum p
where t1.activo = 1 and t1.padre = p.modulo
union all
select t1.id, t1.estado, t1.descripcion, t1.tipo, t1.padre, t1.data1 url
from tipo t1
where t1.activo = 1 and exists(
	select 1
	from tipo t2, paramdocum p2
	where t2.activo = 1 and t2.padre = p2.modulo and t2.id = t1.tipo
);

-- 2. Tabla persona[cite: 1]
drop table if exists persona;
CREATE TABLE persona (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    estado VARCHAR(3) NOT NULL DEFAULT 'ACT',
    tpPersona BOOLEAN NOT NULL,
    pais INT NOT NULL,
    tipo INT NOT NULL,
    NUC VARCHAR(20) NOT NULL,
    razonSocial VARCHAR(255) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    userName VARCHAR(20) NULL,
    clave VARCHAR(255) NULL,
    UNIQUE KEY uk_persona_tipo_nuc (pais, tipo, NUC),
    CONSTRAINT fk_persona_pais FOREIGN KEY (pais) REFERENCES tipo(id),
    CONSTRAINT fk_persona_tipo FOREIGN KEY (tipo) REFERENCES tipo(id)
);

-- 3. Tabla articulo[cite: 1]
drop table if exists articulo;
CREATE TABLE articulo (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    estado VARCHAR(3) NOT NULL DEFAULT 'ACT',
    nombre VARCHAR(255) NOT NULL,
    tipo INT NOT NULL,
    codigo VARCHAR(30) NOT NULL,
    bienes BOOLEAN NOT NULL,
    mostrar BOOLEAN NOT NULL,
    padre INT NULL,
    tipoUnidad INT NULL,
    unidad INT NULL,
    marca INT NULL,
    UNIQUE KEY uk_articulo_tipo_codigo (tipo, codigo),
    CONSTRAINT fk_articulo_tipo FOREIGN KEY (tipo) REFERENCES tipo(id),
    CONSTRAINT fk_articulo_padre FOREIGN KEY (padre) REFERENCES articulo(id),
    CONSTRAINT fk_articulo_tipoUnidad FOREIGN KEY (tipoUnidad) REFERENCES tipo(id),
    CONSTRAINT fk_articulo_marca FOREIGN KEY (marca) REFERENCES tipo(id)
);

-- 4. Tabla documento[cite: 1]
drop table if exists documento;
CREATE TABLE documento (
    id BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    estado VARCHAR(3) NOT NULL DEFAULT 'ACT',
    modulo INT NOT NULL,
    documento INT NOT NULL,
    tipo INT NOT NULL,
    canal INT NOT NULL,
    numero VARCHAR(20) NOT NULL,
    fecha DATE NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    region INT NOT NULL,
    empresa INT NOT NULL,
    division INT NOT NULL,
    sucursal INT NOT NULL,
    cuotas TINYINT NOT NULL DEFAULT 1,
    plazo SMALLINT NOT NULL DEFAULT 0,
    persona INT NOT NULL,
    documentoXML LONGTEXT NULL,
    respuestaXML LONGTEXT NULL,
    lugarEgreso INT NULL,
    lugarIngreso INT NULL,
    cuentaEgreso VARCHAR(20) NULL,
    cuentaIngreso VARCHAR(20) NULL,
    vendedor INT NULL,
    cobrador INT NULL,
    transportista INT NULL,
    UNIQUE KEY uk_documento_persona_tipo_canal_numero (persona, tipo, canal, numero),
    CONSTRAINT fk_documento_modulo FOREIGN KEY (modulo) REFERENCES tipo(id),
    CONSTRAINT fk_documento_docum FOREIGN KEY (documento) REFERENCES tipo(id),
    CONSTRAINT fk_documento_tipo FOREIGN KEY (tipo) REFERENCES tipo(id),
    CONSTRAINT fk_documento_canal FOREIGN KEY (canal) REFERENCES tipo(id),
    CONSTRAINT fk_documento_region FOREIGN KEY (region) REFERENCES tipo(id),
    CONSTRAINT fk_documento_empresa FOREIGN KEY (empresa) REFERENCES persona(id),
    CONSTRAINT fk_documento_division FOREIGN KEY (division) REFERENCES tipo(id),
    CONSTRAINT fk_documento_sucursal FOREIGN KEY (sucursal) REFERENCES tipo(id),
    CONSTRAINT fk_documento_persona FOREIGN KEY (persona) REFERENCES persona(id),
    CONSTRAINT fk_documento_lugarEgreso FOREIGN KEY (lugarEgreso) REFERENCES tipo(id),
    CONSTRAINT fk_documento_lugarIngreso FOREIGN KEY (lugarIngreso) REFERENCES tipo(id),
    CONSTRAINT fk_documento_vendedor FOREIGN KEY (vendedor) REFERENCES persona(id),
    CONSTRAINT fk_documento_cobrador FOREIGN KEY (cobrador) REFERENCES persona(id),
    CONSTRAINT fk_documento_transportista FOREIGN KEY (transportista) REFERENCES persona(id)
);

-- 5. Tabla documentoDt[cite: 1]
CREATE TABLE documentoDt (
    id BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    estado VARCHAR(3) NOT NULL DEFAULT 'ACT',
    documento BIGINT NOT NULL,
    item INT NOT NULL,
    cantidad DECIMAL(18,6) NOT NULL,
    subTotal DECIMAL(18,6) NOT NULL DEFAULT 0,
    descuento DECIMAL(18,6) NOT NULL DEFAULT 0,
    iva DECIMAL(18,6) NOT NULL DEFAULT 0,
    glosa VARCHAR(250) NULL,
    origen BIGINT NULL,
    ingreso BOOLEAN NULL,
    CONSTRAINT fk_documentoDt_documento FOREIGN KEY (documento) REFERENCES documento(id),
    CONSTRAINT fk_documentoDt_item FOREIGN KEY (item) REFERENCES articulo(id),
    CONSTRAINT fk_documentoDt_origen FOREIGN KEY (origen) REFERENCES documentoDt(id)
);

-- 6. Tabla documentoLog[cite: 1]
CREATE TABLE documentoLog (
    id BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    estado VARCHAR(3) NOT NULL DEFAULT 'ACT',
    documento BIGINT NOT NULL,
    usuario INT NOT NULL,
    fechaHora DATETIME NOT NULL,
    tipo INT NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    CONSTRAINT fk_documentoLog_documento FOREIGN KEY (documento) REFERENCES documento(id),
    CONSTRAINT fk_documentoLog_tipo FOREIGN KEY (tipo) REFERENCES tipo(id)
);

-- 7. Tabla documentoRelacion[cite: 1]
CREATE TABLE documentoRelacion (
    id BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    estado VARCHAR(3) NOT NULL DEFAULT 'ACT',
    padre BIGINT NOT NULL,
    hijo BIGINT NOT NULL,
    CONSTRAINT fk_documentoRelacion_padre FOREIGN KEY (padre) REFERENCES documento(id),
    CONSTRAINT fk_documentoRelacion_hijo FOREIGN KEY (hijo) REFERENCES documento(id)
);

DELIMITER //

CREATE PROCEDURE pa_menu(
    IN p_tipo INT,
    IN p_usuario VARCHAR(30),
    IN p_rol VARCHAR(30)
)
BEGIN
    -- Asigna valor por defecto (0) si el parámetro viene NULL
    SET p_tipo = IFNULL(p_tipo, 0);

    SELECT *
    FROM vw_menu
    WHERE estado = 'ACT' AND tipo = p_tipo;
END //

DELIMITER ;

/*
insert into tipo (descripcion, tipo, padre, data1) values ('Cotizacion', 226, 915, 'cotizacion.html')
, ('Facturacion', 226, 915, 'facturacion.html'), ('Devolucion', 226, 915, 'devolucion.html');
*/

SET FOREIGN_KEY_CHECKS = 1;
