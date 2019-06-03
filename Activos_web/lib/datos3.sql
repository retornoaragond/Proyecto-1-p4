-- ---------------------------- Dependencias ---------------------------------


INSERT INTO dependencia (codigo, nombre) VALUES ('001', 'Esc.Informatica');
INSERT INTO dependencia (codigo, nombre) VALUES ('002', 'Esc.Administracion');
INSERT INTO dependencia (codigo, nombre) VALUES ('003', 'Esc.Biologia');
INSERT INTO dependencia (codigo, nombre) VALUES ('004', 'Esc.Med.Veterinaria');
INSERT INTO dependencia (codigo, nombre) VALUES ('005', 'Esc.Matematica');
INSERT INTO dependencia (codigo, nombre) VALUES ('006', 'Esc.Quimica');
INSERT INTO dependencia (codigo, nombre) VALUES ('007', 'Esc.Artes');
INSERT INTO dependencia (codigo, nombre) VALUES ('008', 'RRHH');
INSERT INTO dependencia (codigo, nombre) VALUES ('009', 'OCCB');


-- ----------------------------  Funcionarios --------------------------------

INSERT INTO funcionario (id, nombre) VALUES ('001', 'Juan Bogantes Carballo'); -- Administrador Esc.Informatica
INSERT INTO funcionario (id, nombre) VALUES ('002', 'Benito Ramirez Alfaro'); -- Administrador Esc.Administracion
INSERT INTO funcionario (id, nombre) VALUES ('003', 'Lucrecia Arrieta Fernandez'); -- Administrador Esc.Biologia
INSERT INTO funcionario (id, nombre) VALUES ('004', 'Paolo Carballo Pintus'); -- Administrador Esc.Med.Veterinaria
INSERT INTO funcionario (id, nombre) VALUES ('005', 'Marjorie Olsen Urbina'); -- Administrador Esc.Matematica
INSERT INTO funcionario (id, nombre) VALUES ('006', 'William Fajardo Carrasca'); -- Administrador Esc.Quimica
INSERT INTO funcionario (id, nombre) VALUES ('007', 'Mirian Juarez Redondo'); -- Administrador Esc.Artes

INSERT INTO funcionario (id, nombre) VALUES ('008', 'Camila Arguedas Camacho'); -- Secretaria OCCB

INSERT INTO funcionario (id, nombre) VALUES ('009', 'Pancracio Vargas Diaz'); -- Registrador
INSERT INTO funcionario (id, nombre) VALUES ('010', 'Chabelo Ganzua Polini'); -- Registrador

INSERT INTO funcionario (id, nombre) VALUES ('011', 'Santiago Beltran Xinn'); -- Jefe OCCB

INSERT INTO funcionario (id, nombre) VALUES ('012', 'Karina Arguedas Salgado'); -- Jefe RRHH



-- ----------------------------  Puestos -------------------------------------

INSERT INTO puesto (codgo, puesto) VALUES ('001', 'Administrador');
INSERT INTO puesto (codgo, puesto) VALUES ('002', 'Secretariado OCCB');
INSERT INTO puesto (codgo, puesto) VALUES ('003', 'Registrador');
INSERT INTO puesto (codgo, puesto) VALUES ('004', 'Jefe OCCB');
INSERT INTO puesto (codgo, puesto) VALUES ('005', 'Jefe RRHH');
INSERT INTO puesto (codgo, puesto) VALUES ('006', 'Profesor');
INSERT INTO puesto (codgo, puesto) VALUES ('007', 'Miscelaneo');
INSERT INTO puesto (codgo, puesto) VALUES ('008', 'Guardia de Seguridad');
INSERT INTO puesto (codgo, puesto) VALUES ('009', 'Secretariado');
INSERT INTO puesto (codgo, puesto) VALUES ('010', 'Asistente');
INSERT INTO puesto (codgo, puesto) VALUES ('011', 'Medico');




-- ----------------------------  Labores -------------------------------------


INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('001', '001', '001'); -- Administrador Esc.Informatica
INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('002', '002', '001'); -- Administrador Esc.Administracion
INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('003', '003', '001'); -- Administrador Esc.Biologia
INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('004', '004', '001'); -- Administrador Esc.Med.Veterinaria
INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('005', '005', '001'); -- Administrador Esc.Matematica
INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('006', '006', '001'); -- Administrador Esc.Quimica
INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('007', '007', '001'); -- Administrador Esc.Artes

INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('008', '009', '002'); -- Secretaria OCCB

INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('009', '009', '003'); -- Registrador
INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('010', '009', '003'); -- Registrador

INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('011', '009', '004'); -- Jefe OCCB

INSERT INTO labor (funcLab, depLab, pueLab) VALUES ('012', '008', '005'); -- Jefe RRHH


-- ------------------------------  Usuarios -----------------------------------

