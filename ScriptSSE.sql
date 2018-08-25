-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### SCRIPT BASE DE DATOS SISTEMA DE CONTROL DE SERVICIO SOCIAL ESTUDIANTIL  ITCA-FEPADE #####
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**
 * SIS12-B
 * Grupo N° 2 
 * Integrantes:
 *      - Francisco Montoya
 *      - Benjamín Ramírez
 *      - Abdiel Martínez
 *      - Jorge Sidgo
 * Fecha: 30/07/2018
 */

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### BD #####
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
drop database if exists sse;
create database if not exists sse;
use sse;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### TABLAS #####
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

create table escuela(
	id int auto_increment primary key unique,
    nombreEscuela varchar(50)
);

create table carrera(
	id int auto_increment primary key unique,
    nombreCarrera varchar(50),
    idEscuela int not null
);

create table grupo(
	id int auto_increment primary key unique,
    nombreGrupo varchar(50),
    idCarrera int not null
);

create table usuario(
	id int auto_increment primary key unique,
    nomUsuario varchar(25) not null,
    pass varchar(128),
    estado int,
    idRol int
);

create table rol(
	id int auto_increment primary key unique,
    descRol varchar(50)
);

create table materia(
	id int auto_increment primary key unique,
    nombreMateria varchar(50),
    codMateria varchar(10)
);

create table materiasEstudiante(
	id int auto_increment primary key unique,
    idEstudiante int,
    idMateria int
);

create table hojaServicioSocial(
	id int auto_increment primary key unique,
    idEstudiante int,
    idInstitucion int,
    idCoordinador int,
    fechaInicio date,
    fechaFinalizacion date
);

create table horarioServicio(
	id int auto_increment primary key unique,
    idHojaServicioSocial int
);

create table detalleHorarioServicio(
    id int auto_increment primary key unique,
    nHoras int,
    diaSemana varchar(20),
    idHorarioServicio int
);

create table actividadesServicio(
    id int auto_increment primary key unique,
    idHojaServicioSocial int
);

create table detalleActividadesServicio(
    id int auto_increment primary key unique,
    actividad text,
    objetivos text,
    metas text,
    duracion text,
    idActividadesServicio int
);

create table institucion(
	id int auto_increment primary key unique,
    nombreInstitucion varchar(50),
    direccion text,
    correo varchar(50),
    telefono varchar(10),
    idTipoInstitucion int
);

create table tipoInstitucion(
	id int auto_increment primary key unique,
    descTipoInstitucion varchar(15)
);

create table solicitud(
    id int auto_increment primary key unique,
    idEstudiante int not null,
    idCoordinador int not null,
    idInstitucion int not null,
    fecha date,
    comentarios text,
    estado int
);

create table estadoSolicitud(
    id int auto_increment primary key unique,
    descEstado varchar(15)
);

create table estudiante(
	id int auto_increment primary key unique,
    carnet varchar(10) not null,
    nombres varchar(50),
    apellidos varchar(50),
    correo varchar(50),
    idGrupo int not null,
    idUsuario int not null
);

create table coordinador(
	id int auto_increment primary key unique,
    nombres varchar(50),
    apellidos varchar(50),
    correo varchar(125),
    idUsuario int not null
);

create table horarioAtencion(
	id int auto_increment primary key unique,
    idCoordinador int
);

create table detalleHorarioAtencion(
	id int auto_increment primary key unique,
    hora varchar(10),
    dia varchar(10),
    ubicacion varchar(10),
    idHorarioAtencion int
);

create table correo(
    id int auto_increment primary key unique,
    fecha date,
    titulo varchar(25),
    idCoordinador int,
    idEstudiante int
);

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### LLAVES FORANEAS ######
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

alter table grupo add constraint fk_grupo_carrera foreign key (idCarrera) references carrera(id);
alter table carrera add constraint fk_carrera_escuela foreign key (idEscuela) references escuela(id);
alter table usuario add constraint fk_usuario_rol foreign key (idRol) references rol(id);
alter table estudiante add constraint fk_estudiante_usuario foreign key (idUsuario) references usuario(id);
alter table estudiante add constraint fk_estudiante_grupo foreign key (idGrupo) references grupo(id);
alter table coordinador add constraint fk_coordinador_usuario foreign key (idUsuario) references usuario(id);
alter table horarioAtencion add constraint fk_horarioAtencion_coordinador foreign key (idCoordinador) references coordinador(id);
alter table detalleHorarioAtencion add constraint fk_detalleHorarioAtencion_horarioAtencion foreign key (idHorarioAtencion) references horarioAtencion(id);
alter table institucion add constraint fk_institucion_tipoInstitucion foreign key (idTipoInstitucion) references tipoInstitucion(id);
alter table solicitud add constraint fk_solicitud_estudiante foreign key (idEstudiante) references estudiante(id);
alter table solicitud add constraint fk_solicitud_coordinador foreign key (idCoordinador) references coordinador(id);
alter table solicitud add constraint fk_solicitud_institucion foreign key (idInstitucion) references institucion(id);
alter table solicitud add constraint fk_solicitud_estadoSolicitud foreign key (estado) references estadoSolicitud(id);
alter table materiasEstudiante add constraint fk_materiasEstudiante_materia foreign key (idMateria) references materia(id);
alter table materiasEstudiante add constraint fk_materiasEstudiante_estudiante foreign key (idEstudiante) references estudiante(id);
alter table hojaServicioSocial add constraint fk_hojaServicioSocial_estudiante foreign key (idEstudiante) references estudiante(id);
alter table hojaServicioSocial add constraint fk_hojaServicioSocial_institucion foreign key (idInstitucion) references institucion(id);
alter table hojaServicioSocial add constraint fk_hojaServicioSocial_coordinador foreign key (idCoordinador) references coordinador(id);
alter table horarioServicio add constraint fk_horarioServicio_hojaServicioSocial foreign key (idHojaServicioSocial) references hojaServicioSocial(id);
alter table actividadesServicio add constraint fk_actividadesServicio_hojaServicioSocial foreign key (idHojaServicioSocial) references hojaServicioSocial(id);
alter table detalleHorarioServicio add constraint fk_detalleHorarioServicio_horarioServicio foreign key (idHorarioServicio) references horarioServicio (id);
alter table detalleActividadesServicio add constraint fk_detalleActividadesServicio_horarioServicio foreign key (idActividadesServicio) references actividadesServicio (id);
alter table correo add constraint fk_correo_coordinador foreign key (idCoordinador) references coordinador (id);
alter table correo add constraint fk_correo_estudiante foreign key (idEstudiante) references estudiante (id);


