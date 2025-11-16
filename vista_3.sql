CREATE VIEW VW_LISTAPROFALU AS
SELECT 
    -- COLUMNAS PROFESOR
    perPro.nombre AS ProfNombre,
    perPro.apellido AS ProfApellido,
    p.titulo AS ProfTitulo,
    perPro.telefono AS ProfTelefono,
    perPro.email AS ProfEmail,

    -- COLUMNAS ALUMNO
    perAlu.nombre AS AluNombre,
    perAlu.apellido AS AluApellido,
    DATEDIFF(YEAR, perAlu.fecha_nac, GETDATE()) AS AluEdad,
    perAlu.telefono AS AluTelefono,
    perAlu.email AS AluEmail,
	a.fecha_fin_suscripcion as AluFinSus

	--TABLA PUENTE
FROM rutina_alumno ra

	-- ENLASA EL PUENTE CON EL PROFE MAS DATOS PERSONALES DEL PROF
INNER JOIN profesor p 
    ON ra.profesor_id = p.id
INNER JOIN persona perPro
    ON p.persona_id = perPro.id

	-- ENLASA EL PUENTE CON EL ALU MAS DATOS PERSONALES DEL ALU
INNER JOIN alumno a
    ON ra.alumno_id = a.id
INNER JOIN persona perAlu
    ON a.persona_id = perAlu.id

--FILTRO: SOLO SI ALU ESTA ACTIVO
WHERE a.active = 1;
