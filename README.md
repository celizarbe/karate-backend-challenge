# Reto de Automatización QA Backend – Karate DSL

## Descripción General

Este proyecto contiene la automatización de pruebas para una API REST utilizando **Karate DSL**.

Se validan operaciones CRUD sobre el recurso `users`, incluyendo casos positivos y negativos, validación de esquemas JSON, manejo adecuado de datos de prueba y organización estructurada de los archivos feature.

---

## Tecnologías Utilizadas

- Java 17
- Maven
- Karate DSL
- JUnit 5

---

## Cómo Ejecutar el Proyecto

1. Clonar el repositorio.
2. Ejecutar el siguiente comando en la raíz del proyecto:

```bash
mvn clean test
```

3. El reporte HTML se generará automáticamente en `target/karate-reports/karate-summary.html`

---

## Estructura del Proyecto
```
src/test/java
├── features
│ ├── usuarios
│ │ ├── get-users.feature
│ │ ├── get-user-by-id.feature
│ │ ├── create-user.feature
│ │ ├── update-user.feature
│ │ ├── delete-user.feature
│ │ └── user-regression.feature
│ └── schemas
│ └── user-schema.json
├── runners
│ └── TestRunner.java
└── karate-config.js
```

### Organización:

- **usuarios/** → Contiene los escenarios CRUD del recurso.
- **schemas/** → Contiene definiciones reutilizables de esquemas JSON.
- **karate-config.js** → Configuración centralizada.
- **TestRunner** → Ejecuta la suite completa con Maven.

---

## Cobertura de Pruebas

Se automatizaron los siguientes endpoints:

- GET /users
- GET /users/{id}
- POST /users/add
- PUT /users/{id}
- DELETE /users/{id}

La suite incluye:

- Casos positivos
- Casos negativos (404 y payload inválido)
- Validación de esquema JSON reutilizable
- Validación de tiempos de respuesta
- Escenario de regresión

---

## Estrategia de Automatización y Patrones Utilizados

### 1️. Configuración Centralizada
Se utilizó `karate-config.js` para definir:
- URL base
- Headers globales (`Content-Type: application/json`)
- Timeouts de conexión y lectura

Esto evita duplicación y facilita mantenimiento.

### 2️. Reutilización de Esquemas
Se definió un archivo `user-schema.json` para validar estructura de respuestas sin repetir validaciones campo por campo.

Esto mejora:
- Legibilidad
- Mantenibilidad
- Escalabilidad

### 3️. Organización por Dominio
Los archivos feature están organizados por recurso (`usuarios`), separando responsabilidades y facilitando la navegación del proyecto. Para otros recursos (microservicios) se crearían directorios separados.

### 4️. Separación de Casos Positivos y Negativos
Se implementaron:
- Flujos exitosos (@smoke-test)
- Escenarios negativos (@negative-test)
- Escenario de regresión (@regression)

Esto permite ejecución selectiva mediante tags.

### 5️. Manejo de Datos de Prueba
- Se utilizaron variables para los request bodies.
- Se evitó dependencia de datos generados dinámicamente que pudieran afectar la estabilidad de la suite.
- Se utilizó un ID existente para pruebas de actualización y eliminación, garantizando ejecución estable.
- Se evitó el uso de datos aleatorios que pudieran generar resultados no reproducibles entre ejecuciones.

---

## Ejecución por Tags

Ejecutar regresión básica:

```mvn test -Dkarate.options="--tags @regression"```

Ejecutar solo pruebas de humo:

```mvn test -Dkarate.options="--tags @smoke-test"```

Ejecutar solo casos negativos:

```mvn test -Dkarate.options="--tags @negative-test"```

Ejecutar solo casos por feature:

```mvn test -Dkarate.options="--tags @listar-usuario"```

```mvn test -Dkarate.options="--tags @crear-usuario"```

```mvn test -Dkarate.options="--tags @actualizar-usuario"```

```mvn test -Dkarate.options="--tags @eliminar-usuario"```

```mvn test -Dkarate.options="--tags @obtener-usuario-por-id"```