--Creación de la Base de Datos:--------------------------------------------------------------------------------------

CREATE DATABASE Homepetdb;
--DROP DATABASE Homepetdb;

--Fin de la Creación de la Base de Datos.----------------------------------------------------------------------------

--Creacion de los Domain---------------------------------------------------------------------------------------------

CREATE DOMAIN dom_codigo AS
    varchar(5) NOT NULL
;
--DROP DOMAIN dom_codigo

CREATE DOMAIN dom_sexo AS
    char (1) NOT NULL
    CHECK (VALUE='F' OR VALUE='M')
;
--DROP DOMAIN dom_sexo

CREATE DOMAIN dom_cedula AS
    varchar (10) NOT NULL
;
--DROP DOMAIN dom_cedula

CREATE DOMAIN dom_nombre_apellido AS
    varchar(40) NOT NULL
;
--DROP DOMAIN dom_nombre_apellido

--Fin de la Creacion de los Domain------------------------------------------------------------------------------------

CREATE TYPE nombre_apellido AS(
    nombre dom_nombre_apellido,
    apellido dom_nombre_apellido
);

--Creacion de las Tablas----------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Usuarios (
		Cod_User dom_codigo NOT NULL,
		Alias_Usuario varchar(20) NOT NULL,
		Nombre nombre_apellido NOT NULL,
		Contrasenia dom_codigo NOT NULL,
		Tipo_Usuario VARCHAR(15) NOT NULL 
            CHECK(Tipo_Usuario = 'Encargado' OR Tipo_Usuario = 'Empleado' OR Tipo_Usuario = 'Administrador'),
		
		PRIMARY KEY (Cod_User)
);

/*CRUD Tabla Usuarios

--	SELECT * FROM Usuarios
--	INSERT INTO Usuarios (cod_user, alias_usuario, nombre, contrasenia, tipo_usuario) VALUES (?,?,?,?,?);
--  UPDATE Usuarios
    SET Alias_Usuario = ???,
        Nombre = ???,
        Contrasenia = ???,
        Tipo_Usuario = ???
    WHERE Cod_User = ??? (Codigo del Usuario a modificar);
--	DROP TABLE Usuarios

--Fin CRUD Tabla Usuarios*/

