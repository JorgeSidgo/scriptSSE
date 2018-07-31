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
drop database if exists sse;
create database if not exists sse;

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
    pass varchar(128)
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

create table activadesServicio(
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
    correo varchar(50),
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

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
##### LLAVES FORANEAS ######
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

alter table grupo add constraint fk_grupo_carrera foreign key (idCarrera) references carrera(id);
alter table carrera add constraint fk_carrera_escuela foreign key (idEscuela) references escuela(id);
alter table estudiante add constraint fk_estudiante_usuario foreign key (idUsuario) references usuario(id);
alter table estudiante add constraint fk_estudiante_grupo foreign key (idGrupo) references grupo(id);
alter table coordinador add constraint fk_estudiante_usuario foreign key (idUsuario) references usuario(id);
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
alter table detalleActividadesServicio add constraint fk_detalleActividadesServicio_horarioServicio foreign key (idHorarioServicio) references horarioServicio (id);