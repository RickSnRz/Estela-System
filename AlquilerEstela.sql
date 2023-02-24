create database Estela;
use Estela;

create table Inquilino(
Id_In int(5) not null auto_increment,
Nombre varchar(30),
Apellido varchar(30),
DNI char(8) not null,
primary key(Id_In)
);

create table Arrendador(
Id_Arre int(2) not null auto_increment,
Nombre varchar(25),
Apellido varchar(25),
RUC char(11),
primary key(Id_Arre)
);

create table Servicios(
Id_Serv int(2) not null auto_increment,
Nombre varchar(30),
Precio decimal(12,2),
primary key(Id_Serv)
);

create table Cuarto(
Id_Cuar int(3) not null auto_increment,
NCuarto int(3),
NPiso int(3),
PrecioCuart decimal(12,2),
primary key(Id_Cuar)
);

create table Alquiler(
Id_Al int(8) not null auto_increment,
Id_In int(5) not null,
Id_Arre int(2) not null,
Id_Serv int(2) not null,
Id_Cuar int(3) not null,
Nombre_In varchar(30),
Apellido_In varchar(30),
DNI char(8),
Nombre_Arre varchar(25),
Apellido_Arre varchar(25),
RUC char(11),
NombreServ varchar(30),
PrecioServ decimal(12,2),
N_Cuarto int(2),
N_Piso int(2),
Precio_Cuart decimal(12,2),
Precio_Total decimal(12,2),
Fecha_Entrada timestamp default current_timestamp,
Fecha_Salida timestamp on update current_timestamp,
Estado varchar(20),
primary key(Id_Al),
foreign key(Id_In) references Inquilino(Id_In),
foreign key(Id_Arre) references Arrendador(Id_Arre),
foreign key(Id_Serv) references Servicios(Id_Serv),
foreign key(Id_Cuar) references Cuarto(Id_Cuar)
);

delete from Inquilino where Id_In="1";

insert into Inquilino(Nombre, Apellido, DNI) values ("Rick Kevin","Samán Ramirez", 74843955);
insert into Arrendador(Nombre, Apellido, RUC) values ("Estela Hilaria","Gonzales Nieto", " ");
insert into Servicios(Nombre, Precio) values ("Luz-Agua-Internet", "50.00");
insert into Cuarto(NCuarto, NPiso, PrecioCuart) values (4,2,"350.00");



delimiter $$
create procedure `SP_INSERTARALQUILER`(
pId_In int,
pId_Arre int,
pId_Serv int,
pId_Cuar int,
Estado varchar(20)
)
Begin 
  
  DECLARE pNombre_In VARCHAR(255);
  DECLARE pApellido_In VARCHAR(255);
  DECLARE pDNI char(8);
  DECLARE pNombre_Arre VARCHAR(255);
  DECLARE pApellido_Arre VARCHAR(255);
  DECLARE pRUC char(11);
  DECLARE pNombreServ VARCHAR(255);
  DECLARE pPrecioServ decimal(12,2);
  DECLARE pN_Cuarto int(10);
  DECLARE pN_Piso int(10);
  DECLARE pPrecio_Cuart decimal(12,2);
  DECLARE pPrecio_Total decimal(12,2);
  
  
  select Nombre into pNombre_In from Inquilino where Id_In = pId_In;
  
  select Apellido into pApellido_In from Inquilino where Id_In = pId_In;
  
  select DNI into pDNI from Inquilino where Id_In = pId_In;
  
  select Nombre into pNombre_Arre from Arrendador where Id_Arre = pId_Arre;
  
  select Apellido into pApellido_Arre from Arrendador where Id_Arre = pId_Arre;
  
  select RUC into pRUC from Arrendador where Id_Arre = pId_Arre;
  
  select Nombre into pNombreServ from Servicios where Id_Serv = pId_Serv;
  
  select Precio into pPrecioServ from Servicios where Id_Serv = pId_Serv;
  
  select NCuarto into pN_Cuarto from Cuarto where Id_Cuar = pId_Cuar;
  
  select NPiso into pN_Piso from Cuarto where Id_Cuar = pId_Cuar;
  
  select PrecioCuart into pPrecio_Cuart from Cuarto where Id_Cuar = pId_Cuar;
 
  set pPrecio_Total = pPrecioServ + pPrecio_Cuart;
  
  
  
insert into Alquiler(Id_In,Id_Arre,Id_Serv,Id_Cuar,Nombre_In,Apellido_In,DNI,Nombre_Arre,Apellido_Arre,RUC,NombreServ,PrecioServ,N_Cuarto,N_Piso,Precio_Cuart,Precio_Total,Estado) 
values (pId_In,pId_Arre,pId_Serv,pId_Cuar,pNombre_In,pApellido_In,pDNI,pNombre_Arre,pApellido_Arre,pRUC,pNombreServ,pPrecioServ,pN_Cuarto,pN_Piso,pPrecio_Cuart,pPrecio_Total,Estado);
END;



call `SP_INSERTARALQUILER`(2,1,1,1,"Activo");