CREATE TABLE Animales (
    Cod_Animal dom_codigo,
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

CREATE TABLE Veterinarios (
    Cedula dom_cedula,
    Nombre nombre_apellido,
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

CREATE TABLE Razas (
    Cod_Raza dom_codigo,
    Nombre varchar(30) NOT NULL,
    Pais_Origen varchar(15) NOT NULL,
    Descripcion varchar (60) NOT NULL,
    Talla varchar(15) NOT NULL
        CHECK (Talla='Pequeña' OR Talla='Mediana' OR Talla='Grande'),
    Cntxt_Frt varchar(2) NOT NULL
        CHECK (Cntxt_Frt='Si' OR Cntxt_Frt='No' OR Cntxt_Frt='S' OR Cntxt_Frt='N'),
    Nivel_Int varchar(10) NOT NULL
        CHECK (Nivel_Int='Bajo' OR Nivel_Int='Medio' OR Nivel_Int='Alto'),
    Color_Plj varchar(10) NOT NULL,
    Altura_Min integer NOT NULL
        CHECK (Altura_Min < Altura_Max),
    Altura_Max integer NOT NULL
        CHECK (Altura_Max > Altura_Min),

    PRIMARY KEY (Cod_Raza)
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

CREATE TABLE Raza_Animal (
    Cod_Raza dom_codigo UNIQUE,
    Cod_Animal dom_codigo UNIQUE,

    PRIMARY KEY (Cod_Raza, Cod_Animal),
    FOREIGN KEY (Cod_Raza)
        REFERENCES Razas (Cod_Raza)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Animal)
        REFERENCES Animales (Cod_Animal)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*CRUD Tabla Raza_Animal

--	SELECT * FROM Raza_Animal
--	SELECT Nombre AS Raza, Descripcion AS Animal FROM Raza_Animal, Razas, Animales WHERE Cod_raza.Raza_Animal = Cod_raza.Razas AND Cod_Animal.Raza_Animal = Cod_Animal.Animales
--	INSERT INTO Raza_Animal (cod_animal, cod_animal) VALUES (?,?);
--  UPDATE _________No deberia ser capaz de actualizarse debido a que los atributos son parte de la PK_____________
--	DROP TABLE Raza_Animal

--Fin CRUD Tabla Raza_Animal*/

CREATE TABLE Homepets (
    RIF varchar (20) NOT NULL,
    Nombre varchar(20) NOT NULL,
    Ciudad varchar(15) NOT NULL,
    Sector varchar(15) NOT NULL,
    Cod_Animal dom_codigo,

    PRIMARY KEY (RIF),
    CONSTRAINT un_Homepets UNIQUE (Ciudad, Sector),
    FOREIGN KEY (Cod_Animal) REFERENCES Animales(Cod_Animal) ON UPDATE CASCADE ON DELETE RESTRICT
);

/*CRUD Tabla Homepets

--	SELECT * FROM Homepets
--	INSERT INTO Homepets (RIF, Nombre, Ciudad, Sector, Cod_Animal) VALUES (?,?,?,?,?);
--  UPDATE Homepets
    SET Nombre = ???,
        Ciudad = ???,
        Sector = ???,
        Cod_Animal = ???
    WHERE RIF = ???(RIF del homepet);
--	DROP TABLE Homepets

--Fin CRUD Tabla Homepets*/

CREATE TABLE Productos (
    Cod_Prod dom_codigo,
    Nombre varchar(30) NOT NULL,
    Descripcion varchar(40) NOT NULL,
    Costo varchar(15) NOT NULL,
    Cantidad_Minima integer NOT NULL,
	Cantidad_Disponible integer NOT NULL,
    Tipo varchar(10) NOT NULL,
    RIF_Homepet varchar(20) NOT NULL,

    PRIMARY KEY (Cod_Prod),
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*CRUD Tabla Productos

--	SELECT * FROM Productos
--	INSERT INTO Productos (Cod_Prod, Nombre, Descripcion, Costo, Cantidad_Minima, Cantidad_Disponible, Tipo, RIF_Homepet) VALUES (?,?,?,?,?,?,?,?);
--  UPDATE Productos
    SET Nombre = ???,
        Descripcion = ???,
        Costo = ???,
        Cantidad_Minima = ???,
        Cantidad_Disponible = ???,
        Tipo = ???,
        RIF_Homepet = ???
    WHERE Cod_Prod = ???(El codigo del producto a modificar);
--	DROP TABLE Productos

--Fin CRUD Tabla Productos*/

CREATE TABLE Servicios (
    Cod_Srvc dom_codigo,
    Nombre varchar(15) NOT NULL,
    Descripcion varchar(60) NOT NULL,

    PRIMARY KEY (Cod_Srvc)
);

/*CRUD Tabla Servicios

--	SELECT * FROM Servicios
--	INSERT INTO Servicios (Cod_Srvc, Nombre, Descripcion) VALUES (?,?,?);
--  UPDATE Servicios
    SET Nombre = ???,
        Descripcion = ???
    WHERE Cod_Srvc = ???(Codigo del servicio a modificar);
--	DROP TABLE Servicios

--Fin CRUD Tabla Servicios*/

CREATE TABLE Duenios (
    Cedula dom_cedula,
    Nombre_Completo nombre_apellido,
    Email varchar(40),

    PRIMARY KEY (Cedula)
);

/*CRUD Tabla Duenios

--	SELECT * FROM Duenios
--	INSERT INTO Duenios (cod_animal, Descripcion) VALUES (?,?);
--  UPDATE Duenios
    SET Nombre_Completo = ???,
        Email = ???
    WHERE Cedula = ??? (Cedula del dueño a modificar);
--	DROP TABLE Duenios

--Fin CRUD Tabla Duenios*/

CREATE TABLE Mascotas (
    Cod_Mascota dom_codigo,
    Nombre varchar(30) NOT NULL,
    Fecha_Nac date NOT NULL,
    Tipo_Animal varchar(10) NOT NULL,
    Sexo dom_sexo,
    Cedula_Dueño dom_cedula,
    Cod_Raza dom_codigo,
    Cod_Animal dom_codigo,
    Cod_Prod dom_codigo,
    RIF_Homepet varchar(20) NOT NULL,
    Cedula_Vet dom_cedula,
    
    PRIMARY KEY(Cod_Mascota),
    FOREIGN KEY (Cedula_Dueño) REFERENCES Duenios(Cedula) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(Cod_Raza) REFERENCES Raza_Animal(Cod_Raza) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Animal) REFERENCES Raza_Animal(Cod_Animal) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Prod) REFERENCES Productos(Cod_Prod) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (RIF_Homepet) REFERENCES Homepets(RIF) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (Cedula_Vet) REFERENCES Veterinarios(Cedula) ON UPDATE CASCADE ON DELETE RESTRICT
);

/*CRUD Tabla Mascotas

--	SELECT * FROM Mascotas
--	INSERT INTO Mascotas (Cod_Mascota, Nombre, Fecha_Nac, Tipo_Animal, Sexo, Cedula_Dueño, Cod_Raza, Cod_Animal, Cod_Prod, RIF_Homepet, Cedula_Vet) VALUES (?,?,?,?,?,?,?,?,?,?,?);
--  UPDATE Mascotas
    SET Nombre = ???,
        Fecha_Nac = ???,
        Tipo_Animal = ???,
        Sexo = ???,
        Cedula_Dueño = ???,
        Cod_Raza = ???,
        Cod_Animal = ???,
        Cod_Prod = ???,
        RIF_Homepet = ???,
        Cedula_Vet = ???
    WHERE Cod_Mascota = ???(Codigo de la mascota a modificar);
--	DROP TABLE Mascotas

--Fin CRUD Tabla Mascotas*/

CREATE TABLE Cantidad_Suministrar_Producto_Mascota(
    Cod_Prod varchar (5) NOT NULL,
    Cantidad_Smnt integer NOT NULL
        CHECK (Cantidad_Smnt > '0'),
    
    PRIMARY KEY (Cod_Prod)
);

/*CRUD Tabla Cantidad_Suministrar_Producto_Mascota

--	SELECT * FROM Cantidad_Suministrar_Producto_Mascota
--	INSERT INTO Cantidad_Suministrar_Producto_Mascota (Cod_Prod, Cantidad_Smnt) VALUES (?,?);
--  UPDATE Cantidad_Suministrar_Producto_Mascota
    SET Cantidad_Smnt = ???
    WHERE Cod_Prod = ??? (Codigo del producto a suministrar a una mascota);
--	DROP TABLE Cantidad_Suministrar_Producto_Mascota

--Fin CRUD Tabla Animales*/



CREATE TABLE Registros (
    Cod_Registro dom_codigo,
    Fecha_E date NOT NULL,
    Hora_E time NOT NULL,
    Fecha_SEst date NOT NULL,
    Hora_SEst time NOT NULL,
    Fecha_SReal date NOT NULL,
    Hora_SReal time NOT NULL,

    PRIMARY KEY (Cod_Registro)
);

/*CRUD Tabla Registros

--	SELECT * FROM Registros
--	INSERT INTO Registros (Cod_Registro, Fecha_E, Hora_E, Fecha_SEst, Hora_SEst, Fecha_SReal, Hora_SReal) VALUES (?,?,?,?,?,?,?);
--  UPDATE Registros
    SET Fecha_E = ???,
        Hora_E = ???,
        Fecha_SEst = ???,
        Hora_SEst = ???,
        Fecha_SReal = ???,
        Hora_SReal = ???
    WHERE Cod_Registro = ??? (Codigo del registro a modificar);
--	DROP TABLE Registros

--Fin CRUD Tabla Animales*/

CREATE TABLE Modalidades (
    Cod_Mod dom_codigo,
    Fecha date NOT NULL,
    Monto integer NOT NULL,
    Tipo_M varchar(10) NOT NULL,
    Numero varchar(20) NOT NULL,

    PRIMARY KEY (Cod_Mod)
);

/*CRUD Tabla Modalidades

--	SELECT * FROM Modalidades
--	INSERT INTO Modalidades (Cod_Mod, Fecha, Monto, Tipo_M, Numero) VALUES (?,?,?,?,?);
--  UPDATE Modalidades
    SET Fecha = ???,
        Monto = ???,
        Tipo_M = ???,
        Numero = ???
    WHERE Cod_Mod = ???(Codigo de la modalidad a modificar);
--	DROP TABLE Modalidades

--Fin CRUD Tabla Modalidades*/

CREATE TABLE Reservas (
    Cod_Reserva dom_codigo,
    Fecha_Resrv date NOT NULL,
    Fecha_Act_R date NOT NULL,
    Monto_Abonado integer NOT NULL,
    Monto_Total integer NOT NULL,
    Porc_Dscnt integer NULL,

    PRIMARY KEY(Cod_Reserva)
);

/*CRUD Tabla Reservas

--	SELECT * FROM Reservas
--	INSERT INTO Reservas (Cod_Reserva, Fecha_Resrv, Fecha_Act_R, Monto_Abonado, Monto_Total, Porc_Dscnt) VALUES (?,?);
--  UPDATE Reservas
    SET Fecha_Resrv = ???,
        Fecha_Act_R = ???,
        Monto_Abonado = ???,
        Monto_Total = ???,
        Porc_Dscnt = ???
    WHERE Cod_Reserva = ???(Codigo de la reserva a modificar);
--	DROP TABLE Reservas

--Fin CRUD Tabla Reservas*/

CREATE TABLE Actividades (
    Cod_Actividad dom_codigo,
    Cod_Srvc dom_codigo,
    Descripcion varchar(50) NOT NULL,
    Capacidad_Atncn integer
        CHECK (Capacidad_Atncn > '0'),

    PRIMARY KEY (Cod_Actividad),
    FOREIGN KEY (Cod_Srvc)
        REFERENCES Servicios (Cod_Srvc)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*CRUD Tabla Actividades

--	SELECT * FROM Actividades
--	INSERT INTO Actividades (Cod_Actividad, Cod_Srvc, Descripcion, Capacidad_Atncn) VALUES (?,?,?,?);
--  UPDATE Actividades
    SET Cod_Servc = ???,
        Descripcion = ???,
        Capacidad_Atncn = ???
    WHERE Cod_Actividad = ???(Codigo de la actividad a modificar);
--	DROP TABLE Actividades

--Fin CRUD Tabla Actividades*/

CREATE TABLE Empleados (
    Cedula dom_cedula,
    Nombre_Completo nombre_apellido,
    Sueldo integer NOT NULL
        CHECK (Sueldo >= '0'),
    Direccion varchar(50) NOT NULL,
    Tipo varchar(10) NOT NULL,
    Fecha_Inicio date NOT NULL,
    RIF_Homepet varchar(20) NOT NULL,

    PRIMARY KEY (Cedula),
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*CRUD Tabla Empleados

--	SELECT * FROM Empleados
--	INSERT INTO Empleados (Cedula, Nombre_Completo, Sueldo, Direccion, Tipo, Fecha_Inicio, RIF_Homepet) VALUES (?,?,?,?,?,?,?);
--  UPDATE Empleados
    SET Nombre_Completo = ???,
        Sueldo = ???,
        Direccion = ???,
        Tipo = ???,
        Fecha_Inicio = ???,
        RIF_Homepet = ???
    WHERE Cedula = ??? (Cedula del empleado a modificar);

--	DROP TABLE Empleados

--Fin CRUD Tabla Animales*/

CREATE TABLE Facturas (
    Cod_Factura dom_codigo,
    Fecha_F date NOT NULL,
    Monto_Total varchar(15) NOT NULL,
    Tipo varchar(10) NOT NULL,

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

CREATE TABLE Proveedores (
    RIF varchar(20) NOT NULL,
    Nombre varchar(30) NOT NULL,
    Direccion varchar(40) NOT NULL,
    Telefono_Local varchar(15) NOT NULL,
    Telefono_Movil varchar(15) NOT NULL,
    Nombre_Pers_C varchar(30) NOT NULL, 
    Cedula_PC dom_cedula,
    Numero_Tlf_PC varchar(15) NOT NULL,

    PRIMARY KEY (RIF)
);

/*  CRUD Proveedores ------------------------------------------------------------------

--	SELECT * FROM Proveedores
--  Insert INTO Proveedores (RIF, Nombre, Direccion, Telefono_Local, Telefono_Movil, Nombre_Pers_C, Cedula_PC, Numero_Tlf_PC) VALUES (?,?,?,?,?,?,?,?);
--  UPDATE Proveedores
    SET Nombre = ???,
        Direccion = ???,
        Telefono_Local = ???,
        Telefono_Movil = ???,
        Nombre_Pers_C = ???,
        Cedula_PC = ???,
        Numero_Tlf_PC = ???
    WHERE RIF = ??? (Rif del proveedor a modificar);
--  DROP TABLE Proveedores

--  CRUD Proveedores*/

CREATE TABLE Ordenes_X_Compra (
    Cod_Orden dom_codigo,
    Fecha_Orden varchar(15) NOT NULL,
    Cantidad_Pedida varchar(15) NOT NULL,

    PRIMARY KEY (Cod_Orden)
);

/*  CRUD Ordenes_X_Compra ------------------------------------------------------------------

--	SELECT * FROM Ordenes_X_Compra
--  Insert INTO Ordenes_X_Compra (Cod_Orden, Fecha_Orden, Cantidad_Pedida) VALUES (?,?,?);
--  UPTADE Ordenes_X_Compra
    SET Fecha_Orden = ???,
        Cantidad_Pedida = ???
    WHERE Cod_Orden = ???(Codigo de la orden a modificar);
--  DROP TABLE Ordenes_X_Compra

--  CRUD Ordenes_X_Compra */

CREATE TABLE Inventario (
    RIF_Homepet varchar(20) NOT NULL,
    Cod_Producto dom_codigo NOT NULL,
    Cantidad_Teorica integer NOT NULL,
    Cantidad_Fisica integer NOT NULL,
    Fecha_Inven_Fisico date NOT NULL,

    PRIMARY KEY (RIF_Homepet,Cod_Producto),
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY(Cod_Producto)
        REFERENCES Productos(Cod_Prod)
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

CREATE TABLE Ajustes(
    RIF_Homepet varchar(20) NOT NULL,
    Cod_Prod dom_codigo NOT NULL,
    Fecha_Ajuste date NOT NULL,
    Dif_Teorica_Fisica integer NOT NULL,
    Tipo_Ajuste char NOT NULL CHECK(Tipo_Ajuste = 'S' or Tipo_Ajuste = 'F'),

    PRIMARY KEY (RIF_Homepet,Cod_Prod,Fecha_Ajuste),
    FOREIGN KEY (RIF_Homepet,Cod_Prod)
        REFERENCES Inventario(RIF_Homepet, Cod_Producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Ajustes ------------------------------------------------------------------

--	SELECT * FROM Ajustes
--  Insert INTO Ajustes (RIF_Homepet, Cod_Prod, Fecha_Ajuste, Dif_Teorica_Fisica, Tipo_Ajuste) VALUES (?,?,?,?,?);
--  UPDATE Ajustes
    SET Dif_Teorica_Fisica = ???,
        Tipo_Ajuste = ???,
    WHERE RIF_Homepet = ??? AND Cod_Prod = ??? AND Fecha_Ajuste = ???;
--  DROP TABLE Ajustes

--  Fin CRUD Ajustes */

CREATE TABLE Se_Relacionan (
    Cod_Mascota dom_codigo,
    Cod_Mascota_Familia dom_codigo,

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

/*  CRUD Se_Relacionan ------------------------------------------------------------------

--	SELECT * FROM Se_Relacionan
--  Insert INTO Se_Relacionan (Cod_Mascota, Cod_Mascota_Familia) VALUES (?,?);
--  UPDATE ________________No deberia ser posible (Verificar)__________________
--  DROP TABLE Se_Relacionan

--  Fin CRUD Se_Relacionan */

CREATE TABLE Se_Especializan (
    Cod_Animal dom_codigo,
    RIF_Homepet varchar(20) NOT NULL,

    PRIMARY KEY (Cod_Animal, RIF_Homepet),
    FOREIGN KEY (Cod_Animal)
        REFERENCES Animales (Cod_Animal)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Se_Especializan ------------------------------------------------------------------

--	SELECT * FROM Se_Especializan
--  Insert INTO Se_Especializan (Cod_Animal, RIF_Homepet) VALUES (?,?);
--  UPDATE ______________No deberia ser posible (Verificar)__________________
--  DROP TABLE Se_Especializan

--  Fin CRUD Se_Especializan */

CREATE TABLE Vacuna_Aplica_Raza (
    Cod_Raza dom_codigo,
    Cod_Prod dom_codigo,
    Edad integer NOT NULL
        CHECK (Edad > '0'),
    Dosis_cc integer NOT NULL
        CHECK (Dosis_cc > '0'),

    PRIMARY KEY (Cod_Raza, Cod_Prod),
    FOREIGN KEY (Cod_Raza)
        REFERENCES Razas (Cod_Raza)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Prod)
        REFERENCES Productos (Cod_Prod)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Vacuna_Aplica_Raza ------------------------------------------------------------------

--	SELECT * FROM Vacuna_Aplica_Raza
--  Insert INTO Vacuna_Aplica_Raza (Cod_Raza, Cod_Prod, Edad, Dosis_cc) VALUES (?,?,?,?);
--  UPDATE Vacuna_Aplica_Raza
    SET Edad = ???,
        Dosis_cc = ???
    WHERE Cod_Raza = ??? AND Cod_Prod = ???;
--  DROP TABLE Vacuna_Aplica_Raza

--  Fin CRUD Vacuna_Aplica_Raza */

CREATE TABLE Homepet_Servicio (
    RIF varchar(20) NOT NULL,
    Cod_Srvc dom_codigo,

    PRIMARY KEY (RIF, Cod_Srvc),
    FOREIGN KEY (RIF)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Srvc)
        REFERENCES Servicios (Cod_Srvc)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Homepet_Servicio ------------------------------------------------------------------

--	SELECT * FROM Homepet_Servicio
--  Insert INTO Homepet_Servicio (RIF, Cod_Srvc) VALUES (?,?);
--  UPDATE ___________No deberia ser posible___________
--  DROP TABLE Homepet_Servicio

--  Fin CRUD Homepet_Servicio */

CREATE TABLE Visitas (
    Cedula dom_cedula,
    RIF_Homepet varchar(20) NOT NULL,

    PRIMARY KEY (Cedula, RIF_Homepet),
    FOREIGN KEY (Cedula)
        REFERENCES Duenios (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Visitas ------------------------------------------------------------------

--	SELECT * FROM Visitas
--  Insert INTO Visitas (Cedula, RIF_Homepet) VALUES (?,?);
--  UPDATE ____________NO deberia ser posible______________
--  DROP TABLE Visitas

--  Fin CRUD Visitas */

CREATE TABLE Personal_Ofrece_Servicio (
    Cod_Srvc dom_codigo,
    Cedula_Empleado dom_cedula,

    PRIMARY KEY (Cod_Srvc, Cedula_Empleado),
    FOREIGN KEY (Cod_Srvc)
        REFERENCES Servicios (Cod_Srvc)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cedula_Empleado)
        REFERENCES Empleados (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Personal_Ofrece_Servicio ------------------------------------------------------------------

--	SELECT * FROM Personal_Ofrece_Servicio
--  Insert INTO Personal_Ofrece_Servicio (Cod_Srvc, Cedula_Empleado) VALUES (?,?);
--  UPDATE ____________NO deberia ser posible______________
--  DROP TABLE Personal_Ofrece_Servicio

--  Fin CRUD Personal_Ofrece_Servicio */

CREATE TABLE Homepet_Vende_Producto (
    Cod_Prod varchar (5) NOT NULL,
    RIF varchar (20) NOT NULL,

    PRIMARY KEY (Cod_Prod, RIF),
    FOREIGN KEY (Cod_Prod)
        REFERENCES Productos (Cod_Prod)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (RIF)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Homepet_Vende_Producto ------------------------------------------------------------------

--	SELECT * FROM Homepet_Vende_Producto
--  Insert INTO Homepet_Vende_Producto (Cod_Prod, RIF) VALUES (?,?);
--  UPDATE ____________NO deberia ser posible______________
--  DROP TABLE Homepet_Vende_Producto

--  Fin CRUD Homepet_Vende_Producto */

CREATE TABLE Cantidad_A_Suministrar_Animal_Producto (
    Cod_Prod dom_codigo,
    Cod_Animal dom_codigo,
    Porcion varchar(15) NOT NULL
        CHECK (Porcion > '0'),

    PRIMARY KEY (Cod_Prod, Cod_Animal),
    FOREIGN KEY (Cod_Prod)
        REFERENCES Productos (Cod_Prod)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Animal)
        REFERENCES Animales (Cod_Animal)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Cantidad_A_Suministrar_Animal_Producto ------------------------------------------------------------------

--	SELECT * FROM Cantidad_A_Suministrar_Animal_Producto
--  Insert INTO Cantidad_A_Suministrar_Animal_Producto (Cod_Prod, Cod_Animal, Porcion) VALUES (?,?,?);
--  UPDATE Cantidad_A_Suministrar_Animal_Producto
    SET Porcion = ???
    WHERE Cod_Prod = ??? AND Cod_Animal = ???;
--  DROP TABLE Cantidad_A_Suministrar_Animal_Producto

--  Fin CRUD Cantidad_A_Suministrar_Animal_Producto */

CREATE TABLE Detalles_Animal_Para_Suministrar (
    Cod_Animal dom_codigo,
    Tamanio integer NOT NULL
        CHECK (Tamanio > '0'),
    Edad integer NOT NULL
        CHECK (Edad > '0'),
    Peso integer NOT NULL
        CHECK (Peso > '0'),

    PRIMARY KEY (Cod_Animal),
    FOREIGN KEY (Cod_Animal)
        REFERENCES Animales (Cod_Animal)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Detalles_Animal_Para_Suministrar ------------------------------------------------------------------

--	SELECT * FROM Detalles_Animal_Para_Suministrar
--  Insert INTO Detalles_Animal_Para_Suministrar (Cod_Animal, Tamaño, Edad, Peso) VALUES (?,?,?,?);
--  UPDATE Detalles_Animal_Para_Suministrar
    SET Tamanio = ???,
        Edad = ???,
        Peso = ???
    WHERE Cod_Animal = ??? (Codigo del animal a modificar);
--  DROP TABLE Detalles_Animal_Para_Suministrar

--  Fin CRUD Detalles_Animal_Para_Suministrar */

CREATE TABLE Proveedor_Distribuye_Producto (
    RIF_Proveedor varchar(20) NOT NULL,
    Cod_Prod dom_codigo,
    Precio integer NOT NULL
        CHECK (Precio > '0'),

    PRIMARY KEY (RIF_Proveedor, Cod_Prod),
    FOREIGN KEY (RIF_Proveedor)
        REFERENCES Proveedores (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Prod)
        REFERENCES Productos (Cod_Prod)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Proveedor_Distribuye_Producto ------------------------------------------------------------------

--	SELECT * FROM Proveedor_Distribuye_Producto
--  Insert INTO Proveedor_Distribuye_Producto (RIF_Proveedor, Cod_Prod, Precio) VALUES (?,?,?);
--  UPDATE Proveedor_Distribuye_Producto
    SET Precio = ???
    WHERE RIF_Proveedor = ??? AND Cod_Prod = ???;
--  DROP TABLE Proveedor_Distribuye_Producto

--  Fin CRUD Proveedor_Distribuye_Producto */

CREATE TABLE Orden_Remite_Producto (
    Cod_Orden dom_codigo,
    Cod_Prod dom_codigo,

    PRIMARY KEY (Cod_Orden, Cod_Prod),
    FOREIGN KEY (Cod_Orden)
        REFERENCES Ordenes_X_Compra (Cod_Orden)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Prod)
        REFERENCES Productos (Cod_Prod)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Orden_Remite_Producto ------------------------------------------------------------------

--	SELECT * FROM Orden_Remite_Producto
--  Insert INTO Orden_Remite_Producto (Cod_Orden, Cod_Prod) VALUES (?,?);
--  UPDATE ___________No deberia ser actualizado___________
--  DROP TABLE Orden_Remite_Producto

--  Fin CRUD Orden_Remite_Producto */

CREATE TABLE Registra_Mascota (
    Cod_Mascota dom_codigo,
    Cod_Registro dom_codigo,

    PRIMARY KEY (Cod_Mascota, Cod_Registro),
    FOREIGN KEY (Cod_Mascota)
        REFERENCES Mascotas (Cod_Mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Registro)
        REFERENCES Registros (Cod_Registro)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

--  CRUD Registra_Mascota ------------------------------------------------------------------

--	SELECT * FROM Registra_Mascota
--  Insert INTO Registra_Mascota (Cod_Mascota, Cod_Registro) VALUES (?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Registra_Mascota

--  Fin CRUD Registra_Mascota ------------------------------------------------------------------

CREATE TABLE Factura_Genera_Servicio_Pagado_X_D (
    Cod_Factura dom_codigo,
    Cod_Srvc dom_codigo,
    Cedula_Duenio dom_cedula,

    PRIMARY KEY (Cod_Factura, Cod_Srvc, Cedula_Duenio),
    FOREIGN KEY (Cod_Factura)
        REFERENCES Facturas (Cod_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Srvc)
        REFERENCES Servicios (Cod_Srvc)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cedula_Duenio)
        REFERENCES Duenios (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Factura_Genera_Servicio_Pagado_X_D ------------------------------------------------------------------

--	SELECT * FROM Factura_Genera_Servicio_Pagado_X_D
--  Insert INTO Factura_Genera_Servicio_Pagado_X_D (Cod_Factura, Cod_Srvc, Cedula_Dueño) VALUES (?,?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Factura_Genera_Servicio_Pagado_X_D

--  Fin CRUD Factura_Genera_Servicio_Pagado_X_D */

CREATE TABLE Registra_Servicio (
    Cod_Registro dom_codigo,
    Cod_Srvc dom_codigo,
    Cod_Actividad dom_codigo,

    PRIMARY KEY (Cod_Registro, Cod_Srvc, Cod_Actividad),
    FOREIGN KEY (Cod_Registro)
        REFERENCES Registros (Cod_Registro)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Srvc)
        REFERENCES Servicios (Cod_Srvc)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Actividad)
        REFERENCES Actividades (Cod_Actividad)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Registra_Servicio ------------------------------------------------------------------

--	SELECT * FROM Registra_Servicio
--  Insert INTO Registra_Servicio (Cod_Registro, Cod_Srvc, Cod_Actividad) VALUES (?,?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Registra_Servicio

--  Fin CRUD Registra_Servicio */

CREATE TABLE Duenio_Paga_Factura (
    Cedula dom_cedula,
    Cod_Prod dom_codigo,
    Cod_Factura dom_codigo,
    Cod_Mod dom_codigo,

    PRIMARY KEY (Cedula, Cod_Prod, Cod_Factura, Cod_Mod),
    FOREIGN KEY (Cedula)
        REFERENCES Duenios (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Prod)
        REFERENCES Productos (Cod_Prod)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Factura)
        REFERENCES Facturas (Cod_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Mod)
        REFERENCES Modalidades (Cod_Mod)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Dueño_Paga_Factura ------------------------------------------------------------------

--	SELECT * FROM Dueño_Paga_Factura
--  Insert INTO Dueño_Paga_Factura (Cedula, Cod_Prod, Cod_Factura, Cod_Mod) VALUES (?,?,?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Dueño_Paga_Factura

--  Fin CRUD Dueño_Paga_Factura */

CREATE TABLE Proveedor_Cobra_Factura (
    Cod_Factura dom_codigo,
    RIF_Proveedor varchar(20) NOT NULL,
    Cod_Prod dom_codigo,
    Fecha_Pago date NOT NULL,

    PRIMARY KEY (Cod_Factura, RIF_Proveedor, Cod_Prod),
    FOREIGN KEY (Cod_Factura)
        REFERENCES Facturas (Cod_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (RIF_Proveedor)
        REFERENCES Proveedores (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Prod)
        REFERENCES Productos (Cod_Prod)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Proveedor_Cobra_Factura ------------------------------------------------------------------

--	SELECT * FROM Proveedor_Cobra_Factura
--  Insert INTO Proveedor_Cobra_Factura (Cod_Factura, RIF_Proveedor, Cod_Prod, Fecha_Pago) VALUES (?,?,?,?);
--  UPDATE Proveedor_Cobra_Factura
    SET Fecha_Pago = ???
    WHERE Cod_Factura = ??? AND RIF_Proveedor = ??? AND Cod_Prod = ???;
--  DROP TABLE Proveedor_Cobra_Factura

--  Fin CRUD Proveedor_Cobra_Factura */

CREATE TABLE Cantidad_Entregada_Producto_Factura (
    Cod_Factura dom_codigo,
    Cod_Prod dom_codigo,
    Cantidad_Entg integer NOT NULL
        CHECK (Cantidad_Entg > '0'),
    
    PRIMARY KEY (Cod_Factura, Cod_Prod),
    FOREIGN KEY (Cod_Factura)
        REFERENCES Facturas (Cod_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Prod)
        REFERENCES Productos (Cod_Prod)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Cantidad_Entregada_Producto_Factura ------------------------------------------------------------------

--	SELECT * FROM Cantidad_Entregada_Producto_Factura
--  Insert INTO Cantidad_Entregada_Producto_Factura (Cod_Factura, Cod_Prod, Cantidad_Entg) VALUES (?,?,?);
--  UPDATE Cantidad_Entregada_Producto_Factura
    SET Cantidad_Entg = ???
    WHERE Cod_Factura = ??? AND Cod_Prod = ???;
--  DROP TABLE Cantidad_Entregada_Producto_Factura

--  Fin CRUD Cantidad_Entregada_Producto_Factura */

CREATE TABLE Personal_Consume_Producto_Para_Mascota (
    Cod_Srvc dom_codigo,
    Cod_Mascota dom_codigo,
    Cod_Prod dom_codigo,
    Cedula_Empleado dom_cedula,

    PRIMARY KEY (Cod_Srvc, Cod_Mascota, Cod_Prod, Cedula_Empleado),
    FOREIGN KEY (Cod_Srvc)
        REFERENCES Servicios (Cod_Srvc)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Mascota)
        REFERENCES Mascotas (Cod_Mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Prod)
        REFERENCES Productos (Cod_Prod)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cedula_Empleado)
        REFERENCES Empleados (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Personal_Consume_Producto_Para_Mascota ------------------------------------------------------------------

--	SELECT * FROM Personal_Consume_Producto_Para_Mascota
--  Insert INTO Personal_Consume_Producto_Para_Mascota (Cod_Srvc, Cod_Mascota, Cod_Prod, Cedula_Empleado) VALUES (?,?,?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Personal_Consume_Producto_Para_Mascota

--  Fin CRUD Personal_Consume_Producto_Para_Mascota */

CREATE TABLE Mascota_Reserva_Actividad (
    Cod_Actividad dom_codigo,
    Cod_Srvc dom_codigo,
    Cod_Reserva dom_codigo,
    Cod_Mascota dom_codigo,

    PRIMARY KEY (Cod_Actividad, Cod_Srvc, Cod_Reserva, Cod_Mascota),
    FOREIGN KEY (Cod_Actividad)
        REFERENCES Actividades (Cod_Actividad)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Srvc)
        REFERENCES Servicios (Cod_Srvc)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Reserva)
        REFERENCES Reservas (Cod_Reserva)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Mascota)
        REFERENCES Mascotas (Cod_Mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

--  CRUD Mascota_Reserva_Actividad ------------------------------------------------------------------

--	SELECT * FROM Mascota_Reserva_Actividad
--  Insert INTO Mascota_Reserva_Actividad (Cod_Actividad, Cod_Srvc, Cod_Reserva, Cod_Mascota) VALUES (?,?,?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Mascota_Reserva_Actividad

--  Fin CRUD Mascota_Reserva_Actividad ------------------------------------------------------------------

CREATE TABLE Mascota_Enfermedades (
    Cod_Mascota dom_codigo,
    Enfermedades varchar(40) NOT NULL,

    PRIMARY KEY (Cod_Mascota, Enfermedades),
    FOREIGN KEY (Cod_Mascota)
        REFERENCES Mascotas (Cod_Mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Mascota_Enfermedades ------------------------------------------------------------------

--	SELECT * FROM Mascota_Enfermedades
--  Insert INTO Mascota_Enfermedades (Cod_Mascota, Enfermedades) VALUES (?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Mascota_Enfermedades

--  Fin CRUD Mascota_Enfermedades */

CREATE TABLE Duenio_Telefonos (
    Cedula dom_cedula,
    Telefono varchar(15) NOT NULL,

    PRIMARY KEY (Cedula, Telefono),
    FOREIGN KEY (Cedula)
        REFERENCES Duenios (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Dueño_Telefonos ------------------------------------------------------------------

--	SELECT * FROM Dueño_Telefonos
--  Insert INTO Dueño_Telefonos (Cedula, Telefono) VALUES (?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Dueño_Telefonos

--  Fin CRUD Dueño_Telefonos */

CREATE TABLE Empleado_Telefono (
    Cedula dom_cedula,
    Telefono varchar (15) NOT NULL,

    PRIMARY KEY (Cedula, Telefono),
    FOREIGN KEY (Cedula)
        REFERENCES Empleados (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*  CRUD Empleado_Telefono ------------------------------------------------------------------

--	SELECT * FROM Empleado_Telefono
--  Insert INTO Empleado_Telefono (Cedula, Telefono) VALUES (?,?);
--  UPDATE _____________No deberia ser actualizado______________
--  DROP TABLE Empleado_Telefono

--  Fin CRUD Empleado_Telefono ------------------------------------------------------------------

---- Fin Creación de Tablas */