INSERT INTO usuario (id, pass, labUsu) VALUES ('001', SHA2('001',256), '1'); -- Administrador Esc.Informatica
INSERT INTO usuario (id, pass, labUsu) VALUES ('002', SHA2('002',256), '2'); -- Administrador Esc.Administracion
INSERT INTO usuario (id, pass, labUsu) VALUES ('003', SHA2('003',256), '3'); -- Administrador Esc.Biologia
INSERT INTO usuario (id, pass, labUsu) VALUES ('004', SHA2('004',256), '4'); -- Administrador Esc.Med.Veterinaria
INSERT INTO usuario (id, pass, labUsu) VALUES ('005', SHA2('005',256), '5'); -- Administrador Esc.Matematica
INSERT INTO usuario (id, pass, labUsu) VALUES ('006', SHA2('006',256), '6'); -- Administrador Esc.Quimica 
INSERT INTO usuario (id, pass, labUsu) VALUES ('007', SHA2('007',256), '7'); -- Administrador Esc.Artes

INSERT INTO usuario (id, pass, labUsu) VALUES ('008', SHA2('008',256), '8'); -- Secretaria OCCB

INSERT INTO usuario (id, pass, labUsu) VALUES ('009', SHA2('009',256), '9'); -- Registrador
INSERT INTO usuario (id, pass, labUsu) VALUES ('010', SHA2('010',256), '10'); -- Registrador

INSERT INTO usuario (id, pass, labUsu) VALUES ('011', SHA2('011',256), '11'); -- Jefe OCCB

INSERT INTO usuario (id, pass, labUsu) VALUES ('012', SHA2('012',256), '12'); -- Jefe RRHH


-- ----------------------------  Categorias -------------------------------------

INSERT INTO categoria (id, incremento, descripcion) VALUES ('1', '0', 'silla');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('2', '0', 'escritorio');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('3', '0', 'computadora');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('4', '0', 'extintor');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('5', '0', 'regleta');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('6', '0', 'tubo ensayo');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('7', '0', 'microhondas');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('8', '0', 'teclado');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('9', '0', 'control');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('10', '0', 'mouse');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('11', '0', 'hdmi_vga');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('12', '0', 'vga_hdmi');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('13', '0', 'parlantes');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('14', '0', 'base');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('15', '0', 'microfono');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('16', '0', 'extension');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('17', '0', 'ventilador');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('18', '0', 'tubo_prueba');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('19', '0', 'beaker');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('20', '0', 'antena');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('21', '0', 'proyector');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('22', '0', 'lapiz_pizarra');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('23', '0', 'piano');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('24', '0', 'violin');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('25', '0', 'saxofon');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('26', '0', 'microscopio');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('27', '0', 'pizarra_interac');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('28', '0', 'flauta');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('29', '0', 'reflectores');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('30', '0', 'camara');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('31', '0', 'impresora');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('32', '0', 'toldo');
 

-- ----------------------------  Solicitudes -------------------------------------
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('abc', '20181102', '1', '5000','', 'Recibida', '001', 'Donacion');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('def', '20181102', '1', '10000','', 'Recibida', '003', 'Compra');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('ert', '20180210', '1', '1500','', 'Recibida', '002', 'Generado');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('asd', '20180913', '1', '450','', 'Recibida', '004', 'Generado');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('jkl', '20180215', '1', '800','', 'Recibida','005', 'Compra');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('vbn', '20180508', '1', '745','', 'Recibida', '006', 'Compra');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('kol', '20180122', '1', '100','', 'Recibida', '007', 'Compra');



-- ----------------------------  Bienes -------------------------------------

INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('xyf', 'sillas oficina', 'patito', 'x-23', '5000', '1', '1', null);
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('fyx', 'sillas comedor', 'patito', 'x-24', '8000', '1', '1', null);
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('uio', 'escritorios', 'patitoplus', 'xy-40', '45000', '1', '2', null);
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('rrr', 'mesa', 'wood', 'm456', '50000', '1', '3', null);
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('ggg', 'basureros', 'acme', 'b71', '8000', '1', '4', null);
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('qjd', 'computadoras', 'hp', 'hp40', '200000', '1', '5', null);
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('mmn', 'routers', 'cisco', 'cs-333', '30000', '1', '6', null);
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('oiu', 'mesas', 'altea', 'aa-465', '48000', '1', '7', null);



-- ----------------------------  Activos -------------------------------------


INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('1', '001', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('2', '002', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('3', '003', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('4', '004', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('5', '005', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('6', '006', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('7', '007', '1');
INSERT INTO activo (`codigoId`, `bien_ID`) VALUES ('8', '1');


INSERT INTO grupos(id, grupo) VALUES ('001','Administrador');
INSERT INTO grupos(id, grupo) VALUES ('002','Administrador');
INSERT INTO grupos(id, grupo) VALUES ('003','Administrador');
INSERT INTO grupos(id, grupo) VALUES ('004','Administrador');
INSERT INTO grupos(id, grupo) VALUES ('005','Administrador');
INSERT INTO grupos(id, grupo) VALUES ('006','Administrador');
INSERT INTO grupos(id, grupo) VALUES ('007','Administrador');

INSERT INTO grupos(id, grupo) VALUES ('008','SecretariaOCCB');

INSERT INTO grupos(id, grupo) VALUES ('009','Registrador');
INSERT INTO grupos(id, grupo) VALUES ('010','Registrador');

INSERT INTO grupos(id, grupo) VALUES ('011','JefeOCCB');

INSERT INTO grupos(id, grupo) VALUES ('012','JefeRRHH');


