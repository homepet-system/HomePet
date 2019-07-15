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

CREATE TABLE IF NOT EXISTS Homepets (
    RIF varchar (20) NOT NULL,
    Nombre varchar(20) NOT NULL,
    Ciudad varchar(15) NOT NULL,
    Sector varchar(15) NOT NULL,
    Cod_Animal VARCHAR(5) NULL,
	Capacidad INTEGER NOT NULL,

    PRIMARY KEY (RIF),
    CONSTRAINT un_Homepets UNIQUE (Ciudad, Sector),
    FOREIGN KEY (Cod_Animal) 
        REFERENCES Animales(Cod_Animal) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);

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

CREATE TABLE IF NOT EXISTS Encargados (
    Cedula_Encargado dom_cedula,
    Fecha_Inicio varchar(20) NOT NULL,

    PRIMARY KEY (Cedula_Encargado),
    FOREIGN KEY (Cedula_Encargado) 
        REFERENCES Empleados (Cedula) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Usuarios (
	Cod_User dom_codigo NOT NULL,
	Alias_Usuario varchar(20) NOT NULL,
	Nombre nombre_apellido NOT NULL,
	Contrasenia dom_codigo NOT NULL,
	Tipo_Usuario VARCHAR(15) NOT NULL CHECK(tipo_usuario = 'Encargado' OR tipo_usuario = 'Empleado' OR tipo_usuario = 'Administrador'),
		
	PRIMARY KEY (cod_user)
);

CREATE TABLE IF NOT EXISTS Veterinarios (
    Cedula dom_cedula  NOT NULL,
    Nombre nombre_apellido NOT NULL,
    Telefono varchar(15) NOT NULL,

    PRIMARY KEY (Cedula)
);

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

CREATE TABLE IF NOT EXISTS Productos (
    Cod_Producto dom_codigo,
    Nombre varchar(30) NOT NULL,
    Descripcion varchar(40) NOT NULL,

    PRIMARY KEY (Cod_Producto)
);

CREATE TABLE IF NOT EXISTS Servicios (
    Cod_Servicio dom_codigo UNIQUE,
    Nombre varchar(15) NOT NULL,
    Descripcion varchar(60) NOT NULL,

    PRIMARY KEY (Cod_Servicio)
);

CREATE TABLE IF NOT EXISTS Duenios (
    Cedula dom_cedula	NOT NULL,
    Nombre_Completo nombre_apellido NOT NULL,
    Email varchar(40),

    PRIMARY KEY (Cedula)
);

CREATE TABLE IF NOT EXISTS Facturas (
    Cod_Factura dom_codigo,
    Fecha_F varchar(10) NOT NULL,
    Monto_Total float NOT NULL,
    Tipo varchar(10) NOT NULL,
    Pagado boolean NOT NULL,

    PRIMARY KEY (Cod_Factura)
);

CREATE TABLE IF NOT EXISTS Mascotas (
    Cod_Mascota dom_codigo NOT NULL,
    Nombre varchar(30) NOT NULL,
    Fecha_Nac varchar(20) NOT NULL,
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

CREATE TABLE IF NOT EXISTS Alimentacion(
    Cod_Mascota dom_codigo,
    Tipo_Comida varchar(15) NOT NULL,
    Cantidad integer NOT NULL,
    Unidad varchar(20) NOT NULL,

    PRIMARY KEY (Cod_Mascota, Tipo_Comida),
    FOREIGN KEY (Cod_Mascota) REFERENCES Mascotas(Cod_Mascota) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Ficha_Registro (
    Cod_Registro dom_codigo,
    Fecha_E varchar(10) NOT NULL,
    Hora_E varchar(10) NOT NULL,
    Fecha_SEst varchar(10) NOT NULL,
    Hora_SEst varchar(10) NOT NULL,
    Fecha_SReal varchar(10) NOT NULL,
    Hora_SReal varchar(10) NOT NULL,

    PRIMARY KEY (Cod_Registro)
);

CREATE TABLE IF NOT EXISTS Modalidades (
    Cod_Factura dom_codigo,
    Fecha varchar(10) NOT NULL,
    Monto float NOT NULL,
    Tipo_M varchar(10) NOT NULL,
    Numero varchar(20) NOT NULL,

    PRIMARY KEY (Cod_Factura, Tipo_M),
    FOREIGN KEY (Cod_Factura)
        REFERENCES Facturas (Cod_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Reservaciones (
    Cod_Reserva dom_codigo,
    Fecha_Reservacion varchar(10) NOT NULL,
    Fecha_Pautada varchar(10) NOT NULL,
    Monto_Abonado float NOT NULL,
    Monto_Total float NOT NULL,
    Descuento float NULL,
    Pagado boolean NOT NULL,
    RIF_Homepet dom_codigo,

    PRIMARY KEY(Cod_Reserva)
);

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

CREATE TABLE IF NOT EXISTS Homepet_Producto (
    Cod_Producto dom_codigo,
    RIF varchar(20) NOT NULL,
    Costo float NOT NULL,
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

CREATE TABLE IF NOT EXISTS Proveedor_Producto (
    RIF_Proveedor varchar(20) NOT NULL,
    Cod_Producto dom_codigo,
    Precio float NOT NULL,

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

CREATE TABLE IF NOT EXISTS Ordenes_Compra (
    Cod_Orden dom_codigo,
    Fecha_Pedido varchar(15) NOT NULL,

    PRIMARY KEY (Cod_Orden)
);

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

CREATE TABLE IF NOT EXISTS Vacunas (
		Cod_Vacuna dom_codigo,
		Nombre_Vacuna VARCHAR(20) NOT NULL,
		Descripcion_Vacuna VARCHAR(30) NOT NULL,
		
		PRIMARY KEY (Cod_Vacuna)
);

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

CREATE TABLE IF NOT EXISTS Vacuna_Homepet (
    RIF_Homepet varchar(20) NOT NULL,
    Cod_Vacuna dom_codigo,
    Cantidad_Minima integer NOT NULL,
    Cantidad_Disponible integer NOT NULL,
    Costo float NOT NULL,

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

CREATE TABLE IF NOT EXISTS Orden_De_Uso (
    Cedula_Responsable dom_cedula,
    Cod_Servicio dom_codigo,
    Cod_Actividad integer NOT NULL,
    Cod_Mascota dom_codigo,
    Cod_Producto dom_codigo,
    Fecha_Consumo varchar(20) NOT NULL,
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

CREATE TABLE IF NOT EXISTS Enfermedades(
	Nombre_Enfermedad VARCHAR(25) NOT NULL,
	Descripcion_Enfermedad VARCHAR(60) NOT NULL,
	Gravedad VARCHAR(30) NOT NULL 
        CHECK (Gravedad = 'Leve' OR Gravedad = 'Media' OR Gravedad = 'Alta'),
	Cura VARCHAR(70),
		
	PRIMARY KEY (Nombre_Enfermedad)
);

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

CREATE TABLE IF NOT EXISTS Duenio_Telefonos (
    Cedula dom_cedula,
    Telefono varchar(15) NOT NULL,

    PRIMARY KEY (Cedula, Telefono),
    FOREIGN KEY (Cedula)
        REFERENCES Duenios (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

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

CREATE TABLE IF NOT EXISTS Actividades_X_Homepet (
    RIF_Homepet varchar(20) NOT NULL,
    Cod_Servicio dom_codigo,
    Cod_Actividad integer NOT NULL,
    Capacidad_Atencion integer NOT NULL,
    Costo float NOT NULL,

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

CREATE TABLE IF NOT EXISTS Homepet_Mascotas(
    Cod_Mascota dom_codigo,
    RIF_Homepet dom_codigo,

    PRIMARY KEY (Cod_Mascota, RIF_Homepet),
    FOREIGN KEY (Cod_Mascota) 
        REFERENCES Mascotas(Cod_Mascota) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT,
    FOREIGN KEY (RIF_Homepet) 
        REFERENCES Homepets(RIF) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);
