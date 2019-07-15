--Creación de la Base de Datos:--------------------------------------------------------------------------------------

CREATE DATABASE Homepetdb;
--DROP DATABASE Homepetdb;

--Fin de la Creación de la Base de Datos.----------------------------------------------------------------------------

--Creacion de las Tablas----------------------------------------------------------------------------------------------
CREATE DOMAIN dom_codigo AS
    varchar(5) NOT NULL
;

CREATE DOMAIN dom_sexo AS
    char (1) NOT NULL
    CHECK (VALUE='F' OR VALUE='M')
;

CREATE DOMAIN dom_cedula AS
    varchar (10) NOT NULL
;

CREATE DOMAIN dom_nombre_apellido AS
    varchar(40) NOT NULL
;

CREATE TYPE nombre_apellido AS(
    nombre dom_nombre_apellido,
    apellido dom_nombre_apellido
);

CREATE TYPE Rango AS(
    Minimo varchar(10),
    Maximo varchar(10)
);

CREATE TABLE IF NOT EXISTS Animales (
    Cod_Animal dom_codigo  NOT NULL,
    Descripcion varchar(140) NOT NULL,

    PRIMARY KEY (Cod_Animal)
);

/*CRUD Tabla Animales

--	SELECT * FROM Animales
--	INSERT INTO Animales (cod_animal, Descripcion) VALUES (?,?);
--	DROP TABLE Animales
--  UPDATE Animales
    SET Descripcion = ???
    WHERE Cod_Animal = ???(Codigo del animal a modificar);

--Fin CRUD Tabla Animales*/

CREATE TABLE IF NOT EXISTS Homepets (
    RIF varchar (20) NOT NULL,
    Nombre varchar(20) NOT NULL,
    Ciudad varchar(15) NOT NULL,
    Sector varchar(15) NOT NULL,
    Cod_Animal VARCHAR(5),
	Capacidad INTEGER NOT NULL,

    PRIMARY KEY (RIF),
    CONSTRAINT un_Homepets UNIQUE (Ciudad, Sector),
    FOREIGN KEY (Cod_Animal) 
        REFERENCES Animales(Cod_Animal) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);

/*CRUD Tabla Homepets

--	SELECT * FROM Homepets
--	INSERT INTO Homepets (RIF, Nombre, Ciudad, Sector, Cod_Animal, Capacidad) VALUES (?,?,?,?,?,?);
--  UPDATE Homepets
    SET Nombre = ???,
        Ciudad = ???,
        Sector = ???,
        Cod_Animal = ???,
        Capacidad = ???
    WHERE RIF = ???(RIF del homepet);
--	DROP TABLE Homepets

--Fin CRUD Tabla Homepets*/

