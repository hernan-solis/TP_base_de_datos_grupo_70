CREATE PROCEDURE sp_InsertHistorialEjercicio
    @alumno_rutina_dia_id INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO historial_ejercicio (
        alumno_id,
        ejercicio_base_id,
        fecha_rutina_dia,
        series,
        repeticiones,
        peso,
        observaciones,
        nombre_apellido_profesor,
        titulo_rutina_alumno
    )
    SELECT 
        ra.alumno_id,
        ea.ejercicio_base_id,
        ard.fecha,
        ea.series,
        ea.repeticiones,
        ea.peso,
        ard.observaciones,
        CONCAT(p_prof.nombre, ' ', p_prof.apellido),
        ra.titulo
    FROM alumno_rutina_dia ard
    INNER JOIN rutina_alumno ra ON ra.id = ard.rutinaid
    INNER JOIN profesor prof ON prof.id = ra.profesor_id
    INNER JOIN persona p_prof ON p_prof.id = prof.persona_id
    INNER JOIN ejercicio_asignado ea ON ea.rutina_dia_id = ard.id
    WHERE ard.id = @alumno_rutina_dia_id;
END
GO
