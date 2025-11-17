CREATE TRIGGER tr_Eliminar_Alumno on alumno
INSTEAD OF DELETE
AS
BEGIN
    -- 1. Soft Delete del alumno.
    UPDATE alumno
    SET active = 0
    WHERE id IN (SELECT id FROM deleted);

    -- 2. Limpiar los Ejercicios Asignados asociados 
    DELETE ejercicio_asignado

    WHERE rutina_dia_id IN (
        SELECT ard.id FROM alumno_rutina_dia ard
        WHERE ard.rutinaid IN (
            SELECT ra.id FROM rutina_alumno ra
            WHERE ra.alumno_id IN (SELECT id FROM deleted)
        )
    );

    -- 3. Limpiar los Días de Rutina asociados
    DELETE alumno_rutina_dia
    WHERE rutinaid IN (
        SELECT ra.id FROM rutina_alumno ra
        WHERE ra.alumno_id IN (SELECT id FROM deleted)
    );

    -- 4. Limpiar la tabla de Rutina asociados
    DELETE rutina_alumno
    WHERE alumno_id IN (SELECT id FROM deleted);

END