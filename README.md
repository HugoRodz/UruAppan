# UruAPPan - Estructura inicial

Proyecto inicial generado por plantilla para UruAPPan.

Incluye:
- Estructura mínima Flutter.
- Integración básica con Firebase (inicialización + servicios de Auth/Firestore).
- Rutas nombradas y pantallas vacías para cada sección requerida.

Cómo usar:
1. Instala dependencias: `flutter pub get`.
2. Conecta tu proyecto Firebase y añade los archivos de configuración para iOS/Android.
3. Ejecuta: `flutter run`.

Notas:
- Añade los archivos de configuración de Firebase para cada plataforma:
	- Android: `android/app/google-services.json`
	- iOS: `ios/Runner/GoogleService-Info.plist`

cd /Users/Gsrod/Documents/UruAppan
pwd
ls -lagrep -n "dependency_overrides" pubspec.yaml || echo "No hay dependency_overrides actualmente"