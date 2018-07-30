drop database if exists sse;
create database if not exists sse;

##### TABLAS #####

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
    idHorario int,
    idActividades int,
    fechaInicio date,
    fechaFinalizacion date
);

create table horarioServicio(
	id int auto_increment primary key unique,
    idDetalleHorarioServicio
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
    fecha date
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

##### RELACIONES ######