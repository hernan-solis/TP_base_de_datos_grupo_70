# Base de Datos del TP Integrador - Base de Datos II - UTN FRGP

Este proyecto contiene el diseño y la implementación de la base de datos utilizada en el Trabajo Práctico Integrador de la materia Base de Datos II.
Incluye la creación del esquema, inserción de datos semilla, procedimientos almacenados y triggers.

## 1. Script de Creación de Base de Datos

El archivo ENTRENO-APP.sql contiene:

Creación de la base de datos ENTRENOAPP

Creación de tablas principales:

persona

profesor

alumno

rutina_alumno

alumno_rutina_dia

ejercicio_base

ejercicio_asignado

historial_ejercicio

Definición de claves primarias, foráneas e índices.


##  2. Script de Inserción de Datos Semilla

El archivo SEMILLA-ENTRENOAPP.sql carga datos iniciales importantes para comenzar a usar el sistema:

Personas (Profesores y Alumnos)

Ejercicios base (peso muerto, sentadilla, espalda, pecho, etc.)

Rutinas de ejemplo asignadas a alumnos

Días de rutina (piernas, empuje, espalda, etc.)

Ejercicios asignados dentro de cada día

Estos datos permiten probar los procedimientos y triggers sin necesidad de cargar manualmente.



##  ⚙️ 3. Procedimientos Almacenados
### 🔹 sp_InsertHistorialEjercicio

- Archivo: procedimiento_almacenado_1.sql

Este procedimiento se ejecuta para registrar en historial_ejercicio todos los ejercicios completados por un alumno en un día determinado.

- Qué hace:

Recibe el ID de un registro de alumno_rutina_dia.

Busca la rutina, profesor, ejercicios y datos asociados.

Inserta en la tabla historial_ejercicio:

Alumno

Ejercicio base

Fecha del día de rutina

Series, repeticiones, peso

Observaciones

Profesor responsable

Título de la rutina

- Permite mantener un historial completo del avance del alumno, útil para reportes, análisis y progresión.

##  4. Triggers
###🔹 trg_alumno_rutina_dia_completado

 - Archivo: trigger_1.sql

-  Cuándo se ejecuta:

Después de un UPDATE en la tabla alumno_rutina_dia.

- Qué detecta:

Un cambio de estado:

completado: 0 → 1

Es decir: cuando el alumno marca un día de rutina como completado.

- Qué hace:

Obtiene el ID actualizado desde las tablas inserted y deleted.

Llama al procedimiento almacenado:

EXEC sp_InsertHistorialEjercicio @alumno_rutina_dia_id = X;

- Resultado:

Se registra automáticamente en historial_ejercicio la información del día completado y sus ejercicios.
