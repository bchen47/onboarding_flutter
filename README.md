# Contenido
Ejercicio de onboarding, este consistía en crear un aplicativo que permitiera registrar/loguearse contra la API. Una vez dentro de la aplicación, habrá un home con varias pestañas:

- Home
    - Exploración de clases
        - Detalle de las clases
        - Reproducción de las clases (No funciona por el mockeado)
    - Exploración de recetas
        - Detalle de las recetas
- Perfil
    - Resumen de los datos del usuario
    - Modificación de los datos del usuario 
- Sensei
- Recetas
- Social

De estas pestañas solo se requería implementar la funcionalidad de Home y Perfil.


# Estructura del proyecto

```
├───assets #contiene los recursos del proyecto
├───lib #contiene la parte lógica del proyecto
│   ├───blocs #contiene todo lo relacionado a la gestión de los estados del proyecto, se podría considerar como el controller
│   ├───models #contiene la lógica de negocio de la aplicación
│   ├───repository # contiene las peticiones a los repositorios
│   │   └───interceptor # contiene las peticiones mockeadas
│   ├───screens # contiene lo relacionado a las interfaces
│   ├───utils # clases de utilidad usadas en toda la aplicación
│   └───validators # reglas de validación de los formularios
└───web # contiene lo relacionado al reproductor de vídeo (Por el mockeado de los datos no funciona) 
```
# Dependencias del proyecto

```
  cupertino_icons: ^1.0.2 #paquete de iconos
  flutter_bloc: ^7.3.2 # gestión del estado de la aplicación
  formz: ^0.4.0 # control de errores en formularios
  equatable: ^2.0.0 # permite equiparar objetos de forma más sencilla
  http: ^0.13.4 # Cliente web para realizar peticiones a la API
  json_api: ^5.0.5 # Facilita la deserialización y serialización de JSON
  fluttertoast: ^8.0.8 # Permite mostrar toast
  shared_preferences: ^2.0.8 # Gestión de preferencias de usuario en local
  carousel_slider: ^4.0.0 # Para el carrousel  de imagenes
  cached_network_image: ^3.1.0+1 # Gestiona las imágenes en caché para la optimización de imagenes descargadas.
  path_provider: ^2.0.7 # permite acceder a directorios
  dio: ^4.0.6 #Cliente web que permite interceptar peticiones http
```