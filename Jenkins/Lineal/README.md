# Jenkins Pipeline para Pruebas Cypress (Single Thread)

Este pipeline implementa un flujo de trabajo en Jenkins para ejecutar pruebas automatizadas de Cypress utilizando un solo hilo. Aunque la configuración permite ejecutar pruebas en paralelo con herramientas como `cypress-parallel`, **no es viable debido a la necesidad de generar distintos tokens para diferentes usuarios**.

## **Problema Identificado**

> **[31mLimitación Crítica:** Este flujo de trabajo no es funcional en escenarios que requieren autenticación con tokens únicos por usuario. Como resultado, todas las pruebas utilizan un solo token (“TOKEN-RANDOM1”), lo que genera conflictos cuando se intenta ejecutar pruebas para múltiples usuarios.[0m

---

## Flujo del Pipeline

### 1. **Instalación de Dependencias**
El pipeline comienza verificando la existencia del archivo `package.json` e instalando las dependencias necesarias:

- Utiliza el comando `npm install` para instalar las dependencias del proyecto.
- Crea un directorio de reportes para almacenar resultados.

### 2. **Ejecución de Pruebas Cypress**
El pipeline intenta ejecutar todas las pruebas especificadas en el directorio `cypress/e2e/**/*.cy.js` utilizando `cypress-parallel`. Sin embargo, solo utiliza un token (“TOKEN-RANDOM1”) para todas las pruebas.

- Parámetros clave del comando:
  - `-s cy:run`: Especifica el script de ejecución definido en `package.json`.
  - `-t 2`: Utiliza 2 hilos para paralelizar las pruebas.
  - `-d 'cypress/e2e/**/*.cy.js'`: Define el directorio de pruebas.
  - `--reporter=cypress-mochawesome-reporter`: Configura el reporte en formato JSON.
  - `--env TOKEN=<token>`: Pasa el token de autenticación como variable de entorno.

### 3. **Generación y Publicación de Reportes**

- Los resultados de las pruebas se consolidan en un único archivo JSON utilizando **mochawesome-merge**.
- Se genera un reporte HTML con **marge**.
- Los reportes generados se archivan como artefactos en Jenkins y se publican como recurso descargable.

### 4. **Limpieza del Entorno**
Finalmente, el pipeline elimina los directorios y archivos temporales generados durante la ejecución.

---

## Limitaciones

1. **Uso de un solo token:**
   - El pipeline solo permite ejecutar pruebas con un token único.
   - Esto resulta en conflictos si las pruebas requieren múltiples tokens para diferentes usuarios.

2. **No Escalable:**
   - Aunque se utiliza `cypress-parallel`, la ejecución no se distribuye efectivamente debido a la limitación de los tokens.

---

## Soluciones Propuestas

- Implementar un mecanismo para generar y asignar un token único para cada usuario en tiempo de ejecución.
- Dividir las pruebas en etapas independientes para cada usuario, asignando un token único en cada etapa.
- Adaptar el pipeline para admitir paralelización tanto en Jenkins como en Cypress, asegurando que cada conjunto de pruebas tenga acceso a un token exclusivo.

---

## Requisitos

### Herramientas y Dependencias
- **Jenkins** con soporte para pipelines declarativos.
- **Node.js** y **npm** configurados en Jenkins.
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

## Conclusión

El flujo actual **no es viable** para escenarios en los que se requieren múltiples tokens de autenticación. Es necesario rediseñar el pipeline para garantizar una ejecución escalable y funcional. Hasta que esto se implemente, se recomienda evitar este flujo para pruebas distribuidas por usuario.

