# Jenkins Pipeline para Ejecución Paralela de Pruebas Cypress

Este proyecto implementa un **pipeline de Jenkins** parametrizable y escalable para ejecutar pruebas automatizadas con Cypress en paralelo, optimizando el tiempo de ejecución y facilitando el manejo de reportes y notificaciones.

## Características Principales

- **Ejecución Paralela:** Permite ejecutar pruebas Cypress en paralelo mediante un número configurable de runners.
- **Parametrización:** Se pueden ajustar parámetros clave como:
  - Número de runners en paralelo.
  - Ruta de las pruebas de Cypress.
  - URL del repositorio de código.
  - Canal de Slack para notificaciones.
  - URL de un endpoint para la obtención de tokens de autenticación.
- **Generación de Reportes:** Consolida resultados en un reporte HTML detallado.
- **Notificaciones en Slack:** Envia notificaciones automáticas al canal de Slack configurado, incluyendo errores y resultados.
- **Gestor de Errores:** Maneja fallos en las pruebas y envía detalles de los mismos al canal de Slack.

## Flujo del Pipeline

1. **Clonación del Repositorio:**
   Se clona el repositorio de código desde la rama especificada en los parámetros.

2. **Instalación de Dependencias:**
   Instala las dependencias necesarias para ejecutar las pruebas Cypress.

3. **Generación y Ejecución de Stages Paralelos:**
   Divide las pruebas Cypress en diferentes runners y las ejecuta en paralelo por usuario.

4. **Generación de Reporte HTML:**
   Combina los resultados de las pruebas y genera un reporte consolidado en formato HTML.

5. **Publicación de Resultados:**
   - Archiva los reportes generados como artefactos de Jenkins.
   - Publica el reporte HTML en la interfaz de Jenkins.
   - Opcionalmente, sube el reporte al canal de Slack configurado.

## Parametrización

Los siguientes parámetros pueden configurarse al iniciar el pipeline:

| Parámetro            | Descripción                                                  | Valor por defecto                              |
|-----------------------|--------------------------------------------------------------|-----------------------------------------------|
| `NUMERO_DE_RUNNERS`  | Número de runners para ejecutar en paralelo                   | `3`                                           |
| `SLACK_CHANNEL`      | Canal de Slack para enviar notificaciones                     | `D087F46G2D9`                                 |
| `TOKEN_ENDPOINT`     | URL del endpoint para obtener tokens de autenticación         | `http://192.168.1.67:3000/token`              |
| `RUTA_PRUEBAS`       | Ruta de las pruebas de Cypress                                | `cypress/e2e`                                 |
| `GIT_REPOSITORY`     | URL del repositorio GIT donde se almacenan las pruebas        | `https://github.com/manuel-agilgob/self-hosted-runner.git` |
| `GIT_BRANCH`         | Rama del repositorio que se desea clonar                      | `*/parametrizable`                            |

## Detalles de Implementación

### 1. Obtención de Token
Se utiliza un endpoint para generar tokens de autenticación para cada usuario, enviando credenciales almacenadas como **Secret Text** en Jenkins.

### 2. Ejecución de Pruebas
Las pruebas Cypress se ejecutan utilizando el comando:
```bash
npx cypress run \
  --spec <ruta_del_spec> \
  --reporter cypress-mochawesome-reporter \
  --env TOKEN=<token>
```

### 3. Notificaciones de Errores
En caso de error, se envía una notificación detallada a Slack con información del spec que falló, el mensaje de error y el stack trace.

### 4. Generación de Reportes
Se genera un reporte consolidado utilizando las herramientas:
- **mochawesome-merge**: Fusiona resultados JSON.
- **marge**: Crea reportes en formato HTML.

### 5. Publicación de Resultados
- Los reportes se archivan como artefactos en Jenkins.
- El reporte HTML se publica y es accesible desde el dashboard del build.

## Requisitos

- **Jenkins** con soporte para pipelines.
- **Dependencias del sistema:**
  - Node.js / npm.
  - Cypress.
  - Plugins de Jenkins:
    - Pipeline
    - Slack Notification
    - HTML Publisher
- **Acceso a un canal de Slack** con un token de integración configurado.

## Ejecución
1. Configura los parámetros deseados al iniciar el pipeline.
2. Inicia el build en Jenkins.
3. Revisa el dashboard de Jenkins para consultar el estado del pipeline y los resultados.
4. Accede al reporte HTML desde Jenkins o Slack.

## Notas
- El pipeline es altamente parametrizable y puede ajustarse a diferentes entornos o necesidades de prueba.
- Los tokens generados para la autenticación son temporales y sólo se utilizan durante la ejecución del pipeline.

## Contribuciones
Si deseas contribuir o reportar un problema, por favor abre un issue o envía un pull request en el repositorio asociado.

## Contacto
Para dudas o soporte, por favor contacta a [manuel-agilgob](https://github.com/manuel-agilgob).

