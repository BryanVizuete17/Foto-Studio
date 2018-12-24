/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     17/12/2018 18:35:03                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CITA') and o.name = 'FK_CITA_AGENDA_CLIENTE')
alter table CITA
   drop constraint FK_CITA_AGENDA_CLIENTE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('EVENTO') and o.name = 'FK_EVENTO_TIENE_CLIENTE')
alter table EVENTO
   drop constraint FK_EVENTO_TIENE_CLIENTE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('EVENTO') and o.name = 'FK_EVENTO_TIENE__TIPO_DE_')
alter table EVENTO
   drop constraint FK_EVENTO_TIENE__TIPO_DE_
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USUARIO') and o.name = 'FK_USUARIO_ES_CLIENTE')
alter table USUARIO
   drop constraint FK_USUARIO_ES_CLIENTE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USUARIO') and o.name = 'FK_USUARIO_ES_DE_TIPO_DE_')
alter table USUARIO
   drop constraint FK_USUARIO_ES_DE_TIPO_DE_
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CITA')
            and   name  = 'AGENDA_FK'
            and   indid > 0
            and   indid < 255)
   drop index CITA.AGENDA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CITA')
            and   type = 'U')
   drop table CITA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CLIENTE')
            and   type = 'U')
   drop table CLIENTE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('EVENTO')
            and   name  = 'TIENE__FK'
            and   indid > 0
            and   indid < 255)
   drop index EVENTO.TIENE__FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('EVENTO')
            and   name  = 'TIENE_FK'
            and   indid > 0
            and   indid < 255)
   drop index EVENTO.TIENE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EVENTO')
            and   type = 'U')
   drop table EVENTO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TIPO_DE_EVENTO')
            and   type = 'U')
   drop table TIPO_DE_EVENTO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TIPO_DE_USUARIO')
            and   type = 'U')
   drop table TIPO_DE_USUARIO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('USUARIO')
            and   name  = 'ES_DE_FK'
            and   indid > 0
            and   indid < 255)
   drop index USUARIO.ES_DE_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('USUARIO')
            and   name  = 'ES_FK'
            and   indid > 0
            and   indid < 255)
   drop index USUARIO.ES_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USUARIO')
            and   type = 'U')
   drop table USUARIO
go

/*==============================================================*/
/* Table: CITA                                                  */
/*==============================================================*/
create table CITA (
   CODIGO_CITA          int                  not null,
   ID_CLIENTE           int                  null,
   FECHA_CITA           datetime             not null,
   HORA_CITA            datetime             not null,
   OBSERVACIONES        varchar(200)         not null,
   constraint PK_CITA primary key nonclustered (CODIGO_CITA)
)
go

/*==============================================================*/
/* Index: AGENDA_FK                                             */
/*==============================================================*/
create index AGENDA_FK on CITA (
ID_CLIENTE ASC
)
go

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   ID_CLIENTE           int                  not null,
   CEDULA               varchar(10)          not null,
   NOMBRE               varchar(50)          not null,
   TELEFONO             varchar(15)          not null,
   CORREO               varchar(50)          null,
   DIRECCION            varchar(100)         null,
   constraint PK_CLIENTE primary key nonclustered (ID_CLIENTE)
)
go

/*==============================================================*/
/* Table: EVENTO                                                */
/*==============================================================*/
create table EVENTO (
   CODIGO_EVENTO        varchar(20)          not null,
   ID_CLIENTE           int                  null,
   ID_TIPO_EVENTO       int                  null,
   DIRECCION            varchar(100)         not null,
   FECHA_EVENTO         datetime             not null,
   HORA_INICIO          datetime             not null,
   HORA_FIN             datetime             not null,
   COORDINADOR          varchar(50)          not null,
   EQUIPO               varchar(200)         not null,
   constraint PK_EVENTO primary key nonclustered (CODIGO_EVENTO)
)
go

/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/
create index TIENE_FK on EVENTO (
ID_CLIENTE ASC
)
go

/*==============================================================*/
/* Index: TIENE__FK                                             */
/*==============================================================*/
create index TIENE__FK on EVENTO (
ID_TIPO_EVENTO ASC
)
go

/*==============================================================*/
/* Table: TIPO_DE_EVENTO                                        */
/*==============================================================*/
create table TIPO_DE_EVENTO (
   ID_TIPO_EVENTO       int                  not null,
   TIPO_EVENTO          varchar(50)          not null,
   constraint PK_TIPO_DE_EVENTO primary key nonclustered (ID_TIPO_EVENTO)
)
go

/*==============================================================*/
/* Table: TIPO_DE_USUARIO                                       */
/*==============================================================*/
create table TIPO_DE_USUARIO (
   ID_TIPO_USUARIO      int                  not null,
   TIPO_USUARIO         varchar(50)          not null,
   constraint PK_TIPO_DE_USUARIO primary key nonclustered (ID_TIPO_USUARIO)
)
go

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO (
   ID_USUARIO           int                  not null,
   ID_CLIENTE           int                  null,
   ID_TIPO_USUARIO      int                  null,
   NOMBRE_DE_USUARIO    varchar(50)          not null,
   CONTRASENA           varchar(20)          not null,
   constraint PK_USUARIO primary key nonclustered (ID_USUARIO)
)
go

/*==============================================================*/
/* Index: ES_FK                                                 */
/*==============================================================*/
create index ES_FK on USUARIO (
ID_CLIENTE ASC
)
go

/*==============================================================*/
/* Index: ES_DE_FK                                              */
/*==============================================================*/
create index ES_DE_FK on USUARIO (
ID_TIPO_USUARIO ASC
)
go

alter table CITA
   add constraint FK_CITA_AGENDA_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE)
go

alter table EVENTO
   add constraint FK_EVENTO_TIENE_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE)
go

alter table EVENTO
   add constraint FK_EVENTO_TIENE__TIPO_DE_ foreign key (ID_TIPO_EVENTO)
      references TIPO_DE_EVENTO (ID_TIPO_EVENTO)
go

alter table USUARIO
   add constraint FK_USUARIO_ES_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE)
go

alter table USUARIO
   add constraint FK_USUARIO_ES_DE_TIPO_DE_ foreign key (ID_TIPO_USUARIO)
      references TIPO_DE_USUARIO (ID_TIPO_USUARIO)
go

