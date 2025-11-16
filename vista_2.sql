CREATE VIEW vw_UsuariosConRolesAsignados AS
SELECT
    U.id AS UsuarioID,
    U.nombre_usuario AS NombreUsuario,
    R.nombre_rol AS RolAsignado
FROM
    usuario U
INNER JOIN
    usuario_rol UR ON U.id = UR.usuario_id
INNER JOIN
    rol R ON UR.rol_id = R.id;
GO

