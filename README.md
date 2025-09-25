# Pokedex

Proyecto: Pokedex

## Descripción

Aplicación Flutter que consume una API de Pokémon para mostrar una lista de Pokémon, detalle por Pokémon y la gestión de favoritos (persistidos localmente).

Este repositorio fue refactorizado para mejorar la legibilidad y la UX: se separaron responsabilidades en cubits más pequeños, se añadió cache de imágenes y se mejoró la experiencia del botón de favoritos.

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
- cached_network_image — cache y placeholders para imágenes remotas

Dev dependencies relevantes:

- flutter_test — pruebas unitarias/widget
- flutter_lints — reglas de lint
- injectable_generator, build_runner, envied_generator — generación de código

## Arquitectura utilizada

La app está organizada en capas (limpia/hexagonal ligera):

- Presentation: pantallas, widgets (UI)
- Application: Cubits (separación de responsabilidades)

  - `PokemonListCubit`: maneja la lista de Pokémon (paginación, filtros, ordenamiento y acumulador de items).
  - `PokemonFavoriteCubit`: maneja la lista de favoritos (carga silenciosa, añadir/quitar favorito, manejo de favoritos en memoria).
  - `PokemonDetailCubit`: maneja la carga del detalle de un Pokémon.

  Esta separación facilita la mantenibilidad y permite que widgets como el botón de favorito consuman solo el estado necesario.

- Domain: UseCases y Entities (GetList, GetDetail, GetFavorites, Insert/Delete Favorite)
- Data: RepositoryImpl, RemoteDataSource (API) y LocalDataSource (DB), modelos y mapeos
- Core: servicios compartidos (NetworkService con Dio, DatabaseService con sqflite), DI con `injectable`

## Cambios relevantes recientes

- Se separó el monolito `PokemonCubit` en tres cubits: `PokemonListCubit`, `PokemonFavoriteCubit` y `PokemonDetailCubit`.
- `cached_network_image` fue integrado para cachear sprites y mejorar la carga de imágenes.
- `FavoriteButtonWidget` fue refactorizado: ahora muestra un spinner mientras procesa, aplica una actualización optimista local y se sincroniza con el bloc vía `BlocSelector` para evitar desincronizaciones.
- Se añadieron tests unitarios focalizados para los cubits principales (list, favorites, detail).

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

## Comandos útiles para desarrolladores

- Ejecutar linter/analizador:

```bash
flutter analyze
```

- Ejecutar tests:

```bash
flutter test
```

- Regenerar código (injectable/envied):

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Notas y recomendaciones

- Permisos: el permiso `INTERNET` está incluido para Android y la configuración ATS está preparada para iOS.
- CI: se recomienda agregar un pipeline que ejecute `flutter analyze`, `flutter pub run build_runner build --delete-conflicting-outputs` y `flutter test` para evitar regresiones.
- Testing: se añadieron tests focalizados para cubits; se recomienda ampliar cobertura a repositorios y use-cases (mockeando Dio/sqflite).

## Buenas prácticas y próximos pasos sugeridos

- Mover la lógica de obtención/transformación (por ejemplo, obtener el Pokémon por id) al cubit o a un use-case cuando sea posible para mantener los widgets delgados.
- Añadir widget tests para interacciones críticas (p. ej. el `FavoriteButtonWidget` que compruebe el spinner, rollback y comportamiento optimista).
- Implementar un CacheManager personalizado si necesitas controlar TTL y tamaño del caché de imágenes.
- Añadir i18n (package `intl`) para soportar múltiples idiomas y extraer mensajes del UI.

## Pendientes por hacer

- Mostrar cadena evolutiva (etapas de evolución) y navegación entre ellas.

## Contacto

Para dudas o propuestas, abrir un issue o PR en este repositorio.
