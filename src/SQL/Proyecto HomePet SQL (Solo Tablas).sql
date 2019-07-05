--Creacion de las Tablas----------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Usuarios (
		cod_user dom_codigo NOT NULL,
		alias_usuario varchar(20) NOT NULL,
		nombre nombre_apellido NOT NULL,
		contrasenia dom_codigo NOT NULL,
		tipo_usuario VARCHAR(15) NOT NULL CHECK(tipo_usuario = 'Encargado' OR tipo_usuario = 'Empleado' OR tipo_usuario = 'Administrador'),
		
		PRIMARY KEY (cod_user)
);

CREATE TABLE Animales (
    Cod_Animal dom_codigo  NOT NULL,
    Descripcion varchar(140) NOT NULL,

    PRIMARY KEY (Cod_Animal)
);

CREATE TABLE Veterinarios (
    Cedula dom_cedula  NOT NULL,
    Nombre nombre_apellido NOT NULL,
    Telefono varchar(15) NOT NULL,

    PRIMARY KEY (Cedula)
);

CREATE TABLE Razas (
		
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
    Altura_Min integer NOT NULL
        CHECK (Altura_Min < Altura_Max),
    Altura_Max integer NOT NULL
        CHECK (Altura_Max > Altura_Min),

    PRIMARY KEY (Cod_Raza)
);

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

CREATE TABLE Homepets (
    RIF varchar (20) NOT NULL,
    Nombre varchar(20) NOT NULL,
    Ciudad varchar(15) NOT NULL,
    Sector varchar(15) NOT NULL,
    Cod_Animal VARCHAR(5),
		Cantidad INTEGER,

    PRIMARY KEY (RIF),
    CONSTRAINT un_Homepets UNIQUE (Ciudad, Sector),
    FOREIGN KEY (Cod_Animal) REFERENCES Animales(Cod_Animal) ON UPDATE CASCADE ON DELETE RESTRICT
);

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

CREATE TABLE Servicios (
    Cod_Srvc dom_codigo,
    Nombre varchar(15) NOT NULL,
    Descripcion varchar(60) NOT NULL,

    PRIMARY KEY (Cod_Srvc)
);

CREATE TABLE Duenios (
    Cedula dom_cedula	NOT NULL,
    Nombre_Completo nombre_apellido NOT NULL,
    Email varchar(40),
		Cantidad_Mascotas INTEGER,

    PRIMARY KEY (Cedula)
);

