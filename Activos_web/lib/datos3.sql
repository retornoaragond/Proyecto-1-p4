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
INSERT INTO puesto (codgo, puesto) VALUES ('002', 'Secretariado');
INSERT INTO puesto (codgo, puesto) VALUES ('003', 'Registrador');
INSERT INTO puesto (codgo, puesto) VALUES ('004', 'Jefe OCCB');
INSERT INTO puesto (codgo, puesto) VALUES ('005', 'Jefe RRHH');
INSERT INTO puesto (codgo, puesto) VALUES ('006', 'Profesor');
INSERT INTO puesto (codgo, puesto) VALUES ('007', 'Miscelaneo');
INSERT INTO puesto (codgo, puesto) VALUES ('008', 'Guardia de Seguridad');




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

INSERT INTO usuario (id, pass, labUsu) VALUES ('001', '001', '1'); -- Administrador Esc.Informatica
INSERT INTO usuario (id, pass, labUsu) VALUES ('002', '002', '2'); -- Administrador Esc.Administracion
INSERT INTO usuario (id, pass, labUsu) VALUES ('003', '003', '3'); -- Administrador Esc.Biologia
INSERT INTO usuario (id, pass, labUsu) VALUES ('004', '004', '4'); -- Administrador Esc.Med.Veterinaria
INSERT INTO usuario (id, pass, labUsu) VALUES ('005', '005', '5'); -- Administrador Esc.Matematica
INSERT INTO usuario (id, pass, labUsu) VALUES ('006', '006', '6'); -- Administrador Esc.Quimica 
INSERT INTO usuario (id, pass, labUsu) VALUES ('007', '007', '7'); -- Administrador Esc.Artes

INSERT INTO usuario (id, pass, labUsu) VALUES ('008', '008', '8'); -- Secretaria OCCB

INSERT INTO usuario (id, pass, labUsu) VALUES ('009', '009', '9'); -- Registrador
INSERT INTO usuario (id, pass, labUsu) VALUES ('010', '010', '10'); -- Registrador

INSERT INTO usuario (id, pass, labUsu) VALUES ('011', '011', '11'); -- Jefe OCCB

INSERT INTO usuario (id, pass, labUsu) VALUES ('012', '012', '12'); -- Jefe RRHH


-- ----------------------------  Categorias -------------------------------------

INSERT INTO categoria (id, incremento, descripcion) VALUES ('1', '0', 'escritorios');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('2', '0', 'monitor computadora');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('3', '0', 'computadora');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('4', '0', 'extintor');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('5', '0', 'regleta');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('6', '0', 'tubo ensayo');
INSERT INTO categoria (id, incremento, descripcion) VALUES ('7', '0', 'horno microhondas');
 

-- ----------------------------  Solicitudes -------------------------------------
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('abc', '20181102', '1', '5000','', 'recibida', '001', 'Donacion');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('def', '20181102', '1', '10000','', 'procesada', '003', 'Compra');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('ert', '20180210', '1', '1500','', 'porVerificar', '002', 'Generado');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('asd', '20180913', '1', '450','', 'recibida', '004', 'Generado');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('jkl', '20180215', '1', '800','no claro', 'rechazada','005', 'Compra');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('vbn', '20180508', '1', '745','', 'procesada', '006', 'Compra');
INSERT INTO solicitud (numcomp, fecha, cantbien, montotal, razonR, estado, Dependencia_codigo, tipoadq) VALUES ('kol', '20180122', '1', '100','', 'porVerificar', '007', 'Compra');




-- ----------------------------  Bienes -------------------------------------

INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('xyf', 'sillas oficina', 'patito', 'x-23', '5000', '1', '1', '1');
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES 
('fyx', 'sillas comedor', 'patito', 'x-24', '8000', '1', '1', '1');
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('uio', 'escritorios', 'patitoplus', 'xy-40', '45000', '1', '2', '2');
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('rrr', 'sillones', 'wood', 'm456', '50000', '1', '3', '3');
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('ggg', 'basureros', 'acme', 'b71', '8000', '1', '4', '4');
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('qjd', 'computadoras', 'hp', 'hp40', '200000', '1', '5', '5');
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('mmn', 'routers', 'cisco', 'cs-333', '30000', '1', '6', '6');
INSERT INTO bien (serial, descripcion, marca, modelo, precioU, cantidad, solicitud, categoria) VALUES ('oiu', 'mesas', 'altea', 'aa-465', '48000', '1', '7', '7');



-- ----------------------------  Activos -------------------------------------


INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('1', '001', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('2', '002', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('3', '003', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('4', '004', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('5', '005', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('6', '006', '1');
INSERT INTO activo (`codigoId`, `labAct`, `bien_ID`) VALUES ('7', '007', '1');
INSERT INTO activo (`codigoId`, `bien_ID`) VALUES ('8', '1');




-- SELECT activo.codigoId activocodigo, activo.labAct laborActivo, bien.serial bienserial,bien.descripcion biendescripcion,categoria.id categoriaid, categoria.descripcion categoriadescripcion   from activo inner join bien on activo.bienAct = bien.serial inner join categoria on categoria.id=bien.categoria where categoria.descripcion like '%s%' ;

-- Select activo.codigoId activocodigo, activo.labAct laborActivo, activo.bienAct bienserial, IF(activo.labAct == null, 'caro','barato') from activo;

-- SELECT activo.codigoId activocodigo, labor.id laborid, bien.serial bienserial, dependencia.codigo dependenciacodigo, bien.descripcion biendescripcion, categoria.id categoriaid, categoria.descripcion categoriadescripcion, dependencia.nombre dependencianombre FROM activo INNER JOIN labor ON activo.labAct = labor.id INNER JOIN bien ON bien.serial = activo.bienAct INNER JOIN categoria ON bien.categoria = categoria.id INNER JOIN dependencia ON labor.depLab = dependencia.codigo  WHERE dependencia.nombre LIKE '%e%';

-- SELECT activo.codigoId activocodigo, labor.id laborid, bien.serial bienserial, funcionario.id funcionarioid, funcionario.nombre funcionarionombre, dependencia.codigo dependenciacodigo, bien.descripcion biendescripcion, categoria.id categoriaid, categoria.descripcion categoriadescripcion, dependencia.nombre dependencianombre FROM activo INNER JOIN labor ON activo.labAct = labor.id INNER JOIN bien ON bien.serial = activo.bienAct INNER JOIN categoria ON bien.categoria = categoria.id INNER JOIN dependencia ON labor.depLab = dependencia.codigo INNER JOIN funcionario ON funcionario.id= labor.funcLab  WHERE funcionario.nombre LIKE '%e%';

-- SELECT activo.codigoId activocodigo, labor.id laborid, bien.serial bienserial, funcionario.id funcionarioid, funcionario.nombre funcionarionombre, dependencia.codigo dependenciacodigo, bien.descripcion biendescripcion, categoria.id categoriaid, categoria.descripcion categoriadescripcion, dependencia.nombre dependencianombre FROM activo INNER JOIN labor ON activo.labAct = labor.id INNER JOIN bien ON bien.serial = activo.bienAct INNER JOIN categoria ON bien.categoria = categoria.id INNER JOIN dependencia ON labor.depLab = dependencia.codigo INNER JOIN funcionario ON funcionario.id= labor.funcLab  WHERE activo.codigoId LIKE '%1%';

-- SELECT activo.codigoId activocodigo, labor.id laborid, bien.serial bienserial, funcionario.id funcionarioid, funcionario.nombre funcionarionombre, dependencia.codigo dependenciacodigo, bien.descripcion biendescripcion, categoria.id categoriaid, categoria.descripcion categoriadescripcion, dependencia.nombre dependencianombre FROM activo INNER JOIN labor ON activo.labAct = labor.id INNER JOIN bien ON bien.serial = activo.bienAct INNER JOIN categoria ON bien.categoria = categoria.id INNER JOIN dependencia ON labor.depLab = dependencia.codigo INNER JOIN funcionario ON funcionario.id= labor.funcLab  WHERE categoria.descripcion LIKE '%e%';

-- SELECT activo.codigoId activocodigo, labor.id laborid, bien.serial bienserial, funcionario.id funcionarioid, funcionario.nombre funcionarionombre, dependencia.codigo dependenciacodigo, bien.descripcion biendescripcion, categoria.id categoriaid, categoria.descripcion categoriadescripcion, dependencia.nombre dependencianombre FROM activo INNER JOIN labor ON activo.labAct = labor.id INNER JOIN bien ON bien.serial = activo.bienAct INNER JOIN categoria ON bien.categoria = categoria.id INNER JOIN dependencia ON labor.depLab = dependencia.codigo INNER JOIN funcionario ON funcionario.id= labor.funcLab  WHERE bien.descripcion LIKE '%e%';

-- SELECT usuario.id id_user, pass clave, funcionario.id id_func, nombre, dependenciaLabor dependencia, PuestoLabor puesto FROM usuario  INNER JOIN Funcionario  ON usuario.funcionarioUsuario = Funcionario.id INNER JOIN Labor ON Funcionario.id = Labor.FuncionarioLabor WHERE usuario.id= '001' AND usuario.pass='001';

-- SELECT * FROM solicitud INNER JOIN bien ON solicitud.numSolicitud = bien.solicitudBien;

-- SELECT * FROM usuario INNER JOIN funcionario ON usuario.funcionarioUsuario = funcionario.id; 

-- SELECT * FROM puesto WHERE codigo = '001'; 

-- SELECT usuario.id id_user, pass clave, funcionarioUsuario id_func FROM usuario WHERE usuario.id= '001';

-- SELECT * FROM usuario WHERE id='001';
-- SELECT * FROM sistemaactivos.usuario;
-- SELECT * FROM sistemaactivos.labor;
-- SELECT * FROM sistemaactivos.labor;
-- SELECT * FROM usuario WHERE usuario.id = 001; 
-- UPDATE solicitud SET registrador = '009' WHERE (numsol = '1');
-- DELETE FROM solicitud WHERE (numsol = '2');


-- SELECT * FROM sistemaactivos.dependencia;
-- SELECT * FROM dependencia WHERE codigo LIKE '%s%'
-- SELECT LAST_INSERT_ID();
-- UPDATE `sistemaactivos`.`solicitud` SET `registrador` = '010' WHERE (`numsol` = '9');
