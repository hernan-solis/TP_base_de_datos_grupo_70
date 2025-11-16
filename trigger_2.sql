CREATE TRIGGER tr_AsignarProfesorYCrearRutina
ON alumno
AFTER INSERT
AS
BEGIN

    DECLARE @ProfesorAsignadoID INT;

    SELECT TOP 1 @ProfesorAsignadoID = P.id
    FROM profesor P
    LEFT JOIN rutina_alumno RA ON P.id = RA.profesor_ID
    GROUP BY P.id
    ORDER BY COUNT(RA.alumno_ID) ASC, P.id ASC; 

    
    INSERT INTO rutina_alumno (alumno_ID, profesor_ID, titulo, descripcion, fecha_creacion, status)
    SELECT
        I.id,                      
        @ProfesorAsignadoID,       
        'Rutina Inicial',          
        'Rutina generada automáticamente tras la alta.',
        GETDATE(),
        0                          -- Status = 0 
    FROM
        inserted I;
END
GO