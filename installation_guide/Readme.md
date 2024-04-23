# Development Environment Setup (ง ͠ಥ_ಥ)ง

- [Entorno de Desarrollo](#Entorno-de-Desarrollo)
    - [Instalación de Android Studio](#Instalación-de-Android-Studio)
    - [Requermientos del Sistema](#Requermientos-del-Sistema)
    - [Pasos a seguir](#Pasos-a-seguir)
    - [Correr Android Studio](#Correr-Android-Studio)
    - [Instalar Flutter y Visual Studio Code](#Instalar-Flutter-y-Visual-Studio-Code)
    - [Instalar Inkscape](#Instalar-Inkscape)

---

## Entorno de Desarrollo
En este capítulo se mostraran los software que se usaran para el desarrollo del aplicativo
### Instalación de Android Studio
Android Studio es el entorno de desarrollo integrado (IDE) oficial para el desarrollo de aplicaciones de Android, basado en IntelliJ IDEA, se debe realizar la instalación de este software para luego poder configurar el entorno de **Flutter**, con el que se trabajara en este proyecto, y sus paquetes correspondientes. Antes de comenzar el proceso de instalación, descargue la última versión de [Android Studio] (https://developer.android.com/studio/).

### Requermientos del Sistema
- 3 GB RAM minimum, 8 GB RAM recommended
- 1280 x 800 minimum screen resolution
- Microsoft® Windows® 7/8/10 (32- or 64-bit)

### Pasos a seguir
1. Inicie android-studio.exe para iniciar el proceso de instalación. El instalador responde presentando el cuadro de diálogo Configuración de Android Studio como se muestra. Haga clic en **Siguiente** para ir a la pantalla del Dispositivo virtual Android (AVD).Darle **Siguiente** a los demás pasos.

![studio1](https://user-images.githubusercontent.com/34706326/54194875-48228e80-44e3-11e9-80df-b52831f74061.jpg)
![studio2](https://user-images.githubusercontent.com/34706326/54194593-9edb9880-44e2-11e9-89ca-b58912709cd3.jpg)

2. Al hacer clic en Mostrar detalles se muestran los nombres de los archivos que se están instalando y otras actividades. Cuando finaliza la instalación, aparece el panel Instalación completa. Para completar la instalación, deje marcada la casilla Iniciar Android Studio y haga clic en Finalizar.

![studio3](https://user-images.githubusercontent.com/34706326/54194597-9f742f00-44e2-11e9-8376-dc989faabcc3.jpg)
![studio4](https://user-images.githubusercontent.com/34706326/54194598-a00cc580-44e2-11e9-9c08-5bc5b9dd7cad.jpg)

### Correr Android Studio
---
1. La primera vez que se ejecuta Android Studio, presenta un cuadro de diálogo Instalación completa que ofrece la opción de importar 
configuraciones de una instalación anterior.

![studio6](https://user-images.githubusercontent.com/34706326/54205116-af4c3d00-44fb-11e9-8878-08e1a8a4b023.jpg)

2. Elija NO importar la configuración (la selección predeterminada) y haga clic en Aceptar, lo que le llevará a la siguiente pantalla de presentación:

![studio7](https://user-images.githubusercontent.com/34706326/54194599-a00cc580-44e2-11e9-8481-8006bfd88988.jpg)

3. Aparece un cuadro de mensaje que dice Encontrar componentes SDK disponibles.

![studio8](https://user-images.githubusercontent.com/34706326/54205045-8c218d80-44fb-11e9-800b-8b0a4990dfaa.jpg)

4. En este punto, Android Studio presenta el siguiente cuadro de diálogo del Asistente de configuración de Android Studio:

![studio9](https://user-images.githubusercontent.com/34706326/54193652-8d918c80-44e0-11e9-876f-2bd587bc8925.jpg)

5. Haga clic en Siguiente y el asistente le invitará a seleccionar un tipo de instalación. Mantenga la configuración Estándar predeterminada.

![studio10](https://user-images.githubusercontent.com/34706326/54193654-8e2a2300-44e0-11e9-84a0-722fb4242645.jpg)

6. Se abre una ventana Verificar configuración. Haga clic en Finalizar para comenzar el proceso de descarga de componentes SDK. En la siguiente ventana, Android Studio comienza el proceso de descarga de componentes SDK.


![studio11](https://user-images.githubusercontent.com/34706326/54193657-8ec2b980-44e0-11e9-9d97-b8ccbbc1f3ee.jpg)
![studio12](https://user-images.githubusercontent.com/34706326/54193658-8ec2b980-44e0-11e9-8feb-15367ac4217b.jpg)

7. Esta parte de la configuración puede tardar varios minutos en finalizar. Finalmente, haga clic en Finalizar para completar el asistente. Aparece el cuadro de diálogo Bienvenido a Android Studio.

![studio13](https://user-images.githubusercontent.com/34706326/54193661-8f5b5000-44e0-11e9-9ec6-a22ad471b5a0.jpg)
![studio14](https://user-images.githubusercontent.com/34706326/54213076-cf82f880-4509-11e9-8837-87ceb525161b.jpg)

### Instalar Flutter y Visual Studio Code
Para realizar la configuración de Flutter y Visual Studio Code, se debe seguir los siguientes pasos:

### Pasos a seguir

1. Instalar la aplicación de Visual Studio Code desde el siguiente enlace [Visual Studio Code](https://code.visualstudio.com/)

2. Luego darle **siguiente** a todo y marcar las opciones que se muestran en las imagenes
![studio15](https://support.academicsoftware.eu/hc/article_attachments/360007150337/mceclip2.png)
![studio16](https://www.sqlshack.com/wp-content/uploads/2020/07/set-additional-tasks.png)
![studio17](https://support.academicsoftware.eu/hc/article_attachments/360007150337/mceclip2.png)
![studio18](https://www.alexmilla.net/wp-content/uploads/2019/10/VSC_09.png)

3. Luego abriremos Visual Studio Code e instalaremos la extensión de Flutter
![studio19](https://www.syncfusion.com/blogs/wp-content/uploads/2021/06/Installing-Flutter-Extension-in-VS-Code-1.png)

4. Ahora instalaremos la extensión de [Flutter](https://flutter-ko.dev/get-started/install/windows), se recomienda crear una carpeta de nombre dev en el disco C y dentro de ella crear una carpeta de nombre flutter, luego descomprimir el archivo descargado en la carpeta flutter.

5. Luego configuraremos la variables de entorno para que se pueda ejecutar correctamente, por lo que se debe ir a la configuración del sistema y buscar la opción de variables de entorno, luego se debe buscar la variable **Path** y agregar la ruta de la carpeta **bin** de flutter.

![alt text](/images/propiedadesSistema.png)

![alt text](/images/ve1.png)

![alt text](/images/ve2.png)

6. Por úlitmo se debe abrir la terminal y ejecutar el comando **flutter doctor** para verificar que todo este correcto.

![alt text](/images/fd.png)

### Instalar Inkscape
Para crear los iconos de nuestro prototipo y el logo se usara la herramienta de diseño Inkscape, se debe descargar desde el siguiente enlace [Inkscape](https://inkscape.org/release/) y seguir los pasos de instalación, los cuales solo es presionar *siguiente* en todo.
Nota: También se usará Adobe Illustrator.

---