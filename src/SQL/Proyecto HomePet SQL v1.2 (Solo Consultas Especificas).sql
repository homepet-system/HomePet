
---- Consultas Especificas ----------------------------------------------------------------------
/*


----	Busqueda de Usuario

	SELECT Cod_User, Alias_Usuario, Nombre, Contrasenia FROM Usuarios
		WHERE cod_user = _____;

	SELECT cod_user, alias_usuario, nombre, contrasenia FROM Usuarios
		WHERE alias_usuario = _____;
-----------------------------------------------------------------------------



----	Busqueda de HomePets

	SELECT nombre, sector, ciudad FROM HomePets
		WHERE ciudad = _____;

	SELECT nombre, sector, ciudad FROM homepets
		WHERE sector = _____;

	SELECT Homepets.nombre, Homepets.sector, Homepets.ciudad FROM Homepets, Animales
		WHERE Animales.Descripcion = ______									AND
			Animales.cod_animal = HomePets.Cod_Animal;

	SELECT Homepets.nombre, Homepets.sector, Homepets.ciudad FROM Homepets, Animales
		WHERE ciudad = _____ AND sector = _____ AND	Animales.Descripcion = ______ 		AND 
			Animales.cod_animal = HomePets.Cod_Animal;
-----------------------------------------------------------------------------------------------------------------------------------



---- Busqueda de Empleados

	SELECT Empleados.Nombre_Completo, HomePets.Ciudad AS HomePet FROM Empleados, HomePets
		WHERE HomePets.Ciudad = _____								AND
			Empleados.RIF_Homepet = Homepets.RIF;

	SELECT Empleados.Nombre_Completo, HomePets.Ciudad AS HomePet FROM Empleados, HomePets, Servicios, Actividades_X_HomePet, Servicios_Prestados_X_Personal
		WHERE Servicios.Descripcion = _____ 														AND
			Servicios.Cod_Servicio = Actividades_X_HomePet.Cod_Servicio								AND
			Actividades_X_HomePet.RIF_Homepet = HomePets.RIF										AND
			HomePets.RIF = Empleados.Rif_Homepet													AND
			Empleados.Cedula = Servicios_Prestados_X_Personal.Cedula_Empleado;

	SELECT Empleados.Nombre_Completo, HomePets.Ciudad AS HomePet FROM Empleados, HomePets, Servicios, Actividades_X_HomePet, Servicios_Prestados_X_Personal, Actividades
		WHERE Actividades.Descripcion = _______ 												AND
			Actividades.Cod_Servicio = Servicios.Cod_Servicio								AND
			Servicios.Cod_Servicio = Servicios_Prestados_X_Personal.Cod_Servicio			AND
			Servicios_Prestados_X_Personal.Cedula_Empleado = Empleados.Cedula 				AND
			Empleados.RIF_Homepet = Homepets.RIF;

	SELECT Empleados.Nombre_Completo, HomePets.Ciudad AS HomePet FROM Empleados, HomePets, Servicios, Actividades_X_HomePet, Servicios_Prestados_X_Personal, Actividades
		WHERE Actividades.Descripcion = _____ AND HomePets.Ciudad = _____ AND Servicios.Descripcion = _____ 	AND
			Actividades.Cod_Servicio = Servicios.Cod_Servicio													AND
			Servicios.Cod_Servicio = Servicios_Prestados_X_Personal.Cod_Servicio								AND
			Servicios_Prestados_X_Personal.Cedula_Empleado = Empleados.Cedula 									AND
			Empleados.RIF_Homepet = Homepets.RIF																AND
			HomePets.RIF = Actividades_X_HomePet.RIF_Homepet													AND
			Actividades_X_HomePet.Cod_Servicio = Servicios.Cod_Servicio;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



---- Busqueda de Clientes

	SELECT Duenios.Nombre_Completo, HomePets.Nombre AS HomePet FROM Duenios, HomePets, Mascotas, Actividades_X_HomePet, Orden_de_Uso
		WHERE HomePets.Ciudad = ______ 													AND
			HomePets.RIF = Actividades_X_Homepet.RIF_Homepet						AND
			Actividades_X_Homepet.Cod_Actividad = Orden_de_Uso.Cod_Actividad      	AND
            Orden_de_Uso.Cod_Mascota = Mascotas.Cod_Mascota             			AND
            Mascotas.Cedula_Duenio = Duenios.Cedula;
	
	SELECT Duenios.Nombre_Completo, HomePets.Nombre, COUNT(Mascotas.Cod_Mascota) AS Cantidad_Mascotas FROM Duenios, Mascotas, Orden_de_Uso, Actividades_X_Homepet, Homepets
		WHERE Duenios.Cedula = Mascotas.Cedula_Duenio 								AND
            Mascotas.Cod_Mascota = Orden_de_Uso.Cod_Mascota 						AND
            Orden_de_Uso.Cod_Actividad = Actividades_X_Homepet.Cod_Actividad 		AND
            Actividades_X_Homepet.RIF_Homepet = Homepets.RIF
        GROUP BY Duenios.Nombre_Completo, HomePets.Nombre
        HAVING COUNT(Mascotas.Cod_Mascota) = _______;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




----	Ventana de un HomePet

	SELECT Empleados.Nombre_Completo, Empleados.Telefono FROM Empleados, HomePets, Encargados
		WHERE HomePets.RIF = _____								AND
			Empleados.RIF_HomePet = HomePets.RIF 				OR
			Empleados.Cedula = Encargados.Cedula_Encargado;
			
	SELECT Animales.Descripcion FROM Animales, HomePets
		WHERE HomePets.RIF = ''						AND
			HomePets.Cod_Animal = Animales.Cod_Animal;
	
	SELECT Servicios.Nombre	FROM HomePets, Servicios, Actividades_X_HomePet
		WHERE HomePets.RIF = ''												AND
			HomePets.RIF = Actividades_X_HomePet.RIF_Homepet				AND
			Actividades_X_HomePet.Cod_Servicio = Servicios.Cod_Servicio;
			
	SELECT Razas.Nombre, COUNT(Razas.Nombre) AS Cantidad_Atendido FROM Duenios, Mascotas, Orden_De_Uso, Razas, HomePets, Homepet_Mascotas
		WHERE HomePets.RIF = _____										AND
			Homepet_Mascotas.Rif_Homepet	=	HomePets.RIF			AND
			Orden_De_Uso.Cod_Mascota = Homepet_Mascotas.Cod_Mascota		AND
			Orden_De_Uso.Cod_Mascota = Mascotas.Cod_Mascota				AND
			Razas.Cod_Raza = Mascotas.Cod_Raza
		GROUP BY Razas.Nombre
		ORDER BY Cantidad_Atendido DESC, Razas.Nombre;

	SELECT Productos.Nombre, COUNT(Productos.Nombre) AS Cantidad_Producto_Vendido FROM HomePets, Productos, Homepet_Producto
		WHERE HomePets.RIF = _____				                	AND
			Homepet_Producto.RIF = HomePets.RIF		                AND
			Homepet_Producto.Cod_Producto = Productos.Cod_Producto
        GROUP BY Productos.Nombre;
---------------------------------------------------------------------------------------------------------------------------------------------------



----    Ventana de un Encargado

    SELECT Nombre_Completo, Fecha_Inicio FROM Empleados, Encargados
        WHERE Empleados.Cedula = _______					AND
        	Empleados.Cedula = Encargados.Cedula_Encargado;

    SELECT HomePets.Nombre, HomePets.Ciudad, HomePets.Sector FROM Empleados, HomePets, Encargados
        WHERE Empleados.Cedula = ______		                   	AND
            Empleados.Cedula = Encargados.Cedula_Encargado		AND
            Empleados.RIF_HomePet = HomePets.RIF;

    SELECT Servicios.Nombre, Actividades.Descripcion FROM Empleados, HomePets, Actividades_X_HomePet, Servicios, Actividades, Encargados
        WHERE Encargados.Cedula_Encargado = ______                 			AND
            Encargados.Cedula_Encargado = Empleados.Cedula  				AND
            HomePets.RIF = Empleados.RIF_HomePet            				AND
            Actividades_X_HomePet.RIF_Homepet = HomePets.RIF             	AND
            Servicios.Cod_Servicio = Actividades_X_HomePet.Cod_Servicio  	AND
            Actividades.Cod_Servicio = Servicios.Cod_Servicio;

	SELECT Telefono, Cedula, Sueldo FROM Empleados
        WHERE Empleados.Cedula = '';
-----------------------------------------------------------------------------------------------------------------------------------------------------



---     Ventana de un Cliente

    SELECT Nombre_Completo FROM Duenios
        WHERE Duenios.Cedula = ________;

    SELECT HomePets.Nombre FROM Duenios, Mascotas, HomePets, Homepet_Mascotas
        WHERE Duenios.Cedula = _____           					AND
            Mascotas.Cedula_Duenio = Duenios.Cedula 			AND
            Mascotas.Cod_Mascota = Homepet_Mascotas.Cod_Mascota AND
            Homepet_Mascotas.RIF_Homepet = Homepets.RIF;

    SELECT Mascotas.Nombre, Razas.Nombre FROM Duenios, Mascotas, Razas, Homepet_Mascotas, Homepets
        WHERE Duenios.Cedula = ________	        				AND
            Mascotas.Cedula_Duenio = Duenios.Cedula     		AND
            Mascotas.Cod_Mascota = Homepet_Mascotas.Cod_Mascota AND
            Homepet_Mascotas.RIF_Homepet = Homepets.RIF 		AND
            Mascotas.Cod_Raza = Razas.Cod_Raza;

    SELECT Duenio_Telefonos.Telefono, Duenios.Email FROM Duenios, Duenio_Telefonos
        WHERE Duenios.Cedula = ________               		AND
            Duenio_Telefonos.Cedula = Duenios.Cedula;

    SELECT Servicios.Nombre FROM Duenios, Servicios, Factura_Actividad, Orden_de_Uso, Mascotas
        WHERE Duenios.Cedula = _______                          AND
            Duenios.Cedula = Mascotas.Cedula_Duenio 			AND
            Mascotas.Cod_Mascota = Orden_de_Uso.Cod_Mascota 	AND
            Orden_de_Uso.Cod_Servicio = Servicios.Cod_Servicio;

    SELECT Productos.Nombre FROM Duenios, Productos, Orden_de_Uso, Mascotas
        WHERE Duenios.Cedula = _______                       	AND
            Duenios.Cedula = Mascotas.Cedula_Duenio 			AND
            Mascotas.Cod_Mascota = Orden_de_Uso.Cod_Mascota 	AND
            Orden_de_Uso.Cod_Producto = Productos.Cod_Producto;
*/
---- Fin Consultas Especificas ------------------------------------------------------------------

