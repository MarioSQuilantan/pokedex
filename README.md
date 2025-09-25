# Pokedex

Proyecto: Pokedex

## Descripción

Aplicación Flutter que consume una API de Pokémon para mostrar una lista de Pokémon, detalle por Pokémon y la gestión de favoritos (persistidos localmente).

## Versión

- Flutter 3.35.1

## Paquetes principales usados

- flutter_bloc — state management (Cubit)
- get_it, injectable — inyección de dependencias
- dio — cliente HTTP
- fpdart — tipos funcionales (TaskEither, etc.)
- go_router — navegación
- equatable — comparaciones en entidades/estados
- envied — manejo de variables de entorno
- camera — acceso a cámara (se usa en el proyecto)
- sqflite — almacenamiento local (favoritos)
- path_provider, path — utilidades de archivos

Dev dependencies relevantes:

- flutter_test — pruebas unitarias/widget
- flutter_lints — reglas de lint
- injectable_generator, build_runner, envied_generator — generación de código

## Arquitectura utilizada

La app está organizada en capas (limpia/hexagonal ligera):

- Presentation: pantallas, widgets (UI)
- Application: Cubits (separación de responsabilidades)

  - `PokemonListCubit`: maneja la lista de Pokémon (paginación, filtros, ordenamiento y acumulador de items).
  - `PokemonFavoriteCubit`: maneja la lista de favoritos (carga silenciosa, añadir/quitar favorito, estado local optimista).
  - `PokemonDetailCubit`: maneja la carga del detalle de un Pokémon.

  Esta separación facilita la mantenibilidad y permite que widgets como el botón de favorito consuman solo el estado necesario.

- Domain: UseCases y Entities (GetList, GetDetail, GetFavorites, Insert/Delete Favorite)
- Data: RepositoryImpl, RemoteDataSource (API) y LocalDataSource (DB), modelos y mapeos
- Core: servicios compartidos (NetworkService con Dio, DatabaseService con sqflite), DI con `injectable`

## Cómo ejecutar la app

1. Instala dependencias:

```bash
flutter pub get
```

2. Ejecuta en un dispositivo/emulador conectado:

```bash
flutter run
flutter run -d <deviceId>
```

Nota: para Android asegúrate de tener un emulador Android o un dispositivo USB; para iOS, Xcode y un simulador o dispositivo.

## Comandos para correr los tests

- Ejecutar todos los tests:

```bash
flutter test
```

## Notas útiles

- Los permisos de red ya se agregaron para Android (`INTERNET`) y iOS (ATS configurado) en caso de usar API externas.
- Si usas generación de código (injectable, envied), vuelve a ejecutar:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Comentarios de desarrollador

- Se hicieron algunos ajuste respecto a lo solicitado ya que la API cambio o ya no cuenta con algunos valores que se solicitaron se sustituyeron por otro como la descripcion por los tipos
- En otros casos se descartaron como en la lista de Pokemon ya que los parametros ataque y defensa no se encuentran el filtro lo hace por nombre ascendente, descendente y por ID

## Pendientes por hacer

- Cadena evolutiva (mostrar las etapas y permitir navegar entre ellas).
