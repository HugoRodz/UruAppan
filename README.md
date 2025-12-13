# UruAppan

UruAppan es una aplicación web construida con **Next.js (App Router)** y **PostgreSQL (Neon)** cuyo objetivo es centralizar y publicar información pública del municipio de **Uruapan**, como trámites, oficios, categorías y anuncios, en una plataforma clara y accesible para la ciudadanía.

Este proyecto está pensado como un **MVP escalable**, con una separación clara entre el área pública y el panel administrativo.

---

## 🧭 Objetivo del proyecto

- Centralizar trámites y servicios municipales
- Facilitar el acceso a información pública actualizada
- Ofrecer una estructura clara y mantenible para crecimiento futuro
- Separar contenido público y administración interna

---

## 🛠️ Stack tecnológico

- **Framework:** Next.js 16 (App Router)
- **Lenguaje:** TypeScript
- **Base de datos:** PostgreSQL (Neon)
- **Estilos:** CSS / Tailwind (según evolución del proyecto)
- **Control de versiones:** Git + GitHub

---

## 📂 Estructura del proyecto

```txt
app/
├── (public)/
│   ├── tramites/
│   │   ├── page.tsx                # Listado de dependencias
│   │   └── [depSlug]/
│   │       ├── page.tsx            # Trámites por dependencia
│   │       └── [tramiteSlug]/
│   │           └── page.tsx        # Detalle de trámite
│   ├── oficios/
│   ├── anuncios/
│   └── page.tsx                    # Home pública
│
├── (admin)/
│   └── admin/
│       ├── dependencias/
│       ├── tramites/
│       ├── oficios-categorias/
│       ├── oficios-solicitudes/
│       └── anuncios/
│
lib/
├── db.ts                            # Conexión a PostgreSQL
└── repos/
    ├── dependencias.repo.ts
    ├── tramites.repo.ts
    ├── oficios.repo.ts
    └── anuncios.repo.ts
Base de datos

La aplicación utiliza PostgreSQL en Neon.

Ejemplo de variables de entorno:
DATABASE_URL=postgresql://usuario:password@host:port/database?sslmode=require
Las migraciones SQL se encuentran en:
db/migrations/
Ejecución en desarrollo

Instalar dependencias:
npm install
Configurar .env.local:
DATABASE_URL=...
Ejecutar migraciones (si aplica):
psql "$DATABASE_URL" -f db/migrations/001_init.sql
Levantar el servidor:
npm run dev
La aplicación estará disponible en:
http://localhost:3000
(o el puerto que Next.js asigne automáticamente)
Estado actual

✅ Listado de dependencias

✅ Rutas dinámicas por dependencia (/tramites/[depSlug])

✅ Conexión a base de datos estable

✅ Migraciones iniciales

🟡 Panel administrativo en desarrollo

🟡 Trámites individuales y contenido extendido

📈 Próximos pasos

CRUD completo desde panel administrativo

Publicación y versionado de trámites

Buscador global

SEO y accesibilidad

Autenticación para administración

👤 Autor

Hugo Rodríguez
Proyecto personal enfocado en tecnología cívica y mejora de servicios públicos.

📄 Licencia

Este proyecto se encuentra en etapa de desarrollo.
Licencia a definir.

---