--Requerimientos---------------------------------------------------------------------------
/*


-- Los Productos que ofrece un HomePet, con su nombre, cantidad, precio de venta
	
	SELECT Productos.Nombre, Homepet_Producto.Cantidad_Disponible, Homepet_Producto.Costo FROM Productos, Homepets, Homepet_Producto
		WHERE Homepets.RIF = _________								 	AND
			Homepets.RIF = Homepet_Producto.RIF							AND
			Homepet_Producto.Cod_Producto = Productos.Cod_Producto;
--

-- Los servicios y actividades que ofrece un HomePet, con su nombre, capacidad y precio de la actividad.
	SELECT Servicios.Nombre, Actividades.Descripcion, Actividades_X_Homepet.Capacidad_Atencion, Actividades_X_Homepet.Costo FROM Servicios, Actividades, Homepets, Actividades_X_Homepet
		WHERE Homepets.RIF = ________										 	AND
			Homepets.RIF = Actividades_X_Homepet.RIF_Homepet 					AND
			Actividades_X_Homepet.Cod_Actividad = Actividades.Cod_Actividad 	AND
			Actividades.Cod_Servicio = Servicios.Cod_Servicio;
--

-- DATOS DE UNA MASCOTA

	DATOS GENERALES CON UN CODIGO DE MASCOTA
		SELECT Mascotas.Nombre, Mascotas.Fecha_Nac, Mascotas.Tipo_Animal, Mascotas.Sexo, Razas.Nombre, Duenios.Nombre_Completo, Veterinarios.Nombre FROM Mascotas, Razas, Duenios, Veterinarios, Animales
			WHERE Mascotas.Cod_Mascota = _______				 	AND
				Mascotas.Cod_Raza = Razas.Cod_Raza 					AND
				Mascotas.Cedula_Duenio = Duenios.Cedula 			AND
				Mascotas.Cedula_Vet = Veterinarios.Cedula;
	-
	DATOS DE RELACIONES CON OTRAS MASCOTAS
		SELECT M.Nombre, FM.Nombre FROM Mascotas AS M, Mascotas AS FM, Mascota_Familia
			WHERE M.Cod_Mascota = _______ 								AND
				M.Cod_Mascota = Mascota_Familia.Cod_Mascota_Familia 	AND
				Mascota_Familia.Cod_Mascota_Familia = FM.Cod_Mascota;
	-
	DATOS DE SERVICIOS QUE SE LE HAN HECHO
		SELECT Servicios.Nombre, Actividades.Descripcion, Homepets.Nombre FROM Mascotas, Orden_De_Uso, Homepet_Mascotas, Homepets, Servicios, Actividades
			WHERE Mascotas.Cod_Mascota = ________ 						AND
				Mascotas.Cod_Mascota = Orden_De_Uso.Cod_Mascota 		AND
				Orden_De_Uso.Cod_Servicio = Servicios.Cod_Servicio 		AND
				Orden_De_Uso.Cod_Actividad = Actividades.Cod_Actividad 	AND
				Mascotas.Cod_Mascota = Homepet_Mascotas.Cod_Mascota;
	-
	DATOS DE TODAS LAS ENFERMEDADES SUFRIDAS
		SELECT Mascotas.Nombre, Razas.Nombre, Enfermedades.Nombre_Enfermedad, Enfermedades.Gravedad, Enfermedades.Descripcion_Enfermedad FROM Mascotas, Enfermedades, Razas, Enfermedades_Padecidas_X_Mascota
			WHERE Mascotas.Cod_Mascota = ________														AND
				Mascotas.Cod_Raza = Razas.Cod_Raza 														AND
				Mascotas.Cod_Mascota = Enfermedades_Padecidas_X_Mascota.Cod_Mascota 					AND
				Enfermedades_Padecidas_X_Mascota.Nombre_Enfermedad = Enfermedades.Nombre_Enfermedad;
	-

--

-- DATOS ESTADISTICOS

	RAZA MAS ATENDIDA
		SELECT Servicios.Nombre, Razas.Nombre, COUNT(Razas.Cod_Raza) AS Frecuencia FROM Razas, Orden_De_Uso, Servicios, Mascotas
			WHERE Servicios.Cod_Servicio = _______					 	AND
				Servicios.Cod_Servicio = Orden_De_Uso.Cod_Servicio 		AND
				Orden_De_Uso.Cod_Mascota = Mascotas.Cod_Mascota 		AND
				Mascotas.Cod_Raza = Razas.Cod_Raza
			GROUP BY Servicios.Nombre, Razas.Nombre
			ORDER BY Frecuencia DESC;
	-
	PERSONAL QUE REALIZA MÁS SERVICIOS
		SELECT Empleados.Nombre_Completo, Servicios.Nombre, COUNT(Servicios.Cod_Servicio) AS Frecuencia_Trabajo FROM Empleados, Servicios, Servicios_Prestados_X_Personal, Homepets
			WHERE Homepets.RIF = ________												 	AND
				Homepets.RIF = Empleados.RIF_Homepet 										AND
				Empleados.Cedula = Servicios_Prestados_X_Personal.Cedula_Empleado 			AND
				Servicios_Prestados_X_Personal.Cod_Servicio = Servicios.Cod_Servicio
			GROUP BY Empleados.Nombre_Completo, Servicios.Nombre
			ORDER BY Frecuencia_Trabajo DESC;
	-
	PERSONAL QUE REALIZA MENOS SERVICIOS
		SELECT Empleados.Nombre_Completo, Servicios.Nombre, COUNT(Servicios.Cod_Servicio) AS Frecuencia_Trabajo FROM Empleados, Servicios, Servicios_Prestados_X_Personal, Homepets
			WHERE Homepets.RIF = ________												 	AND
				Homepets.RIF = Empleados.RIF_Homepet 										AND
				Empleados.Cedula = Servicios_Prestados_X_Personal.Cedula_Empleado 			AND
				Servicios_Prestados_X_Personal.Cod_Servicio = Servicios.Cod_Servicio
			GROUP BY Empleados.Nombre_Completo, Servicios.Nombre
			ORDER BY Frecuencia_Trabajo ASC;
	-
	CLIENTE MÁS FRECUENTE
		SELECT Duenios.Nombre_Completo, COUNT(Factura_Duenio.Cod_Factura) AS Frecuencia_Atendido FROM Duenios, Factura_Duenio, Factura_Actividad, Actividades_X_Homepet, Homepets
			WHERE Homepets.RIF = ________ AND
				Homepets.RIF = Actividades_X_Homepet.RIF_Homepet AND
				Actividades_X_Homepet.Cod_Actividad = Factura_Actividad.Cod_Actividad AND
				Factura_Actividad.Cod_Factura = Factura_Duenio.Cod_Factura AND
				Factura_Duenio.Cedula_Duenio = Duenios.Cedula
			GROUP BY Duenios.Nombre_Completo
			ORDER BY Frecuencia_Atendido DESC;
	-
	CLIENTE MENOS FRECUENTE
		SELECT Duenios.Nombre_Completo, COUNT(Factura_Duenio.Cod_Factura) AS Frecuencia_Atendido FROM Duenios, Factura_Duenio, Factura_Actividad, Actividades_X_Homepet, Homepets
			WHERE Homepets.RIF = ________ AND
				Homepets.RIF = Actividades_X_Homepet.RIF_Homepet AND
				Actividades_X_Homepet.Cod_Actividad = Factura_Actividad.Cod_Actividad AND
				Factura_Actividad.Cod_Factura = Factura_Duenio.Cod_Factura AND
				Factura_Duenio.Cedula_Duenio = Duenios.Cedula
			GROUP BY Duenios.Nombre_Completo
			ORDER BY Frecuencia_Atendido ASC;
	-
	PRODUCTO CON MAYOR SALIDA POR VENTAS
		SELECT Productos.Nombre, COUNT(Factura_Producto.Cod_Producto) AS Frecuencia_Venta FROM Homepets, Productos, Factura_Producto, Facturas, Homepet_Producto
			WHERE Homepets.RIF = _________					 				AND
				Homepets.RIF = Homepet_Producto.Cod_Producto 				AND
				Homepet_Producto.Cod_Producto = Factura_Producto.Cod_Producto
			GROUP BY Productos.Nombre
			ORDER BY Frecuencia_Venta DESC;
	-
	PRODUCTO CON MENOR SALIDA POR VENTAS
		SELECT Productos.Nombre, COUNT(Factura_Producto.Cod_Producto) AS Frecuencia_Venta FROM Homepets, Productos, Factura_Producto, Facturas, Homepet_Producto
			WHERE Homepets.RIF = _________					 				AND
				Homepets.RIF = Homepet_Producto.Cod_Producto 				AND
				Homepet_Producto.Cod_Producto = Factura_Producto.Cod_Producto
			GROUP BY Productos.Nombre
			ORDER BY Frecuencia_Venta ASC;
	-
	SERVICIO MAS USADO
		SELECT Servicios.Nombre, COUNT(Factura_Actividad.Cod_Servicio) Frecuencia_Pedido FROM Servicios, Homepets, Actividades_X_Homepet, Factura_Actividad
			WHERE Homepets.RIF = '' AND
				Homepets.RIF = Actividades_X_Homepet.RIF_Homepet AND
				Actividades_X_Homepet.Cod_Servicio = Factura_Actividad.Cod_Servicio AND
				Actividades_X_Homepet.Cod_Actividad = Factura_Actividad.Cod_Actividad
			GROUP BY Servicios.Nombre
			ORDER BY Frecuencia_Pedido DESC;
	-
	SERVICIO MENOS USADO
		SELECT Servicios.Nombre, COUNT(Factura_Actividad.Cod_Servicio) Frecuencia_Pedido FROM Servicios, Homepets, Actividades_X_Homepet, Factura_Actividad
			WHERE Homepets.RIF = '' AND
				Homepets.RIF = Actividades_X_Homepet.RIF_Homepet AND
				Actividades_X_Homepet.Cod_Servicio = Factura_Actividad.Cod_Servicio AND
				Actividades_X_Homepet.Cod_Actividad = Factura_Actividad.Cod_Actividad
			GROUP BY Servicios.Nombre
			ORDER BY Frecuencia_Pedido ASC;
	-
	HISTORIA DE SERVICIOS OFRECIDO A UNA MASCOTA
		SELECT Servicios.Nombre, Mascotas.Nombre, COUNT(Mascotas.Cod_Mascota) FROM Mascotas, Servicios, Orden_De_Uso
			WHERE Mascotas.Cod_Mascota = '' AND
				Mascotas.Cod_Mascota = Orden_De_Uso.Cod_Mascota AND
				Orden_De_Uso.Cod_Servicio = Servicios.Cod_Servicio
            GROUP BY Servicios.Nombre, Mascotas.Nombre;
	-
	Comparación entre los distintos HomePet: cual factura más/menos por servicios, por ventas
		SELECT Homepets.Nombre, COUNT(Facturas.Cod_Factura) AS Facturado FROM Homepets, Facturas, Factura_Producto, Homepet_Producto
			WHERE Homepets.RIF = Homepet_Producto.RIF AND
				Homepet_Producto.Cod_Producto = Factura_Producto.Cod_Producto AND
				Factura_Producto.Cod_Factura = Facturas.Cod_Factura
			GROUP BY Homepets.Nombre
			ORDER BY Facturado DESC;
	-
	CLIENTES QUE RESERVAN Y NO USAN EL SERVICIO
		SELECT Duenios.Cedula, Duenios.Nombre_Completo FROM Duenios, Ficha_Registro, Reservaciones, Reservaciones_Registro, Mascotas, Reservacion_Mascota
			WHERE Duenios.Cedula = Mascotas.Cedula_Duenio AND
				Mascotas.Cod_Mascota = Reservacion_Mascotas.Cod_Mascota AND
				Reservacion_Mascotas.Cod_Reserva <> Reservaciones_Registro.Cod_Reserva;
	-
	PROVEEDOR QUE NOS SUMINISTRA MAS PRODUCTOS
		SELECT Proveedores.RIF, Proveedores.Nombre, COUNT(Proveedor_Producto.Cod_Producto) AS Suministra FROM Proveedores, Proveedor_Producto
			WHERE Proveedores.RIF = Provveedores_Producto.RIF_Proveedor
		GROUP BY Proveedores.RIF, Proveedores.Nombre
		ORDER BY Suministra DESC;
	-
	PROVEEDOR QUE NOS SUMINISTRA MENOS PRODUCTOS
		SELECT Proveedores.RIF, Proveedores.Nombre, COUNT(Proveedor_Producto.Cod_Producto) AS Suministra FROM Proveedores, Proveedor_Producto
			WHERE Proveedores.RIF = Provveedores_Producto.RIF_Proveedor
		GROUP BY Proveedores.RIF, Proveedores.Nombre
		ORDER BY Suministra ASC;
	-
	FACTURAS POR PAGAR A PROVEEDORES
		SELECT Proveedores.RIF, Proveedores.Nombre, Homepets.Nombre, Productos.Nombre, SUM(Proveedor_Producto.Precio) AS Deuda FROM Facturas, Proveedores, Proveedor_Producto, Proveedor_Factura, Proveedor_Homepet, Productos, Homepets
			WHERE Faturas.Pagado = FALSE AND
				Facturas.Cod_Factura = Proveedor_Factura AND
				Proveedor_Factura.RIF_Proveedor = Proveedor.RIF AND
				Proveedor.RIF = Proveedor_Producto.RIF_Proveedor AND
				Proveedor_Producto.Cod_Producto = Producto.Cod_Producto AND
				Proveedor.RIF = Proveedor_Homepet.RIF_Proveedor AND
				Proveedor_Homepet.RIF_Homepet = Homepets.RIF
		GROUP BY Proveedores.RIF, Proveedores.Nombre, Homepets.Nombre, Productos.Nombre
		ORDER BY Deuda DESC;
	-

--


*/
-------------------------------------------------------------------------------------------------
