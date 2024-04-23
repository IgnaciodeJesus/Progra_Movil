# Progra_Movil Entrega 1
Repositorio para el curso de Programacion Movil - APP de Cine

### Integrantes:
    - Alexander Cruz - 20192659
    - Franco Cuya - 20210773 
    - Ignacio Medina - 20191240
    - Angelo Medina - 20193065
    - Manuel Peña - 20191529
    - Bryan Ugas - 20212734

- [Introducción](#Introducción)
- [Diagrama de Despliegue](#Diagrama-de-Despliegue)
- [Requerimientos no Funcionales](#Requerimientos-no-Funcionales)
- [Diagrana de Casos de Uso](#Diagrana-de-Casos-de-Uso)
- [Descripción de los Casos de Uso y Mockups](#Descripción-de-los-Casos-de-Uso)
- [Diagrama de entidad-relación](#Diagrama-de-entidad-relación)
- [Fuentes](#Fuentes)


## Introducción

Esta una plataforma diseñada para ofrecer una experiencia cinematográfica completa, al estilo de lo que ofrecen las principales cadenas de cines. En esta fase del proyecto, nos enfocamos en crear una aplicación que permita a los usuarios comprar entradas y consultar las funciones disponibles desde la comodidad de sus dispositivos móviles. Con el objetivo de satisfacer las necesidades de los aficionados al cine, nuestro enfoque principal es brindar una experiencia fluida y atractiva que garantice la plena satisfacción del usuario.

---

## Diagrama de Despliegue

El diagrama de despliegue de nuestra aplicación móvil consta de dos nodos principales: el servidor Cine Data Center y el dispositivo Android donde se ejecuta la aplicación. En el Cine Data Center, se encuentra alojado el servidor que contiene dos componentes fundamentales: el backend desarrollado en Node.js con Express, responsable de gestionar las solicitudes del cliente, y la base de datos Cine.db implementada con SQLite3, utilizada para almacenar información relevante del sistema. Por otro lado, en el dispositivo Android, se ejecuta la aplicación móvil, denominada Cine App y desarrollada en Flutter, que proporciona la interfaz de usuario para que los usuarios puedan interactuar con la plataforma.

![diagrama_de_despliegue](/diagramas/DeploymentDiagram.jpg)
---

# Requerimientos No Funcionales

| Requerimiento No funcional | Código  | Justificación                                                                                                                        |
|----------------------------|---------|--------------------------------------------------------------------------------------------------------------------------------------|
| Rendimiento                | RNFR-001 | - **Tiempo de Respuesta**: El servidor debe manejar las solicitudes dentro de un marco de tiempo específico (por ejemplo, 2 segundos bajo carga normal). 
  |||- **Capacidad de Procesamiento**: El sistema debe ser capaz de manejar un número mínimo de transacciones por segundo, adecuado para la carga de usuarios esperada.  
  ||| - **Utilización de Recursos**: Asegurar el uso eficiente de recursos del servidor y de la red, manteniendo bajo uso de CPU y memoria para manejar cargas pico. |
|Escalabilidad| RNFR-002 | - **Manejo de Carga**: Capacidad para escalar recursos dinámicamente basado en el número de solicitudes, especialmente durante los tiempos pico de visualización de cine. 
  |||- **Escalabilidad de la Base de Datos**: Asegurar que la base de datos SQLite3 pueda manejar el crecimiento en volumen de datos sin degradación del rendimiento. 
  |Fiabilidad| RNFR-003|- **Disponibilidad**: Apuntar a métricas de alta disponibilidad para el servidor (por ejemplo, 99.9% de tiempo en línea) incluyendo estrategias robustas de failover.
  ||| - **Recuperación**: Implementar estrategias para una rápida recuperación de fallos de hardware y software, con soluciones de respaldo integrales para la integridad de los datos.
  |Seguridad| RNFR-004| - **Seguridad de Datos**: Cifrar datos sensibles en tránsito y en reposo, particularmente información del usuario y detalles de pagos.
  |||- **Control de Acceso**: Mecanismos robustos de autenticación y autorización para controlar el acceso del usuario a varias funcionalidades del sistema.
  |Mantenibilidad| RNFR-005| - **Modularidad**: El backend y la base de datos deben estar diseñados para un fácil mantenimiento y actualizaciones sin tiempo de inactividad del sistema.
  ||| - **Documentación**: Documentación completa del sistema incluyendo APIs, configuraciones del servidor y procedimientos de despliegue.
  ||| - **Manejo de Errores**: Mecanismos sistemáticos de registro y manejo de errores para facilitar la resolución de problemas y el mantenimiento.
  |Usabilidad | RNFR-006| - **Interfaz de Usuario**: La aplicación móvil debe ser intuitiva y fácil de navegar para todos los grupos de usuarios, adhiriendo a las mejores prácticas en diseño de UX móvil.
  ||| - **Responsive**: La aplicación debe ser compatible con una amplia gama de dispositivos Android, adaptándose a diferentes tamaños de pantalla y resoluciones.|




---

## Diagrama de Casos de Uso

---
![alt text](/images/Diagrama de Casos de Uso Oficial.png)

1. Como usuario quiero poder logearme en la aplicación.
2. Como usuario quiero poder registrarme como un usuario válido.
3. Como usuario quiero poder recuperar mi contraseña.
4. Como usuario, quiero ver una barra inferior donde tenga las opciones de elegir películas, salas, regresar al inicio y ver mi perfil.
5. Como usuario quisiera poder ver la lista de películas que el cine tiene disponible.
6. Como usuario quisiera poder filtrar las películas por su nombre.
7. Como usuario, luego de seleccionar una película, deseo poder ver información detallada de la película.
8. Como usuario debo poder ver las salas disponibles de la película seleccionada anteriormente.
9. Como usuario quisiera poder seleccionar una función de la sala que deseo asistir para poder reservar mi entrada.
10. Como usuario quisiera poder ver la lista de salas disponibles en el cine.
11. Como usuario quisiera poder filtrar las salas según su nombre.
12. Como usuario, luego de seleccionar una sala, deseo poder ver información detallada de la sala.
13. Como usuario deseo poder ver las películas que se pasan en esa sala, así como las funciones disponibles.
14. Como usuario deseo poder elegir mis asientos para asistir a la película.
15. Como usuario deseo poder ver mi entrada en formato QR para poder ingresar a la sala.
16. Como usuario deseo poder modificar mi foto de perfil.



## Descripción de los Casos de Uso y Mockups

- **Production_Figma** -> https://www.figma.com/file/POWMOa0fhxukU31Ssmec46/Prototipo-Progra-Movil?type=design&node-id=0%3A1&mode=design&t=UgnbuJFcglnSbsiP-1

- **Support_Figma** -> https://www.figma.com/file/gXQogV1ZWPkFq84viV40PF/Progra-Web-2024-0?type=design&node-id=9531-55806&mode=design&t=fVXnlkW5uOY4dRhf-0

---

## Diagrama de entidad-relación

![alt text](/images/relacional.png)

### Fuentes
[1] **[https://developer.android.com/studio?hl=es-419](https://developer.android.com/studio?hl=es-419)** <br>
[2] **[https://visualstudio.microsoft.com/es/](https://code.visualstudio.com/)** <br>
[3] **[https://inkscape.org/release/](https://inkscape.org/release/)**