CREATE TABLE IF NOT EXISTS Empleados (
    Cedula dom_cedula,
    Nombre_Completo nombre_apellido,
    Sueldo integer NOT NULL
        CHECK (Sueldo >= '0'),
    Direccion varchar(50) NOT NULL,
    RIF_Homepet varchar(20) NOT NULL,
    Telefono varchar(15) NOT NULL,

    PRIMARY KEY (Cedula),
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*CRUD Tabla Empleados

--	SELECT * FROM Empleados
--	INSERT INTO Empleados (Cedula, Nombre_Completo, Sueldo, Direccion, RIF_Homepet, Telefono) VALUES (?,?,?,?,?,?);
--  UPDATE Empleados
    SET Nombre_Completo = ???,
        Sueldo = ???,
        Direccion = ???,
        RIF_Homepet = ???,
        Telefono = ???
    WHERE Cedula = ??? (Cedula del empleado a modificar);

--	DROP TABLE Empleados

--Fin CRUD Tabla Empleados*/

CREATE TABLE IF NOT EXISTS Encargados (
    Cedula_Encargado dom_cedula,
    Fecha_Inicio date NOT NULL,

    PRIMARY KEY (Cedula_Encargado),
    FOREIGN KEY (Cedula_Encargado) 
        REFERENCES Empleados (Cedula) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);

/*CRUD Tabla Encargados

--	SELECT * FROM Encargados
--	INSERT INTO Encargados (Cedula_Encargado, Fecha_Inicio) VALUES (?,?);
--  UPDATE Encargados
    SET Fecha_Inicio = ???
    WHERE Cedula_Encargado = ??? (Cedula del encargado a modificar);

--	DROP TABLE Encargados

--Fin CRUD Tabla Encargados*/

CREATE TABLE IF NOT EXISTS Usuarios (
	Cod_User dom_codigo NOT NULL,
	Alias_Usuario varchar(20) NOT NULL,
	Nombre nombre_apellido NOT NULL,
	Contrasenia dom_codigo NOT NULL,
	Tipo_Usuario VARCHAR(15) NOT NULL CHECK(tipo_usuario = 'Encargado' OR tipo_usuario = 'Empleado' OR tipo_usuario = 'Administrador'),
		
	PRIMARY KEY (cod_user)
);

/*CRUD Tabla Usuarios

	SELECT * FROM Usuarios
	INSERT INTO Usuarios (cod_user, alias_usuario, nombre, contrasenia, tipo_usuario) VALUES (?,?,?,?,?);
  UPDATE Usuarios
    SET Alias_Usuario = ???,
        Nombre = ???,
        Contrasenia = ???,
        Tipo_Usuario = ???
    WHERE Cod_User = ??? (Codigo del Usuario a modificar);
	DROP TABLE Usuarios

Fin CRUD Tabla Usuarios*/

CREATE TABLE IF NOT EXISTS Veterinarios (
    Cedula dom_cedula  NOT NULL,
    Nombre nombre_apellido NOT NULL,
    Telefono varchar(15) NOT NULL,

    PRIMARY KEY (Cedula)
);

/*CRUD Tabla Veterinarios

--	SELECT * FROM Veterinarios
--	SELECT Cedula, Nombre FROM Veterinarios
--	INSERT INTO Veterinarios (cedula, nombre, telefono) VALUES (?,?,?);
--	DROP TABLE Veterinarios
--  UPDATE Veterinarios
    SET Telefono = ???
    WHERE Cedula = ???(Cedula del Empleado a modificar);

--Fin CRUD Tabla Animales*/

CREATE TABLE IF NOT EXISTS Razas (
	Cod_Animal dom_codigo UNIQUE,
	Cod_Raza dom_codigo,
    Nombre varchar(30) NOT NULL,
    Pais_Origen varchar(15) NOT NULL,
    Descripcion varchar (60) NOT NULL,
    Talla varchar(15) NOT NULL
        CHECK (Talla='Pequenia' OR Talla='Mediana' OR Talla='Grande'),
    Cntxt_Frt varchar(2) NOT NULL
        CHECK (Cntxt_Frt='Si' OR Cntxt_Frt='No' OR Cntxt_Frt='S' OR Cntxt_Frt='N'),
    Nivel_Int varchar(10) NOT NULL
        CHECK (Nivel_Int='Bajo' OR Nivel_Int='Medio' OR Nivel_Int='Alto'),
    Color_Plj varchar(10) NOT NULL,
    Rango_Altura Rango NOT NULL,
    Rango_Peso Rango NOT NULL,

    PRIMARY KEY (Cod_Raza),
    FOREIGN KEY (Cod_Animal)
        REFERENCES Animales (Cod_Animal)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*CRUD Tabla Razas

--	SELECT * FROM Razas
--	SELECT Nombre FROM Razas
--	INSERT INTO Razas (cod_raza, Pais_Origen, Descripcion, Talla, Cntxt_Frt, Nivel_Int, Color_Plj, Altura_Min, Altura_Max) VALUES (?,?,?,?,?,?,?,?,?);
--  UPDATE Razas
    SET Nombre = ?,
        Pais_Origen = ?,
        Descripcion = ?,
        Talla = ?,
        Cntxt_Frt = ?,
        Nivel_Int = ?,
        Color_Plj = ?,
        Altura_Min = ?,
        Altura_Max = ?
    WHERE Cod_Raza = ???(Codigo de la raza a modificar);
--	DROP TABLE Razas

--Fin CRUD Tabla Razas*/

CREATE TABLE IF NOT EXISTS Productos (
    Cod_Producto dom_codigo,
    Nombre varchar(30) NOT NULL,
    Descripcion varchar(40) NOT NULL,

    PRIMARY KEY (Cod_Producto)
);

/*CRUD Tabla Productos

--	SELECT * FROM Productos
--	INSERT INTO Productos (Cod_Prod, Nombre, Descripcion) VALUES (?,?,?);
--  UPDATE Productos
    SET Nombre = ???,
        Descripcion = ???,
    WHERE Cod_Prod = ???(El codigo del producto a modificar);
--	DROP TABLE Productos

--Fin CRUD Tabla Productos*/

CREATE TABLE IF NOT EXISTS Servicios (
    Cod_Servicio dom_codigo UNIQUE,
    Nombre varchar(15) NOT NULL,
    Descripcion varchar(60) NOT NULL,

    PRIMARY KEY (Cod_Servicio)
);

/*CRUD Tabla Servicios

--	SELECT * FROM Servicios
--	INSERT INTO Servicios (Cod_Servicio, Nombre, Descripcion) VALUES (?,?,?);
--  UPDATE Servicios
    SET Nombre = ???,
        Descripcion = ???
    WHERE Cod_Servicio = ???(Codigo del servicio a modificar);
--	DROP TABLE Servicios

--Fin CRUD Tabla Servicios*/

CREATE TABLE IF NOT EXISTS Duenios (
    Cedula dom_cedula	NOT NULL,
    Nombre_Completo nombre_apellido NOT NULL,
    Email varchar(40),

    PRIMARY KEY (Cedula)
);

/*CRUD Tabla Duenios

--	SELECT * FROM Duenios
--	INSERT INTO Duenios (Cedula, Nombre_Completo, Email) VALUES (?,?,?);
--  UPDATE Duenios
    SET Nombre_Completo = ???,
        Email = ???,
    WHERE Cedula = ??? (Cedula del duenio a modificar);
--	DROP TABLE Duenios

--Fin CRUD Tabla Duenios*/

CREATE TABLE IF NOT EXISTS Facturas (
    Cod_Factura dom_codigo,
    Fecha_F varchar(10) NOT NULL,
    Monto_Total FLOAT NOT NULL,
    Tipo varchar(10) NOT NULL,
    Pagado boolean NOT NULL,

    PRIMARY KEY (Cod_Factura)
);

/*  CRUD Facturas ------------------------------------------------------------------

--	SELECT * FROM Facturas
--  Insert INTO Facturas (Cod_Factura, Fecha_F, Monto_Total, Tipo) VALUES (?,?,?,?);
--  UPDATE Facturas
    SET Fecha_F = ???,
        Monto_Total = ???,
        Tipo = ???
    WHERE Cod_Factura = ???(Codigo de la factura a modificar);
--  DROP TABLE Facturas

--Fin CRUD Facturas*/

CREATE TABLE IF NOT EXISTS Mascotas (
    Cod_Mascota dom_codigo NOT NULL,
    Nombre varchar(30) NOT NULL,
    Fecha_Nac date NOT NULL,
    Tipo_Animal varchar(10) NOT NULL,
    Sexo dom_sexo,
    Cedula_Duenio dom_cedula,
    Cod_Raza dom_codigo NOT NULL,
    Cedula_Vet dom_cedula,
    
    PRIMARY KEY(Cod_Mascota),
    FOREIGN KEY (Cedula_Duenio) 
        REFERENCES Duenios(Cedula) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT,
    FOREIGN KEY(Cod_Raza) 
        REFERENCES Razas(Cod_Raza) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT,
    FOREIGN KEY (Tipo_Animal) 
        REFERENCES Razas(Cod_Animal) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT,
    FOREIGN KEY (Cedula_Vet) 
        REFERENCES Veterinarios(Cedula) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);

/*CRUD Tabla Mascotas

--	SELECT * FROM Mascotas
--	INSERT INTO Mascotas (Cod_Mascota, Nombre, Fecha_Nac, Tipo_Animal, Sexo, Cedula_Duenio, Cod_Raza, Cedula_Vet) VALUES (?,?,?,?,?,?,?,?);
--  UPDATE Mascotas
    SET Nombre = ???,
        Fecha_Nac = ???,
        Tipo_Animal = ???,
        Sexo = ???,
        Cedula_Duenio = ???,
        Cod_Raza = ???,
        Cedula_Vet = ???
    WHERE Cod_Mascota = ???(Codigo de la mascota a modificar);
--	DROP TABLE Mascotas

--Fin CRUD Tabla Mascotas*/

CREATE TABLE IF NOT EXISTS Alimentacion(
    Cod_Mascota dom_codigo,
    Tipo_Comida varchar(15) NOT NULL,
    Cantidad integer NOT NULL,
    Unidad varchar(20) NOT NULL,

    PRIMARY KEY (Cod_Mascota, Tipo_Comida),
    FOREIGN KEY (Cod_Mascota) REFERENCES Mascotas(Cod_Mascota) ON UPDATE CASCADE ON DELETE RESTRICT
);

/*CRUD Tabla Alimentacion

--	SELECT * FROM Alimentacion
--	INSERT INTO Alimentacion (Cod_Mascota, Tipo_Comida, Cantidad, Unidad) VALUES (?,?,?,?);
--  UPDATE Alimentacion
    SET Tipo_Comida = ???,
        Cantidad = ???,
        Unidad = ???
    WHERE Cod_Mascota = ???(Codigo de la mascota a modificar);
--	DROP TABLE Alimentacion

--Fin CRUD Tabla Alimentacion*/

CREATE TABLE IF NOT EXISTS Homepet_Mascotas(
    Cod_Mascota dom_codigo,
    RIF_Homepet dom_codigo,

    PRIMARY KEY (Cod_Mascota, RIF_Homepet),
    FOREIGN KEY (Cod_Mascota) REFERENCES Mascotas(Cod_Mascota) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (RIF_Homepet) REFERENCES Homepets(RIF) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Ficha_Registro (
    Cod_Registro dom_codigo,
    Fecha_E varchar(10) NOT NULL,
    Hora_E time NOT NULL,
    Fecha_SEst varchar(10) NOT NULL,
    Hora_SEst time NOT NULL,
    Fecha_SReal varchar(10) NOT NULL,
    Hora_SReal time NOT NULL,

    PRIMARY KEY (Cod_Registro)
);

/*CRUD Tabla Ficha_Registro

--	SELECT * FROM Ficha_Registro
--	INSERT INTO Ficha_Registro (Cod_Registro, Fecha_E, Hora_E, Fecha_SEst, Hora_SEst, Fecha_SReal, Hora_SReal) VALUES (?,?,?,?,?,?,?);
--  UPDATE Ficha_Registro
    SET Fecha_E = ???,
        Hora_E = ???,
        Fecha_SEst = ???,
        Hora_SEst = ???,
        Fecha_SReal = ???,
        Hora_SReal = ???
    WHERE Cod_Registro = ??? (Codigo del registro a modificar);
--	DROP TABLE Ficha_Registro

--Fin CRUD Tabla Ficha_Registro*/

CREATE TABLE IF NOT EXISTS Modalidades (
    Cod_Factura dom_codigo,
    Fecha varchar(10) NOT NULL,
    Monto integer NOT NULL,
    Tipo_M varchar(10) NOT NULL,
    Numero varchar(20) NOT NULL,

    PRIMARY KEY (Cod_Factura, Tipo_M),
    FOREIGN KEY (Cod_Factura)
        REFERENCES Facturas (Cod_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*CRUD Tabla Modalidades

--	SELECT * FROM Modalidades
--	INSERT INTO Modalidades (Cod_Factura, Fecha, Monto, Tipo_M, Numero) VALUES (?,?,?,?,?);
--  UPDATE Modalidades
    SET Fecha = ???,
        Monto = ???,
        Tipo_M = ???,
        Numero = ???
    WHERE Cod_Mod = ???(Codigo de la modalidad a modificar);
--	DROP TABLE Modalidades

--Fin CRUD Tabla Modalidades*/

CREATE TABLE IF NOT EXISTS Reservaciones (
    Cod_Reserva dom_codigo,
    Fecha_Reservacion varchar(10) NOT NULL,
    Fecha_Pautada varchar(10) NOT NULL,
    Monto_Abonado integer NOT NULL,
    Monto_Total integer NOT NULL,
    Descuento integer NULL,
    Pagado boolean NOT NULL,
    RIF_Homepet dom_codigo,

    PRIMARY KEY(Cod_Reserva),
    FOREIGN KEY(RIF_Homepet) REFERENCES Homepets(RIF) ON UPDATE CASCADE ON DELETE RESTRICT
);

/*CRUD Tabla Reservaciones

--	SELECT * FROM Reservaciones
--	INSERT INTO Reservaciones (Cod_Reserva, Fecha_Reservacion, Fecha_Pautada, Monto_Abonado, Monto_Total, Descuento, Pagado) VALUES (?,?,?,?,?,?,?);
--  UPDATE Reservaciones
    SET Fecha_Reservacion = ???,
        Fecha_Pautada = ???,
        Monto_Abonado = ???,
        Monto_Total = ???,
        Descuento = ???,
        Pagado = ???
    WHERE Cod_Reserva = ???(Codigo de la reserva a modificar);
--	DROP TABLE Reservaciones

--Fin CRUD Tabla Reservaciones*/

CREATE TABLE IF NOT EXISTS Actividades (
    Cod_Actividad integer NOT NULL UNIQUE,
    Cod_Servicio dom_codigo UNIQUE,
    Descripcion varchar(50) NOT NULL,

    PRIMARY KEY (Cod_Actividad),
    FOREIGN KEY (Cod_Servicio)
        REFERENCES Servicios (Cod_Servicio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*CRUD Tabla Actividades

--	SELECT * FROM Actividades
--	INSERT INTO Actividades (Cod_Actividad, Cod_Servicio, Descripcion) VALUES (?,?,?);
--  UPDATE Actividades
    SET Cod_Servc = ???,
        Descripcion = ???
    WHERE Cod_Actividad = ???(Codigo de la actividad a modificar);
--	DROP TABLE Actividades

--Fin CRUD Tabla Actividades*/

CREATE TABLE IF NOT EXISTS Homepet_Producto (
    Cod_Producto dom_codigo,
    RIF dom_codigo,
    Costo integer NOT NULL,
    Cantidad_Minima integer NOT NULL,
    Cantidad_Disponible integer NOT NULL,


    PRIMARY KEY (Cod_Producto, RIF),
    FOREIGN KEY (Cod_Producto)
        REFERENCES Productos (Cod_Producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (RIF)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Homepet_Producto ------------------------------------------------------------------

	SELECT * FROM Homepet_Producto
  Insert INTO Homepet_Producto (Cod_Producto, RIF, Costo, Cantidad_Minima, Cantidad_Disponible) VALUES (?,?,?,?,?)
  DROP TABLE Homepet_Producto

    Fin CRUD Homepet_Producto */

CREATE TABLE IF NOT EXISTS Proveedores (
    RIF varchar(20) NOT NULL,
    Nombre varchar(30) NOT NULL,
    Direccion varchar(40) NOT NULL,
    Telefono_Local varchar(15) NOT NULL,
    Telefono_Movil varchar(15) NOT NULL,
    Nombre_Contacto varchar(30) NOT NULL, 
    Cedula_Contacto dom_cedula,
    Telefono_Contacto varchar(15) NOT NULL,

    PRIMARY KEY (RIF)
);

/*  CRUD Proveedores ------------------------------------------------------------------

--	SELECT * FROM Proveedores
--  Insert INTO Proveedores (RIF, Nombre, Direccion, Telefono_Local, Telefono_Movil, Nombre_Contacto, Cedula_Contacto, Telefono_Contacto) VALUES (?,?,?,?,?,?,?,?);
--  UPDATE Proveedores
    SET Nombre = ???,
        Direccion = ???,
        Telefono_Local = ???,
        Telefono_Movil = ???,
        Nombre_Contacto = ???,
        Cedula_Contacto = ???,
        Telefono_Contacto = ???
    WHERE RIF = ??? (Rif del proveedor a modificar);
--  DROP TABLE Proveedores

--  CRUD Proveedores*/

CREATE TABLE IF NOT EXISTS Proveedor_Producto (
    RIF_Proveedor varchar(20) NOT NULL,
    Cod_Producto dom_codigo,
    Precio integer NOT NULL,

    PRIMARY KEY (RIF_Proveedor, Cod_Producto),
    FOREIGN KEY (RIF_Proveedor)
        REFERENCES Proveedores (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Producto)
        REFERENCES Productos (Cod_Producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Proveedor_Producto ------------------------------------------------------------------

--	SELECT * FROM Proveedor_Producto
--  Insert INTO Proveedor_Producto (RIF_Proveedor, Cod_Prod, Precio) VALUES (?,?,?);
--  UPDATE Proveedor_Producto
    SET Precio = ???
    WHERE RIF_Proveedor = ??? AND Cod_Prod = ???;
--  DROP TABLE Proveedor_Producto

--  Fin CRUD Proveedor_Producto */

CREATE TABLE IF NOT EXISTS Proveedor_Homepet (
    RIF_Proveedor varchar(20) NOT NULL,
    RIF_Homepet varchar(20) NOT NULL,

    PRIMARY KEY (RIF_Proveedor, RIF_Homepet),
    FOREIGN KEY (RIF_Proveedor)
        REFERENCES Proveedores (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Proveedor_Homepet ------------------------------------------------------------------

--	SELECT * FROM Proveedor_Homepet
--  Insert INTO Proveedor_Homepet (RIF_Proveedor, RIF_Homepet) VALUES (?,?);
--  DROP TABLE Proveedor_Homepet

--  Fin CRUD Proveedor_Homepet */

CREATE TABLE IF NOT EXISTS Ordenes_Compra (
    Cod_Orden dom_codigo,
    Fecha_Pedido varchar(15) NOT NULL,

    PRIMARY KEY (Cod_Orden)
);

/*  CRUD Ordenes_Compra ------------------------------------------------------------------

--	SELECT * FROM Ordenes_Compra
--  Insert INTO Ordenes_Compra (Cod_Orden, Fecha_Pedido) VALUES (?,?);
--  UPTADE Ordenes_Compra
    SET Fecha_Orden = ???,
    WHERE Cod_Orden = ???(Codigo de la orden a modificar);
--  DROP TABLE Ordenes_Compra

--  CRUD Ordenes_Compra */

CREATE TABLE IF NOT EXISTS Producto_Orden (
    Cod_Orden dom_codigo,
    Cod_Producto dom_codigo,
    Cantidad_Solicitada integer NOT NULL,

    PRIMARY KEY (Cod_Orden, Cod_Producto),
    FOREIGN KEY (Cod_Orden)
        REFERENCES Ordenes_Compra (Cod_Orden)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Producto)
        REFERENCES Productos (Cod_Producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Producto_Orden ------------------------------------------------------------------

--	SELECT * FROM Producto_Orden
--  Insert INTO Producto_Orden (Cod_Orden, Cod_Producto, Cantidad_Solicitada) VALUES (?,?,?);
--  UPDATE ___________No deberia ser actualizado___________
--  DROP TABLE Producto_Orden

--  Fin CRUD Producto_Orden */

CREATE TABLE IF NOT EXISTS Inventarios (
    RIF_Homepet varchar(20) NOT NULL,
    Cod_Producto dom_codigo NOT NULL,
    Cantidad_Teorica integer NOT NULL,
    Cantidad_Fisica integer NOT NULL,
    Fecha_Inven_Fisico varchar(10) NOT NULL,

    PRIMARY KEY (RIF_Homepet,Cod_Producto),
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY(Cod_Producto)
        REFERENCES Productos(Cod_Producto)
        ON UPDATE  CASCADE
        ON DELETE  RESTRICT
);

/*  CRUD Inventario ------------------------------------------------------------------

--	SELECT * FROM Inventario
--  Insert INTO Inventario (RIF_Homepet, Cod_Producto, Cantidad_Teorica, Cantidad_Fisica, Fecha_Inven_Fisico) VALUES (?,?,?,?,?);
--  UPDATE Inventario
    SET Cantidad_Teorica = ???,
        Cantidad_Fisica = ???,
        Fecha_Inven_Fisico = ???
    WHERE RIF_Homepet = ??? AND Cod_Producto = ???;
--  DROP TABLE Inventario

--  Fin CRUD Inventario */

CREATE TABLE IF NOT EXISTS Ajustes(
    RIF_Homepet varchar(20) NOT NULL,
    Cod_Producto dom_codigo NOT NULL,
    Fecha_Ajuste varchar(10) NOT NULL,
    Dif_Teorica_Fisica integer NOT NULL,
    Tipo_Ajuste char NOT NULL CHECK(Tipo_Ajuste = 'S' or Tipo_Ajuste = 'F'),

    PRIMARY KEY (RIF_Homepet,Cod_Producto),
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Producto)
        REFERENCES Productos (Cod_Producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Ajustes ------------------------------------------------------------------

--	SELECT * FROM Ajustes
--  Insert INTO Ajustes (RIF_Homepet, Cod_Producto, Fecha_Ajuste, Dif_Teorica_Fisica, Tipo_Ajuste) VALUES (?,?,?,?,?);
--  UPDATE Ajustes
    SET Dif_Teorica_Fisica = ???,
        Tipo_Ajuste = ???,
    WHERE RIF_Homepet = ??? AND Cod_Prod = ??? AND Fecha_Ajuste = ???;
--  DROP TABLE Ajustes

--  Fin CRUD Ajustes */

CREATE TABLE IF NOT EXISTS Mascota_Familia (
    Cod_Mascota dom_codigo,
    Cod_Mascota_Familia dom_codigo,
    Tipo_Relacion varchar(15) NOT NULL,

    PRIMARY KEY (Cod_Mascota, Cod_Mascota_Familia),
    FOREIGN KEY (Cod_Mascota)
        REFERENCES Mascotas (Cod_Mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Mascota_Familia)
        REFERENCES Mascotas (Cod_Mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Mascota_Familia ------------------------------------------------------------------

--	SELECT * FROM Mascota_Familia
--  Insert INTO Mascota_Familia (Cod_Mascota, Cod_Mascota_Familia, Tipo_Relacion) VALUES (?,?,?);
--  UPDATE ________________No deberia ser posible (Verificar)__________________
--  DROP TABLE Mascota_Familia

--  Fin CRUD Mascota_Familia */

CREATE TABLE IF NOT EXISTS Vacunas (
		Cod_Vacuna dom_codigo,
		Nombre_Vacuna VARCHAR(20) NOT NULL,
		Descripcion_Vacuna VARCHAR(30) NOT NULL,
		
		PRIMARY KEY (Cod_Vacuna)
);

/*  CRUD Vacunas ------------------------------------------------------------------

--	SELECT * FROM Vacunas
--  Insert INTO Vacunas (Cod_Vacuna, Nombre_Vacuna, Descripcion_Vacuna) VALUES (?,?,?);
--  DROP TABLE Vacunas

--  Fin CRUD Vacunas */

CREATE TABLE IF NOT EXISTS Vacuna_Mascotas(
		Cod_Vacuna dom_codigo,
		Cod_Mascota dom_codigo,
		Cod_Veterinario dom_codigo,
		Fecha_Aplicacion VARCHAR(10) NOT NULL,
		Dosis_cc INTEGER NOT NULL,
		
		PRIMARY KEY (Cod_Mascota, Cod_Vacuna, Cod_Veterinario),
        FOREIGN KEY (Cod_Vacuna)
            REFERENCES Vacunas(Cod_Vacuna)
            ON UPDATE CASCADE
            ON DELETE RESTRICT,
		FOREIGN KEY (Cod_Mascota) 
            REFERENCES Mascotas (Cod_Mascota) 
            ON UPDATE CASCADE 
            ON DELETE RESTRICT,
		FOREIGN KEY (Cod_Veterinario) 
            REFERENCES Veterinarios (Cedula) 
            ON UPDATE CASCADE 
            ON DELETE RESTRICT
);

/*  CRUD Vacuna_Mascotas ------------------------------------------------------------------

--	SELECT * FROM Vacuna_Mascotas
--  Insert INTO Vacuna_Mascotas (Cod_Vacuna, Cod_Mascota, Cod_Veterinario, Fecha_Aplicacion, Dosis_cc) VALUES (?,?,?,?,?);
--  UPDATE Vacuna_Mascotas
    SET Fecha_Aplicacion = ???,
        Dosis_cc = ???
    WHERE Cod_Raza = ??? AND Cod_Prod = ??? AND Cod_Veterinario = ???;
--  DROP TABLE Vacuna_Mascotas

--  Fin CRUD Vacuna_Mascotas */

CREATE TABLE IF NOT EXISTS Vacuna_Homepet (
    RIF_Homepet varchar(20) NOT NULL,
    Cod_Vacuna dom_codigo,
    Cantidad_Minima integer NOT NULL,
    Cantidad_Disponible integer NOT NULL,
    Costo integer NOT NULL,

    PRIMARY KEY (RIF_Homepet, Cod_Vacuna),
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Vacuna)
        REFERENCES Vacunas (Cod_Vacuna)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Vacuna_Homepet ------------------------------------------------------------------

--	SELECT * FROM Vacuna_Homepet
--  Insert INTO Vacuna_Homepet (RIF_Homepet, Cod_Vacuna, Cantidad_Minima, Cantidad_Disponible, Costo) VALUES (?,?,?,?,?);
--  UPDATE Vacuna_Homepet
    SET Cantidad_Minima = ???,
        Cantidad_Disponible = ???,
        Costo = ???
    WHERE RIF_Homepet = ??? AND Cod_Cod_VacunaProd = ??? AND Cod_Veterinario = ???;
--  DROP TABLE Vacuna_Homepet

--  Fin CRUD Vacuna_Homepet */

CREATE TABLE IF NOT EXISTS Servicios_Prestados_X_Personal (
    Cod_Servicio dom_codigo,
    Cedula_Empleado dom_cedula,

    PRIMARY KEY (Cod_Servicio, Cedula_Empleado),
    FOREIGN KEY (Cod_Servicio)
        REFERENCES Servicios (Cod_Servicio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cedula_Empleado)
        REFERENCES Empleados (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Servicios_Prestados_X_Personal ------------------------------------------------------------------

--	SELECT * FROM Servicios_Prestados_X_Personal
--  Insert INTO Servicios_Prestados_X_Personal (Cod_Servicio, Cedula_Empleado) VALUES (?,?);
--  UPDATE ____________NO deberia ser posible______________
--  DROP TABLE Servicios_Prestados_X_Personal

--  Fin CRUD Servicios_Prestados_X_Personal */

CREATE TABLE IF NOT EXISTS Referencia_Comida (
    Cod_Producto dom_codigo,
    Talla varchar (20) NOT NULL,
    Peso integer NOT NULL,
    Porcion integer NOT NULL,

    PRIMARY KEY (Cod_Producto, Talla, Peso),
    FOREIGN KEY (Cod_Producto)
        REFERENCES Productos (Cod_Producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Referencia_Comida ------------------------------------------------------------------

--	SELECT * FROM Referencia_Comida
--  Insert INTO Referencia_Comida (Cod_Producto, Talla, Peso, Porcion) VALUES (?,?,?,?);
--  UPDATE ____________NO deberia ser posible______________
--  DROP TABLE Referencia_Comida

--  Fin CRUD Referencia_Comida */

CREATE TABLE IF NOT EXISTS Referencia_Vacunas (
    Cod_Vacuna dom_codigo,
    Edad integer  NOT NULL,
    Frecuencia integer NOT NULL,

    PRIMARY KEY (Cod_Vacuna, Edad, Frecuencia),
    FOREIGN KEY (Cod_Vacuna)
        REFERENCES Vacunas (Cod_Vacuna)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

--	SELECT * FROM Referencia_Vacunas

--  Insert INTO Referencia_Vacunas (Cod_Vacuna, Edad, Frecuencia, Porcion) VALUES (?,?,?,?);
--  UPDATE ____________NO deberia ser posible______________
--  DROP TABLE Referencia_Vacunas

--  Fin CRUD Referencia_Vacunas */

CREATE TABLE IF NOT EXISTS Proveedor_Factura (
    Cod_Factura dom_codigo,
    RIF_Proveedor varchar(20) NOT NULL,
    Fecha_Pago varchar(10) NOT NULL,

    PRIMARY KEY (Cod_Factura, RIF_Proveedor),
    FOREIGN KEY (Cod_Factura)
        REFERENCES Facturas (Cod_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (RIF_Proveedor)
        REFERENCES Proveedores (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*	SELECT * FROM Proveedor_Factura

--  Insert INTO Proveedor_Factura (Cod_Vacuna, RIF_Proveedor, Fecha_Pago) VALUES (?,?,?);
--  DROP TABLE Proveedor_Factura

--  Fin CRUD Proveedor_Factura */

CREATE TABLE IF NOT EXISTS Orden_De_Uso (
    Cedula_Responsable dom_cedula,
    Cod_Servicio dom_codigo,
    Cod_Actividad integer NOT NULL,
    Cod_Mascota dom_codigo,
    Cod_Producto dom_codigo,
    Fecha_Consumo date NOT NULL,
    Cantidad_Consumida integer NOT NULL,
    Unidad varchar(20) NOT NULL,

    PRIMARY KEY (Cedula_Responsable, Cod_Servicio, Cod_Actividad, Cod_Mascota, Cod_Producto, Fecha_Consumo),
    FOREIGN KEY (Cedula_Responsable)
        REFERENCES Empleados (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Servicio)
        REFERENCES Actividades (Cod_Servicio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Actividad)
        REFERENCES Actividades (Cod_Actividad)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Mascota)
        REFERENCES Mascotas (Cod_Mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Producto)
        REFERENCES Productos (Cod_Producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*	SELECT * FROM Orden_De_Uso

--  Insert INTO Orden_De_Uso (Cedula_Responsable, Cod_Servicio, Cod_Actividad, Cod_Mascota, Cod_Producto, Fecha_Consumo, Cantidad_Consumida, Unidad) VALUES (?,?,?,?,?,?,?,?);
--  DROP TABLE Orden_De_Uso

--  Fin CRUD Orden_De_Uso */

CREATE TABLE IF NOT EXISTS Enfermedades(
	Nombre_Enfermedad VARCHAR(25) NOT NULL,
	Descripcion_Enfermedad VARCHAR(60) NOT NULL,
	Gravedad VARCHAR(30) NOT NULL 
        CHECK (Gravedad = 'Leve' OR Gravedad = 'Media' OR Gravedad = 'Alta'),
	Cura VARCHAR(70),
		
	PRIMARY KEY (Nombre_Enfermedad)
);

/* SELECT * FROM Enfermedades

    INSERT INTO Enfermedades (Nombre_Enfermedad, Descripcion_Enfermedad, Gravedad) VALUES (?,?,?);
    DROP TABLE Enfermedades;

*/

CREATE TABLE IF NOT EXISTS Vacunas_X_Animal (
    Cod_Animal dom_codigo,
    Cod_Vacuna dom_codigo,

    PRIMARY KEY (Cod_Animal, Cod_Vacuna),
    FOREIGN KEY (Cod_Animal)
        REFERENCES Animales (Cod_Animal)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Vacuna)
        REFERENCES Vacunas (Cod_Vacuna)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

    /* SELECT * FROM Vacunas_X_Animal

    INSERT INTO Vacunas_X_Animal (Cod_Animal, Cod_Vacuna) VALUES (?,?);
    DROP TABLE Vacunas_X_Animal;

*/

CREATE TABLE IF NOT EXISTS Animal_Enfermedades (
    Cod_Animal dom_codigo NOT NULL,
    Nombre_Enfermedad varchar(40) NOT NULL,

    PRIMARY KEY (Cod_Animal, Nombre_Enfermedad),
    FOREIGN KEY (Cod_Animal)
        REFERENCES Animales (Cod_Animal)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Nombre_Enfermedad)
        REFERENCES Enfermedades (Nombre_Enfermedad)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Animal_Enfermedades ------------------------------------------------------------------

--	SELECT * FROM Animal_Enfermedades
--  Insert INTO Animal_Enfermedades (Cod_Animal, Nombre_Enfermedad) VALUES (?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Animal Enfermedades;

--  Fin CRUD Mascota_Enfermedades */

CREATE TABLE IF NOT EXISTS Enfermedades_Padecidas_X_Mascota (
    Cod_Mascota dom_codigo,
    Nombre_Enfermedad varchar(40) NOT NULL,

    PRIMARY KEY (Cod_Mascota, Nombre_Enfermedad),
    FOREIGN KEY (Cod_Mascota)
        REFERENCES Mascotas (Cod_Mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Nombre_Enfermedad)
        REFERENCES Enfermedades (Nombre_Enfermedad)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Enfermedades_Padecidas_X_Mascota ------------------------------------------------------------------

--	SELECT * FROM Enfermedades_Padecidas_X_Mascota
--  Insert INTO Enfermedades_Padecidas_X_Mascota (Cod_Mascota, Enfermedades) VALUES (?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Enfermedades_Padecidas_X_Mascota

--  Fin CRUD Enfermedades_Padecidas_X_Mascota */

CREATE TABLE IF NOT EXISTS Duenio_Telefonos (
    Cedula dom_cedula,
    Telefono varchar(15) NOT NULL,

    PRIMARY KEY (Cedula, Telefono),
    FOREIGN KEY (Cedula)
        REFERENCES Duenios (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Duenio_Telefonos ------------------------------------------------------------------

--	SELECT * FROM Duenio_Telefonos
--  Insert INTO Duenio_Telefonos (Cedula, Telefono) VALUES (?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Duenio_Telefonos

--  Fin CRUD Duenio_Telefonos */

CREATE TABLE IF NOT EXISTS Actividades_Reservadas (
    Cod_Reserva dom_codigo,
    Cod_Servicio dom_codigo,
    Cod_Actividad integer NOT NULL,

    PRIMARY KEY (Cod_Reserva, Cod_Servicio, Cod_Actividad),
    FOREIGN KEY (Cod_Reserva) 
        REFERENCES Reservaciones (Cod_Reserva)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Servicio) 
        REFERENCES Actividades (Cod_Servicio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Actividad) 
        REFERENCES Actividades (Cod_Actividad)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Actividades_Reservadas ------------------------------------------------------------------

--	SELECT * FROM Actividades_Reservadas
--  Insert INTO Actividades_Reservadas (Cod_Reserva, Cod_Servicio, Cod_Actividad) VALUES (?,?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Actividades_Reservadas

--  Fin CRUD Actividades_Reservadas */

CREATE TABLE IF NOT EXISTS Actividades_X_Homepet (
    RIF_Homepet varchar(20) NOT NULL,
    Cod_Servicio dom_codigo,
    Cod_Actividad integer NOT NULL,
    Capacidad_Atencion integer NOT NULL,
    Costo integer NOT NULL,

    PRIMARY KEY (RIF_Homepet, Cod_Servicio, Cod_Actividad),
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Servicio)
        REFERENCES Actividades (Cod_Servicio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Actividad) 
        REFERENCES Actividades (Cod_Actividad)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Actividades_X_Homepet ------------------------------------------------------------------

--	SELECT * FROM Actividades_X_Homepet
--  Insert INTO Actividades_X_Homepet (RIF_Homepet, Cod_Servicio, Cod_Actividad, Capacidad_Atencion, Costo) VALUES (?,?,?,?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Actividades_X_Homepet

--  Fin CRUD Actividades_Reservadas */

CREATE TABLE IF NOT EXISTS Reservaciones_Registro (
    Cod_Reserva dom_codigo,
    Cod_Registro dom_codigo,

    PRIMARY KEY (Cod_Reserva, Cod_Registro),
    FOREIGN KEY (Cod_Reserva)
        REFERENCES Reservaciones (Cod_Reserva)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Registro)
        REFERENCES Ficha_Registro (Cod_Registro)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Reservaciones_Registro ------------------------------------------------------------------

--	SELECT * FROM Reservaciones_Registro
--  Insert INTO Reservaciones_Registro (Cod_Reserva, Cod_Registro) VALUES (?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Reservaciones_Registro

--  Fin CRUD Reservaciones_Registro */

CREATE TABLE IF NOT EXISTS Reservacion_Mascota (
    Cod_Reserva dom_codigo,
    Cod_Mascota dom_codigo,

    PRIMARY KEY (Cod_Reserva, Cod_Mascota),
    FOREIGN KEY (Cod_Reserva)
        REFERENCES Reservaciones (Cod_Reserva)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Mascota)
        REFERENCES Mascotas (Cod_Mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Reservacion_Mascota ------------------------------------------------------------------

--	SELECT * FROM Reservacion_Mascota
--  Insert INTO Reservacion_Mascota (Cod_Reserva, Cod_Mascota) VALUES (?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Reservacion_Mascota

--  Fin CRUD Reservacion_Mascota */

CREATE TABLE IF NOT EXISTS Registro_Actividad (
    Cod_Registro dom_codigo,
    Cod_Servicio dom_codigo,
    Cod_Actividad integer NOT NULL,

    PRIMARY KEY (Cod_Registro, Cod_Servicio, Cod_Actividad),
    FOREIGN KEY (Cod_Registro)
        REFERENCES Ficha_Registro (Cod_Registro)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Servicio)
        REFERENCES Actividades (Cod_Servicio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Actividad)
        REFERENCES Actividades (Cod_Actividad)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Registro_Actividad ------------------------------------------------------------------

--	SELECT * FROM Registro_Actividad
--  Insert INTO Registro_Actividad (Cod_Registro, , Cod_Actividad, Mascota) VALUES (?,?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Registro_Actividad

--  Fin CRUD Registro_Actividad */

CREATE TABLE IF NOT EXISTS Factura_Duenio (
    Cod_Factura dom_codigo,
    Cedula_Duenio dom_cedula,

    PRIMARY KEY (Cod_Factura),
    FOREIGN KEY (Cod_Factura)
        REFERENCES Facturas (Cod_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cedula_Duenio)
        REFERENCES Duenios (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Factura_Duenio ------------------------------------------------------------------

--	SELECT * FROM Factura_Duenio
--  Insert INTO Factura_Duenio (Cedula_Duenio, , Cod_Actividad, Cod_Factur) VALUES (?,?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Factura_Duenio

--  Fin CRUD Factura_Duenio */

CREATE TABLE IF NOT EXISTS Factura_Actividad (
    Cod_Factura dom_codigo,
    Cod_Servicio dom_codigo,
    Cod_Actividad integer NOT NULL,

    PRIMARY KEY (Cod_Factura, Cod_Servicio, Cod_Actividad),
    FOREIGN KEY (Cod_Factura)
        REFERENCES Facturas (Cod_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Servicio)
        REFERENCES Actividades (Cod_Servicio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Actividad)
        REFERENCES Actividades (Cod_Actividad)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Factura_Actividad ------------------------------------------------------------------

--	SELECT * FROM Factura_Actividad
--  Insert INTO Factura_Actividad (Cod_Factura, , Cod_Servicio, Cod_Actividad) VALUES (?,?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Factura_Actividad

--  Fin CRUD Factura_Actividad */

CREATE TABLE IF NOT EXISTS Factura_Producto (
    Cod_Factura dom_codigo,
    Cod_Producto dom_codigo,
    Cantidad integer NOT NULL,

    PRIMARY KEY (Cod_Producto, Cod_Factura),
    FOREIGN KEY (Cod_Factura)
        REFERENCES Facturas (Cod_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Producto)
        REFERENCES Productos (Cod_Producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Factura_Producto ------------------------------------------------------------------

--	SELECT * FROM Factura_Producto
--  Insert INTO Factura_Producto (Cod_Factura, , Cod_Producto, Cantidad) VALUES (?,?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Factura_Producto

--  Fin CRUD Factura_Producto */
