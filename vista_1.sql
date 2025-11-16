CREATE VIEW vw_CargaAlumnosProfesor AS
SELECT
    P.id AS ProfesorID,
    PE.nombre AS NombreProfesor,
    PE.apellido AS ApellidoProfesor,
    P.especialidad AS Especialidad,
    COUNT(RA.alumno_id) AS CantidadAlumnosAsignados
FROM
    profesor P
INNER JOIN
    persona PE ON P.persona_id = PE.id      
LEFT JOIN
    rutina_alumno RA ON P.id = RA.profesor_id 
GROUP BY
    P.id, PE.nombre, PE.apellido, P.especialidad;
GO