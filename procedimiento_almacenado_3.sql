CREATE PROCEDURE sp_EliminarAlumnoInactivo
    @AlumnoID INT
AS
BEGIN

    DECLARE @TieneHistorial BIT;
    DECLARE @CompletoRutinaUltimos30Dias BIT;
    DECLARE @PersonaID INT;

    --  Verificar si el alumno tiene algún registro en historial_ejercicio
    IF EXISTS (SELECT 1 FROM historial_ejercicio WHERE alumno_id = @AlumnoID)
        SET @TieneHistorial = 1;
    ELSE
        SET @TieneHistorial = 0; 

    --  Verificar si el alumno completó alguna rutina_dia en los últimos 30 dias
    IF EXISTS (
        SELECT 1 
        FROM alumno_rutina_dia ard
        INNER JOIN rutina_alumno ra ON ard.rutinaid = ra.id
        WHERE ra.alumno_ID = @AlumnoID
        AND ard.completado = 1 
        AND ard.fecha >= DATEADD(day, -30, GETDATE()) 
    )
        SET @CompletoRutinaUltimos30Dias = 1;
    ELSE
        SET @CompletoRutinaUltimos30Dias = 0; 


    
    SELECT @PersonaID = persona_id FROM alumno WHERE id = @AlumnoID;


    -- Eliminación solo si NO tiene Historial o NO completó rutina en los últimos 30 días
    IF @TieneHistorial = 0 OR @CompletoRutinaUltimos30Dias = 0
    BEGIN
        
        IF @PersonaID IS NULL
        BEGIN
            SELECT 'Fallo: El AlumnoID proporcionado no existe en la tabla alumno.' AS Resultado;
            RETURN;
        END

      
        
        -- Eliminar registros dependientes de rutina_alumno y alumno_rutina_dia
        DELETE FROM ejercicio_asignado
        WHERE rutina_dia_id IN (
            SELECT id FROM alumno_rutina_dia 
            WHERE rutinaid IN (SELECT id FROM rutina_alumno WHERE alumno_ID = @AlumnoID)
        );

        DELETE FROM alumno_rutina_dia
        WHERE rutinaid IN (SELECT id FROM rutina_alumno WHERE alumno_ID = @AlumnoID);

        DELETE FROM rutina_alumno
        WHERE alumno_ID = @AlumnoID;

        --. Eliminar el usuario asociado (si existe)
        DELETE FROM usuario_rol
        WHERE usuario_id IN (SELECT id FROM usuario WHERE persona_id = @PersonaID);

        DELETE FROM usuario
        WHERE persona_id = @PersonaID;

        --. Eliminar el registro de alumno
        DELETE FROM alumno
        WHERE id = @AlumnoID;
        
        --  Eliminar a la persona (SOLO si no es también profesor)
        IF NOT EXISTS(SELECT 1 FROM profesor WHERE persona_id = @PersonaID)
        BEGIN
            DELETE FROM persona
            WHERE id = @PersonaID;
        END

        
        SELECT 'Éxito: El alumno y sus datos asociados fueron eliminados debido a inactividad o falta de historial.' AS Resultado;
    END
    ELSE
    BEGIN
        
        SELECT 'Fallo: El alumno NO puede ser eliminado. Tiene historial Y completó rutinas en los últimos 30 días.' AS Resultado;
    END
END
GO