CREATE TRIGGER trg_alumno_rutina_dia_completado
ON alumno_rutina_dia
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id INT;

    SELECT @id = i.id
    FROM inserted i
    INNER JOIN deleted d ON i.id = d.id
    WHERE d.completado = 0 AND i.completado = 1;

    IF @id IS NOT NULL
    BEGIN
        EXEC dbo.sp_InsertHistorialEjercicio @alumno_rutina_dia_id = @id;
    END
END
GO
