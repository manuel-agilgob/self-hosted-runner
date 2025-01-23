# Jenkins Pipeline para Pruebas Cypress en Paralelo

Este pipeline implementa un flujo de trabajo en Jenkins para ejecutar pruebas automatizadas de Cypress en paralelo, combinando capacidades de paralelización nativa de Jenkins y la herramienta **cypress-parallel**. Esto permite maximizar el uso de recursos y reducir el tiempo total de ejecución.

## Características Principales

- **Ejecución Paralela con Jenkins**:
  - Divide las pruebas en diferentes "stages" que se ejecutan simultáneamente.

- **Ejecución Paralela con cypress-parallel**:
  - Utiliza `cypress-parallel` para subdividir aún más las pruebas dentro de cada stage.

- **Generación de Reportes Consolidados**:
  - Combina los resultados de pruebas en un único reporte HTML utilizando **mochawesome-merge** y **marge**.

- **Archivado y Publicación de Resultados**:
  - Archiva los reportes generados como artefactos en Jenkins.
  - Publica el reporte consolidado en la interfaz de Jenkins.

---

## Flujo del Pipeline

### 1. **Instalación de Dependencias**
El pipeline comienza instalando las dependencias definidas en el archivo `package.json`.

- Verifica la existencia del archivo `package.json`.
- Instala las dependencias necesarias utilizando `npm install`.
- Crea un directorio para reportes.

### 2. **Ejecución Paralela de Pruebas**
El pipeline ejecuta pruebas de Cypress organizadas por tipo de prueba (por ejemplo, "Actions", "Assertions" y "Location"):

- Cada tipo de prueba se ejecuta en un "stage" independiente.
- Dentro de cada stage, las pruebas se ejecutan en paralelo usando `cypress-parallel`.
- Parámetros clave de la ejecución:
  - `-s cy:run`: Especifica el script de ejecución en `package.json`.
  - `-t 2`: Número de threads para paralelizar las pruebas.
  - `-d 'ruta'`: Directorio donde están ubicados los archivos `.cy.js` de las pruebas.
  - `--reporter=cypress-mochawesome-reporter`: Define el reporter para generar resultados JSON detallados.
  - `--env TOKEN=<token>`: Pasa un token de autenticación como variable de entorno para las pruebas.

### 3. **Generación y Publicación de Reportes**

- Fusiona todos los resultados JSON generados durante las pruebas utilizando **mochawesome-merge**.
- Genera un reporte HTML consolidado con **marge**.
- Archiva los reportes generados como artefactos en Jenkins.
- Publica el reporte consolidado como un recurso descargable en la interfaz de Jenkins.

### 4. **Limpieza del Entorno**
Elimina los directorios y archivos generados al finalizar la ejecución para mantener el entorno limpio.

---

## Parametrización

Aunque este pipeline no incluye parámetros explícitos, se pueden añadir para aumentar la flexibilidad, por ejemplo:

- **Número de threads para cypress-parallel:** Controlar el número de hilos usados para paralelización en cada etapa.
- **Rutas de pruebas personalizadas:** Especificar directorios dinámicos según el entorno o tipo de pruebas.
- **Tokens dinámicos:** Generar tokens automáticamente para cada tipo de prueba.

---

## Requisitos

### Herramientas y Dependencias
- **Jenkins** con soporte para pipelines declarativos.
- **Node.js** y **npm** configurados en Jenkins (ejemplo: `node23`).
- **Cypress** y **cypress-parallel** instalados en el proyecto.
- **Plugins de Jenkins**:
  - HTML Publisher.

### Scripts necesarios
En el archivo `package.json`, se debe definir un script de Cypress:
```json
{
  "scripts": {
    "cy:run": "cypress run"
  }
}
```

---

## Ejecución del Pipeline

1. Configura Jenkins para ejecutar el pipeline.
2. Asegúrate de que las dependencias necesarias estén instaladas (Cypress, mochawesome, etc.).
3. Inicia el pipeline desde Jenkins.
4. Monitorea la ejecución en tiempo real y revisa los resultados consolidados en la sección de reportes de Jenkins.

---

## Notas

- **Tokens de Autenticación:**
  Los tokens son simulados (`TOKEN-RANDOM1`, `TOKEN-RANDOM2`, etc.) en este pipeline, pero pueden ser reemplazados por valores dinámicos obtenidos de un sistema externo.

- **Paralelización:**
  La combinación de paralelización de Jenkins con `cypress-parallel` maximiza la eficiencia del pipeline.

- **Errores y Depuración:**
  Si alguna prueba falla, revisa los reportes JSON generados y los logs de Jenkins para identificar el problema.

---

## Contacto
Para soporte o contribuciones, por favor contacta al administrador del proyecto o abre un issue en el repositorio correspondiente.

