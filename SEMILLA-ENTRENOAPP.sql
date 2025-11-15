INSERT INTO persona (nombre, apellido, email, telefono, fecha_nac, genero)
VALUES 
('Nicolás', 'Gómez', 'nico@gmail.com', '381111111', '1995-04-10', 'masculino'),
('Carla', 'Sosa', 'carla@gmail.com', '381222222', '1992-07-22', 'femenino'),
('Marcos', 'Rivas', 'marcos@gmail.com', '381333333', '1988-12-05', 'masculino'),
('Lucía', 'Benítez', 'lucia@gmail.com', '381444444', '2001-02-19', 'femenino');

INSERT INTO usuario (persona_id, nombre_usuario, contraseña, fecha_alta)
VALUES
(1, 'nico123', 'pass123', GETDATE()),
(2, 'carla22', 'pass456', GETDATE()),
(3, 'marcos88', 'pass789', GETDATE());

INSERT INTO rol (nombre_rol)
VALUES 
('admin'),
('profesor'),
('alumno');


INSERT INTO usuario_rol (usuario_id, rol_id)
VALUES
(1, 1), -- nico admin
(2, 2), -- carla profesora
(3, 3); -- marcos alumno


INSERT INTO profesor (persona_id, especialidad, titulo, inicio_actividades)
VALUES
(2, 'fuerza', 'Entrenadora Certificada', '2020-01-10');


INSERT INTO alumno (persona_id, objetivos, lesiones, condicion_medica, fecha_fin_suscripcion, active)
VALUES
(3, 'Bajar grasa y tonificar', 'Lumbalgia leve', 'Nada relevante', '2025-12-31', 1),
(4, 'Hipertrofia y fuerza', 'Ninguna', 'Asma leve', '2025-09-30', 1);

INSERT INTO ejercicio_base (nombre, descripcion, url)
VALUES
('Sentadilla', 'Sentadilla con peso corporal', NULL),
('Press banca', 'Press en banco plano', NULL),
('Remo con mancuerna', 'Remo unilateral', NULL),
('Plancha', 'Plancha isométrica', NULL);

INSERT INTO rutina_alumno (alumno_ID, profesor_ID, titulo, descripcion, fecha_creacion, status)
VALUES
(1, 1, 'Fuerza Nivel 1', 'Rutina inicial para fuerza', GETDATE(), 1),
(2, 1, 'Hipertrofia Avanzada', 'Rutina para aumento de masa muscular', GETDATE(), 1);


INSERT INTO alumno_rutina_dia (RutinaID, dia_semana, fecha, observaciones, completado)
VALUES
(1, 1, GETDATE(), 'Día de piernas', 0),
(1, 3, GETDATE(), 'Día de empuje', 0),
(2, 2, GETDATE(), 'Día de espalda', 0);


INSERT INTO ejercicio_asignado (rutina_dia_ID, ejercicio_base_ID, series, repeticiones, peso, url, notas_profesor)
VALUES
(1, 1, 4, 12, 0, NULL, 'Buena postura'),
(1, 4, 3, 45, 0, NULL, 'Mantener abdomen firme'),
(2, 2, 5, 8, 40, NULL, 'Progresar peso semanal'),
(3, 3, 4, 10, 15, NULL, 'Técnica correcta');

INSERT INTO historial_ejercicio (alumno_id, ejercicio_base_ID, fecha_rutina_dia, series, repeticiones, peso, observaciones, nombre_apellido_profesor, titulo_rutina_alumno)
VALUES
(1, 1, GETDATE(), 4, 12, 0, 'Primera sesión', 'Carla Sosa', 'Fuerza Nivel 1');



