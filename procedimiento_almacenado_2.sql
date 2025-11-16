CREATE PROCEDURE ListarProfesoresPorEspOTit
    @Especialidad VARCHAR(30) = NULL,
    @Titulo VARCHAR(255) = NULL
AS
BEGIN
   SELECT
        p.id AS ProfesorID,
        pr.nombre AS Nombre,
        pr.apellido AS Apellido,
        pr.email AS Email,
        pr.telefono AS Teléfono,
        p.especialidad AS Especialidad,
        p.titulo AS Título,
        p.inicio_actividades AS InicioActividades
    FROM
        profesor p
    INNER JOIN
        persona pr ON p.persona_id = pr.id
    WHERE
        -- Filtra por Especialidad si el parámetro NO es NULL
        (@Especialidad IS NULL OR p.especialidad = @Especialidad)
        AND
        -- Filtra por Título si el parámetro NO es NULL
        (@Titulo IS NULL OR p.titulo LIKE '%' + @Titulo + '%')
    ORDER BY
        pr.apellido, pr.nombre;
END
GO