-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### PROCEDIMIENTOS ALMACENADOS ######
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

### Usuario

-- Registrar
delimiter $$
create procedure p_registrarUsuario(
	in nom varchar(50),
    in contra varchar(50),
    in rol int
)
begin
	insert into usuario values(null, nom, sha1(contra), 1, rol);
end
$$

-- Login
delimiter $$
create procedure p_login(
	in nom varchar(50),
    in contra varchar(50)
)
begin
	select * from usuario where nomUsuario = nom and pass = sha1(contra) and estado = 1;
end
$$


### Institucion
	-- Insert --
delimiter $
create procedure insInstitu(in id int, in nombreInstitucion varchar(50), in direccion text, in correo varchar(50), in telefono varchar(10), in idTipoInstitucion int)
begin
	insert into institucion values (id,nombreInstitucion,direccion,correo,telefono,idTipoInstitucion);
end $

	-- Update --
delimiter $
create procedure updInstitu(in id int, in nombreInstitucion varchar(50), in direc text, in correro varchar(50), in tel varchar(10), in idTipoInst int)
begin
	update institucion set nombreInstitucion = nombreInstitucion, direccion = direc, correo = correo, telefono = tel, idTipoinstitucion = idTipoInst
	where id = id;
end $

	-- delete --
delimiter $
create procedure dltInstitu(in id int)
begin 
	delete from Institucion where id = id;
end $

	-- show --
delimiter $
create procedure showInstitu()
begin 
	select * from Institucion;
end $


/* Para llamar un procedimiento
	call nombreProcedimiento(parametros)
*/

### Hoja de Solicitud
	-- Insert --
delimiter $
create procedure insHojaServicio(in id int, in idEstudiante int, in idInstituicion int, in idCoordinador int, in fechaInicio date, in fechaFinalizacion date)
begin 
	insert into hojaserviciosocial values (id,idEstudiante,idInstitucion,idCoordinador,fechaInicio,fechaFinalizacion);
end $

	-- Update --
delimiter $
create procedure updHojaServicio(in id int, in idEs int, in idInst int, in idCo int, in fechaInicio date, in fechaFin date)
begin
	update hojaserviciosocial set idEstudiante = idEs, idInstitucion = idInst, idCoordinador = idCo, fechaInicio = fechaInicio, fechaFinalizacion = fechaFin
    where id = id;
end $

	-- show --
delimiter $
create procedure showHojaServicio()
begin 
	select * from hojaserviciosocial;
end $

-- ------------------------------------------------------------------------------------------------------------------------------------------
### Solicitud 
	-- Insert
delimiter $
create procedure insSolicitud(in id int, in idEstudiante int, in idCoordinador int, in idInstituicion int, in fecha date, in com text, in estado int)
begin 
	insert into solicitud values (id,idEstudiante,idCoordinador,idInstitucion,fecha,com,estado);
end $

	-- Update --
delimiter $
create procedure updSolicitud(in id int, in idEs int, in idCo int, in idInst int, in fecha date, in com text, in estado int)
begin
	update solicitud set idEstudiante = idEs, idCoordinador = idCo, idInstitucion = idInst, fecha = fecha, comentarios = com, estado = estado
    where id = id;
end $

	-- delete --
delimiter $
create procedure dltSolicitud(in id int)
begin 
	delete from solicitud where id = id;
end $

	-- show --
delimiter $
create procedure showSolicitud()
begin 
	select * from solicitud;
end $


-- Coordinador
delimiter $$
create procedure p_registrarCoordinador(
	in nom varchar(50),
    in ape varchar(50),
    in corr varchar(124),
    in nomUsuario varchar(50),
    in contra varchar(50)
)
begin
	declare idUsuario int;
	call p_registrarUsuario(nomUsuario, contra, 4);
    set idUsuario = (select max(id) from usuario);
    insert into coordinador values(null, nom, ape, corr, idUsuario);
end
$$
select * from usuario;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### DATOS INICIALES ######
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into rol values(null, 'Desarrollador');
insert into rol values(null, 'Administrador');
insert into rol values(null, 'Invitado');
insert into rol values(null, 'Coordinador');
insert into rol values(null, 'Estudiante');

insert into escuela values (null, 'Escuela de Ingenieria en Computacion');
insert into carrera values (null, 'Tecnico en Ingenieria de Sistemas', 1);
insert into grupo values (null, 'SIS12-A', 1);

call p_registrarCoordinador('Giovanni Ariel', 'Tzec Chavez', 'giovanni.tzec@gmail.com', 'GiovanniTzec', 'tugfa');