CREATE TABLE Mascotas (
    Cod_Mascota dom_codigo NOT NULL,
    Nombre varchar(30) NOT NULL,
    Fecha_Nac date NOT NULL,
    Tipo_Animal varchar(10) NOT NULL,
    Sexo dom_sexo,
    Cedula_Duenio dom_cedula,
    Cod_Raza dom_codigo NOT NULL,
    Cod_Animal dom_codigo NOT NULL,
    Cod_Prod dom_codigo,
    RIF_Homepet varchar(20) NOT NULL,
    Cedula_Vet dom_cedula,
    
    PRIMARY KEY(Cod_Mascota),
    FOREIGN KEY (Cedula_Duenio) REFERENCES Duenios(Cedula) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY(Cod_Raza) REFERENCES Raza_Animal(Cod_Raza) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Animal) REFERENCES Raza_Animal(Cod_Animal) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Prod) REFERENCES Productos(Cod_Prod) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (RIF_Homepet) REFERENCES Homepets(RIF) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (Cedula_Vet) REFERENCES Veterinarios(Cedula) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Cantidad_Suministrar_Producto_Mascota(
		Cod_Mascota dom_codigo,
    Cod_Prod dom_codigo,
		Tipo_Comida VARCHAR(20),
    Cantidad_Smnt integer NOT NULL
        CHECK (Cantidad_Smnt > '0'),
    
    PRIMARY KEY (Cod_Mascota,Cod_Prod),
		FOREIGN KEY (cod_Mascota) REFERENCES Mascotas (cod_mascota) ON UPDATE CASCADE ON DELETE RESTRICT,
		FOREIGN KEY (Cod_Prod) REFERENCES Productos (cod_Prod) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Registros (
    Cod_Registro dom_codigo,
    Fecha_E varchar(10) NOT NULL,
    Hora_E time NOT NULL,
    Fecha_SEst varchar(10) NOT NULL,
    Hora_SEst time NOT NULL,
    Fecha_SReal varchar(10) NOT NULL,
    Hora_SReal time NOT NULL,

    PRIMARY KEY (Cod_Registro)
);

CREATE TABLE Modalidades (
    Cod_Mod dom_codigo,
    Fecha varchar(10) NOT NULL,
    Monto integer NOT NULL,
    Tipo_M varchar(10) NOT NULL,
    Numero varchar(20) NOT NULL,

    PRIMARY KEY (Cod_Mod)
);

CREATE TABLE Reservas (
    Cod_Reserva dom_codigo,
    Fecha_Resrv varchar(10) NOT NULL,
    Fecha_Act_R varchar(10) NOT NULL,
    Monto_Abonado integer NOT NULL,
    Monto_Total integer NOT NULL,
    Porc_Dscnt integer NULL,

    PRIMARY KEY(Cod_Reserva)
);

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

CREATE TABLE Empleados (
    Cedula dom_cedula,
    Nombre_Completo nombre_apellido,
    Sueldo integer NOT NULL
        CHECK (Sueldo >= '0'),
    Direccion varchar(50) NOT NULL,
    Tipo varchar(10) NOT NULL,
    Fecha_Inicio varchar(10) NOT NULL,
    RIF_Homepet varchar(20) NOT NULL,

    PRIMARY KEY (Cedula),
    FOREIGN KEY (RIF_Homepet)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Facturas (
    Cod_Factura dom_codigo,
    Fecha_F varchar(10) NOT NULL,
    Monto_Total varchar(15) NOT NULL,
    Tipo varchar(10) NOT NULL,

    PRIMARY KEY (Cod_Factura)
);

CREATE TABLE Homepet_Vende_Producto (
    Cod_Prod dom_codigo,
    RIF dom_codigo,
    Cod_Factura dom_codigo,

    PRIMARY KEY (Cod_Prod, RIF, Cod_Factura),
    FOREIGN KEY (Cod_Prod)
        REFERENCES Productos (Cod_Prod)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (RIF)
        REFERENCES Homepets (RIF)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Factura)
        REFERENCES Facturas (Cod_Factura)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

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

CREATE TABLE Ordenes_X_Compra (
    Cod_Orden dom_codigo,
    Fecha_Orden varchar(15) NOT NULL,
    Cantidad_Pedida varchar(15) NOT NULL,

    PRIMARY KEY (Cod_Orden)
);

CREATE TABLE Inventario (
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
        REFERENCES Productos(Cod_Prod)
        ON UPDATE  CASCADE
        ON DELETE  RESTRICT
);

CREATE TABLE Ajustes(
    RIF_Homepet varchar(20) NOT NULL,
    Cod_Prod dom_codigo NOT NULL,
    Fecha_Ajuste varchar(10) NOT NULL,
    Dif_Teorica_Fisica integer NOT NULL,
    Tipo_Ajuste char NOT NULL CHECK(Tipo_Ajuste = 'S' or Tipo_Ajuste = 'F'),

    PRIMARY KEY (RIF_Homepet,Cod_Prod,Fecha_Ajuste),
    FOREIGN KEY (RIF_Homepet,Cod_Prod)
        REFERENCES Inventario(RIF_Homepet, Cod_Producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

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

CREATE TABLE IF NOT EXISTS Vacunas (
		Cod_Vacuna dom_codigo,
		Nombre_Vacuna VARCHAR(20) NOT NULL,
		Descripcion_Vacuna VARCHAR(30) NOT NULL,
		Costo_Vacuna REAL,
		
		PRIMARY KEY (Cod_Vacuna)
);

CREATE TABLE IF NOT EXISTS Vacuna_Aplica_Mascota(
		Cod_Vacuna dom_codigo,
		Cod_Mascota dom_codigo,
		Cod_Veterinario dom_codigo,
		fecha_aplicacion VARCHAR(10) NOT NULL,
		Dosis_cc INTEGER NOT NULL,
		
		PRIMARY KEY (Cod_Mascota, Cod_Vacuna, Cod_Veterinario),
		FOREIGN KEY (Cod_Mascota) REFERENCES Mascotas (Cod_Mascota) ON UPDATE CASCADE ON DELETE RESTRICT,
		FOREIGN KEY (Cod_Veterinario) REFERENCES Veterinarios (Cedula) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Vacuna_Aplica_Raza (
		Cod_Vacuna dom_codigo,
    Cod_Raza dom_codigo,
    Edad integer NOT NULL
        CHECK (Edad > '0'),
    Dosis_cc integer NOT NULL
        CHECK (Dosis_cc > '0'),

    PRIMARY KEY (Cod_Vacuna, Cod_Raza),
		FOREIGN KEY (Cod_Vacuna)
        REFERENCES Vacunas (Cod_Vacuna)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Cod_Raza)
        REFERENCES Razas (Cod_Raza)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

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

CREATE TABLE Visitas (
    Cedula dom_cedula,
    RIF_Homepet varchar(20) NOT NULL,
		Cantidad_Visitas INTEGER,

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

CREATE TABLE Detalles_Animal_Para_Suministrar (
    Cod_Raza dom_codigo,
    Tamanio integer NOT NULL
        CHECK (Tamanio > '0'),
    Edad integer NOT NULL
        CHECK (Edad > '0'),
    Peso integer NOT NULL
        CHECK (Peso > '0'),

    PRIMARY KEY (Cod_Raza),
    FOREIGN KEY (Cod_Raza)
        REFERENCES Razas (Cod_Raza)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


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

CREATE TABLE Registra_Mascota_Servicio (
    Cod_Mascota dom_codigo,
    Cod_Registro dom_codigo,
	Cod_Srvc dom_codigo,
    Cod_Actividad dom_codigo,


    PRIMARY KEY (Cod_Mascota, Cod_Registro, Cod_Srvc, Cod_Actividad),
    FOREIGN KEY (Cod_Mascota)
        REFERENCES Mascotas (Cod_Mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
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


CREATE TABLE Proveedor_Cobra_Factura (
    Cod_Factura dom_codigo,
    RIF_Proveedor varchar(20) NOT NULL,
    Cod_Prod dom_codigo,
    Fecha_Pago varchar(10) NOT NULL,

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

CREATE TABLE Mascota_Enfermedades (
    Cod_Mascota dom_codigo NOT NULL,
    Enfermedades varchar(40) NOT NULL,

    PRIMARY KEY (Cod_Mascota, Enfermedades),
    FOREIGN KEY (Cod_Mascota)
        REFERENCES Mascotas (Cod_Mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Animal_Enfermedades(
		Cod_Animal dom_codigo NOT NULL,
		nombre_enfermedad VARCHAR(25) NOT NULL,
		descripcion_enfemedad VARCHAR(60) NOT NULL,
		gravedad VARCHAR(30) NOT NULL CHECK(gravedad = 'Leve' OR gravedad = 'Media' OR gravedad = 'Alta'),
		cura VARCHAR(70),
		
		PRIMARY KEY (Cod_Animal, nombre_enfermedad),
		FOREIGN KEY (Cod_Animal) REFERENCES Animales (Cod_Animal)
);

CREATE TABLE Duenio_Telefonos (
    Cedula dom_cedula,
    Telefono varchar(15) NOT NULL,

    PRIMARY KEY (Cedula, Telefono),
    FOREIGN KEY (Cedula)
        REFERENCES Duenios (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


CREATE TABLE Empleado_Telefono (
    Cedula dom_cedula NOT NULL,
    Telefono varchar (15) NOT NULL,

    PRIMARY KEY (Cedula, Telefono),
    FOREIGN KEY (Cedula)
        REFERENCES Empleados (Cedula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
