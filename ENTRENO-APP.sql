CREATE DATABASE ENTRENOAPP;
GO

USE ENTRENOAPP;
GO

-----------------------------------------------------------
-- PERSONA
-----------------------------------------------------------
CREATE TABLE persona (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telefono VARCHAR(50),
    fecha_nac DATE,
    genero VARCHAR(30) NOT NULL 
        CHECK (genero IN ('femenino', 'masculino', 'prefiero-no-decir'))
);

-----------------------------------------------------------
-- ALUMNO
-----------------------------------------------------------
CREATE TABLE alumno (
    id INT IDENTITY(1,1) PRIMARY KEY,
    persona_id INT NOT NULL UNIQUE 
        FOREIGN KEY REFERENCES persona(id),
    objetivos VARCHAR(500),
    lesiones VARCHAR(500),
    condicion_medica VARCHAR(500),
    fecha_fin_suscripcion DATE,
    active BIT DEFAULT 1
);

-----------------------------------------------------------
-- PROFESOR
-----------------------------------------------------------
CREATE TABLE profesor (
    id INT IDENTITY(1,1) PRIMARY KEY,
    persona_id INT NOT NULL UNIQUE 
        FOREIGN KEY REFERENCES persona(id),
    especialidad VARCHAR(30)
        CHECK (especialidad IN ('fuerza','hipertrofia','funcional','crossfit','otro')),
    titulo VARCHAR(255),
    inicio_actividades DATE
);

-----------------------------------------------------------
-- USUARIO
-----------------------------------------------------------
CREATE TABLE usuario (
    id INT IDENTITY(1,1) PRIMARY KEY,
    persona_id INT NOT NULL UNIQUE 
        FOREIGN KEY REFERENCES persona(id),
    nombre_usuario VARCHAR(255) NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    fecha_alta DATE NOT NULL
);

-----------------------------------------------------------
-- ROL
-----------------------------------------------------------
CREATE TABLE rol (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre_rol VARCHAR(255) NOT NULL UNIQUE
);

-----------------------------------------------------------
-- USUARIO_ROL
-----------------------------------------------------------
CREATE TABLE usuario_rol (
    usuario_id INT NOT NULL,
    rol_id INT NOT NULL,
    PRIMARY KEY (usuario_id, rol_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (rol_id) REFERENCES rol(id)
);

-----------------------------------------------------------
-- EJERCICIO_BASE
-----------------------------------------------------------
CREATE TABLE ejercicio_base (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255),
    url VARCHAR(500)
);

-----------------------------------------------------------
-- RUTINA_ALUMNO
-----------------------------------------------------------
CREATE TABLE rutina_alumno (
    id INT IDENTITY(1,1) PRIMARY KEY,
    alumno_id INT NOT NULL FOREIGN KEY REFERENCES alumno(id),
    profesor_id INT NOT NULL FOREIGN KEY REFERENCES profesor(id),
    titulo VARCHAR(100),
    descripcion VARCHAR(500),
    fecha_creacion DATE NOT NULL DEFAULT GETDATE(),
    status BIT DEFAULT 0
);

-----------------------------------------------------------
-- ALUMNO_RUTINA_DIA
-----------------------------------------------------------
CREATE TABLE alumno_rutina_dia (
    id INT IDENTITY(1,1) PRIMARY KEY,
    rutinaid INT NOT NULL FOREIGN KEY REFERENCES rutina_alumno(id),
    dia_semana SMALLINT NOT NULL CHECK (dia_semana BETWEEN 1 AND 7),
    fecha DATETIME NOT NULL,
    observaciones VARCHAR(500),
    completado BIT NOT NULL DEFAULT 0
);

-----------------------------------------------------------
-- EJERCICIO_ASIGNADO
-----------------------------------------------------------
CREATE TABLE ejercicio_asignado (
    id INT IDENTITY(1,1) PRIMARY KEY,
    rutina_dia_id INT NOT NULL UNIQUE 
        FOREIGN KEY REFERENCES alumno_rutina_dia(id),
    ejercicio_base_id INT NOT NULL 
        FOREIGN KEY REFERENCES ejercicio_base(id),
    series INT,
    repeticiones INT,
    peso DECIMAL(10,2),
    url VARCHAR(500),
    notas_profesor VARCHAR(300)
);

-----------------------------------------------------------
-- HISTORIAL_EJERCICIO
-----------------------------------------------------------
CREATE TABLE historial_ejercicio (
    id INT IDENTITY(1,1) PRIMARY KEY,
    alumno_id INT NOT NULL FOREIGN KEY REFERENCES alumno(id),
    ejercicio_base_id INT NOT NULL FOREIGN KEY REFERENCES ejercicio_base(id),
    fecha_rutina_dia DATE NOT NULL,
    series INT NOT NULL,
    repeticiones INT NOT NULL,
    peso DECIMAL(10,2) NOT NULL,
    observaciones VARCHAR(300),
    nombre_apellido_profesor VARCHAR(60) NOT NULL,
    titulo_rutina_alumno VARCHAR(255) NOT NULL
);
