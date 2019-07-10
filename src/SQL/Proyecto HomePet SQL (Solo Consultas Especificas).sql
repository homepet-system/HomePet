
---- Consultas Especificas ----------------------------------------------------------------------
/*


----	Busqueda de Usuario

	SELECT cod_user, alias_usuario, nombre, contrasenia FROM Usuarios
		WHERE cod_user = _____;

	SELECT cod_user, alias_usuario, nombre, contrasenia FROM Usuarios
		WHERE alias_usuario = _____;




----	Busqueda de HomePets

	SELECT nombre, sector, ciudad FROM HomePets
		WHERE ciudad = _____;

	SELECT nombre, sector, ciudad FROM homepets
		WHERE sector = _____;

	SELECT Homepets.nombre, Homepets.sector, Homepets.ciudad FROM Homepets, Se_Especializan, Animales
		WHERE Animales.Descripcion = ______									AND
			Animales.cod_animal = Se_Especializan.cod_animal	AND
			Se_Especializan.RIF_Homepet = HomePets.RIF;

	SELECT Homepets.nombre, Homepets.sector, Homepets.ciudad FROM Homepets, Se_Especializan, Animales
		WHERE ciudad = _____ AND sector = _____ AND	Animales.Descripcion = ______ AND 
			Animales.cod_animal = Se_Especializan.cod_animal 												AND
			Se_Especializan.RIF_Homepet = HomePets.RIF;




---- Busqueda de Empleados

	SELECT Empleados.Nombre_Completo, Empleados.Tipo, HomePets.Ciudad AS HomePet FROM Empleados, HomePets
		WHERE HomePets.Ciudad = ______ 											AND
			Empelado.RIF_Homepet = Homepets.RIF;

	SELECT Empleados.Nombre_Completo, Empleados.Tipo, HomePets.Ciudad AS HomePet FROM Empleados, HomePets, Servicios, Personal_Ofrece_Servicio, Homepet_Servicio
		WHERE Servicios.Descripcion = ______ 															AND
			Servicios.Cod_Srvc = Homepet_Servicio.cod_srvc									AND
			Homepet_Servicio.RIF = HomePets.RIF															AND
			HomePets.RIF = Empleados.Rif_Homepet														AND
			Empleados.Cedula = Personal_Ofrece_Servicio.Cedula_Empleado;

	SELECT Empleados.Nombre_Completo, Empleados.Tipo, HomePets.Ciudad AS HomePet FROM Empleados, HomePets, Actividades, Servicios, Personal_Ofrece_Servicio
		WHERE Actividades.Descripcion = ______ 												AND
			Actividades.Cod_Srvc = Servicios.Cod_Srvc										AND
			Servicios.Cod_Srvc = Personal_Ofrece_Servicio.cod_srvc			AND
			Personal_Ofrece_Servicio.Cedula_Empleado = Empleados.Cedula AND
			Empelado.RIF_Homepet = Homepets.RIF;

	SELECT Empleados.Nombre_Completo, Empleados.Tipo, HomePets.Ciudad AS HomePet FROM Empleados, HomePets, Actividades, Servicios, Personal_Ofrece_Servicio, Homepet_Servicio
		WHERE Actividades.Descripcion = ______ AND HomePets.Ciudad = ______ AND Servicios.Descripcion = ______ 	AND
			Actividades.Cod_Srvc = Servicios.Cod_Srvc																															AND
			Servicios.Cod_Srvc = Personal_Ofrece_Servicio.cod_srvc																								AND
			Personal_Ofrece_Servicio.Cedula_Empleado = Empleados.Cedula 																					AND
			Empelado.RIF_Homepet = Homepets.RIF																																		AND
			HomePets.RIF = Homepet_Servicio.RIF																																		AND
			Homepet_Servicio.cod_srvc = Servicios.Cod_Srvc;




---- Busqueda de Clientes

	SELECT Duenio.Nombre_Completo, HomePets.Nombre AS HomePet, Visitas.Cantidad_Visitas FROM Duenios, HomePets, Visitas
		WHERE HomePets.Ciudad = ______ 									AND
			HomePets.RIF = Visitas.RIF_Homepet						AND
			Visitas.Cedula = Duenios.Cedula;
	
	SELECT Duenio.Nombre_Completo, HomePets.Nombre AS HomePet, Visitas.Cantidad_Visitas FROM Duenios, HomePets, Visitas
		WHERE Visitas.Cantidad_Visitas BETWEEN 0 AND 2 												OR
			Visitas.Cantidad_Visitas BETWEEN 3 AND 5 														OR
			Visitas.Cantidad_Visitas BETWEEN 6 AND MAX(Visita.Cantidad_Visitas)	AND
			Visitas.RIF_Homepet = HomePets.RIF																	AND
			Visitas.Cedula = Duenios.Cedula;
	
	SELECT Duenio.Nombre_Completo, HomePets.Nombre AS HomePet, Visitas.Cantidad_Visitas FROM Duenios, HomePets, Visitas
		WHERE Duenios.Cantidad_Mascotas = ______						AND
			Duenios.Cedula = Visitas.Cedula										AND
			Visitas.RIF_HomePet = HomePets.RIF;
			
	SELECT Duenio.Nombre_Completo, HomePets.Nombre AS HomePet, Visitas.Cantidad_Visitas FROM Duenios, HomePets, Visitas
		WHERE HomePets.Ciudad = ______ AND Visitas.Cantidad_Visitas BETWEEN 0 AND 2 OR Visitas.Cantidad_Visitas BETWEEN 3 AND 5 OR Visitas.Cantidad_Visitas BETWEEN 6 AND MAX(Visita.Cantidad_Visitas)																	AND
		Duenios.Cedula = Visitas.Cedula														AND
		Visitas.RIF_HomePet = HomePets.RIF;




----	Ventana de un HomePet

	SELECT Empeados.Nombre_Completo, Empeados.Tipo, Empleado_Telefono.Telefono FROM Empeados, Empleado_Telefono, HomePets
		WHERE Empeados.Tipo = 'Encargado' AND HomePets.RIF = _________		AND
			Empleados.RIF_HomePet = HomePets.RIF 														AND
			Empleados.Cedula = Empelado_Telefono.Cedula;
			
	SELECT Animales.Descripcion FROM Animales, Se_Especializan, HomePets
		WHERE HomePets.RIF = ________										AND
			HomePets.RIF = Se_Especializan.RIF_HomePet		AND
			Se_Especializan.Cod_Animal = Animales.Cod_Animal;
	
	SELECT Servicios.Nombre	FROM HomePets, Servicios, HomePet_Servicio
		WHERE HomePets.RIF = _________										AND
			HomePets.RIF = Homepet_Servicio.RIF							AND
			HomePet_Servicio.Cod_Srvc = Servicios.Cod_Srvc;
			
	SELECT Razas.Nombre, COUNT(Razas.Nombre) AS Cantidad_Atendido FROM Visitas, Duenios, Mascotas, Registra_Mascota_Servicio, Razas, HomePets
		WHERE HomePets.RIF = ________																					AND
			Visitas.Rif_Homepet	=	HomePets.RIF																	AND
			Mascotas.Cedula_Duenio = Visitas.Cedula															AND
			Registra_Mascota_Servicio.Cod_Mascota = Mascotas.Cod_Mascota				AND
			Razas.Cod_Raza = Mascotas.Cod_Raza
		GROUP BY Razas.Nombre
		ORDER BY DESC(Cantidad_Visitas);

	SELECT Productos.Nombre, COUNT(Productos.Nombre) AS Cantidad_Producto_Vendido FROM HomePets, Productos, Facturas, HomePet_Vende_Producto
		WHERE HomePets.RIF = ________					                AND
			Productos.RIF_HomePet = HomePets.RIF		                AND
			HomePet_Vende_Producto.Cod_Prod = Productos.Cod_Prod        AND
            Facturas.Cod_Factura = HomePet_Vende_Producto.Cod_Factura
        GROUP BY Productos.Nombre




----    Ventana de un Encargado

    SELECT Nombre_Completo, Tipo, Fecha_Inicio FROM Empleados
        WHERE Empleados.Cedula = _________;

    SELECT HomePets.Nombre, HomePets.Ciudad, HomePets.Sector FROM Empleados, HomePets
        WHERE Empleados.Cedula = _________                   AND
            Empleados.RIF_HomePet = HomePets.RIF;

    SELECT Servicios.Nombre, Actividades.Descripcion FROM Empleados, HomePets, HomePet_Servicio, Servicios, Actividades
        WHERE Encargados.Cedula = ________                  AND
            HomePets.RIF = Empleados.RIF_HomePet            AND
            HomePet_Servicio.RIF = HomePets.RIF             AND
            Servicios.Cod_Srvc = HomePet_Servicio.Cod_Srvc  AND
            Actividades.Cod_Srvc = Servicios.Cod_Srvc;

    Select Telefonos, Cedula, Sueldo FROM Empleados
        WHERE Empleado.Cedula = ________;




---     Ventana de un Cliente

    SELECT Nombre_Completo FROM Duenios
        WHERE Duenios.Cedula = ________;

    SELECT HomePets.Nombre FROM Duenios, Mascotas, HomePets
        WHERE Duenios.Cedula = ________             AND
            Mascotas.Cedula_Duenio = Duenios.Cedula AND
            HomePets.RIF = Mascotas.RIF_HomePet;

    SELECT Mascotas.Nombre, Razas.Nombre FROM Duenios, Mascotas, Razas
        WHERE Duenios.Cedula = ________                 AND
            Mascota.Cedula_Duenios = Duenios_Cedula     AND
            HomePet.RIF = Mascotas.RIF_HomePet          AND
            Mascotas.Cod_Raza = Razas.Cod_Raza;

    SELECT Duenio_Telefonos.Telefono Duenio.Email FROM Duenios, Duenio_Telefonos
        WHEHE Duenios.Cedula = __________               AND
            Duenios_Telefonos.Cedula = Duenios.Cedula;

    SELECT Servicios.Nombre FROM Duenios, Servicios, Factura_Genera_Servicio_X_D
        WHERE Duenios.Cedula = __________                               AND
            Factura_Genera_Servicio_X_D.Cedula_Duenio = Duenios.Cedula  AND
            Servicios.Cod_Srvc = Factura_Genera_Servicio_X_D.Cod_Srvc;

    SELECT Productos.Nombre FROM Duenios, Duenios_Paga_Factura, Productos
        WHERE Duenios.Cedula = __________                       AND
            Duenios_Paga_Factura.Cedula = Duenios.Cedula        AND
            Productos.Cod_Prod = Duenios_Paga_Factura.Cod_Prod;
*/
---- Fin Consultas Especificas ------------------------------------------------------------------
