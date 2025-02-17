# Arquitectura de la Aplicación de Pokemon

La arquitectura de esta aplicación ha sido diseñada para ser modular y escalable, adoptando el enfoque de **Clean Architecture** para la separación clara de capas y utilizando **MVVM** en la capa de presentación. Este diseño asegura una división bien definida entre la interfaz de usuario, la lógica de negocio y la gestión de datos, lo que facilita tanto el mantenimiento como la realización de pruebas y la expansión de la app a futuro.

## Demo

[Ver Video Demo]([https://drive.google.com/file/d/13Uw3wPM6LGxSCzhS1Gulu1eYjaXkNJSz/view?usp=sharing](https://drive.google.com/file/d/1lvSD_Li2f7IWdVHf3jFkZSMdiZ3rcbTi/view?usp=sharing](https://drive.google.com/file/d/1lvSD_Li2f7IWdVHf3jFkZSMdiZ3rcbTi/view))

## Persistencia de Datos y Librerías Empleadas

La **persistencia de datos** en la aplicación se gestiona a través de **Core Data** en la capa de **Data**, alineándose con los principios de **Clean Architecture**. Core Data se utiliza para almacenar los datos de las películas localmente, lo que garantiza que la aplicación siga funcionando eficientemente incluso sin conexión a Internet.

## Gestión de Dependencias con Swift Package Manager (SPM)

Para la gestión de dependencias, se ha utilizado **Swift Package Manager (SPM)**, lo que facilita la integración y mantenimiento de librerías de terceros de forma sencilla y sin requerir herramientas externas adicionales.

### Librerías Utilizadas

- **Alamofire**: Esta librería se emplea para gestionar las solicitudes de red y servicios RESTful. Alamofire facilita la comunicación con el servidor para obtener datos relacionados con las películas, tales como detalles, imágenes, etc. Su implementación simplifica las solicitudes HTTP y la gestión de respuestas en formato JSON.
  
- **SDWebImage**: Se utiliza para la carga y almacenamiento en caché de imágenes de manera eficiente. SDWebImage permite cargar imágenes de forma asíncrona desde la web, almacenándolas en caché para mejorar la experiencia del usuario al reducir los tiempos de carga y optimizar el uso de memoria.

## Pruebas Unitarias
La aplicación cuenta con **pruebas unitarias** implementadas para los **ViewModels**, los cuales tienen la responsabilidad principal de proporcionar datos y lógica de presentación a la vista.
