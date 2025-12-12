-- UruAppan: Migración inicial

CREATE TYPE user_role AS ENUM ('admin', 'editor', 'emprendedor');
CREATE TYPE oficio_estado AS ENUM ('pendiente', 'aprobado', 'rechazado');

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  name TEXT,
  image TEXT,
  role user_role NOT NULL DEFAULT 'emprendedor',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE dependencias (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  descripcion TEXT,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_dependencias_slug ON dependencias(slug);

CREATE TABLE tramites (
  id SERIAL PRIMARY KEY,
  dependencia_id INTEGER NOT NULL REFERENCES dependencias(id) ON DELETE CASCADE,
  titulo TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  descripcion TEXT,
  publicado BOOLEAN NOT NULL DEFAULT TRUE,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_tramites_slug ON tramites(slug);

CREATE TABLE tramite_requisitos (
  id SERIAL PRIMARY KEY,
  tramite_id INTEGER NOT NULL REFERENCES tramites(id) ON DELETE CASCADE,
  texto TEXT NOT NULL,
  orden INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE oficio_categorias (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  activo BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE INDEX idx_oficio_categorias_slug ON oficio_categorias(slug);

CREATE TABLE oficios_publicaciones (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  categoria_id INTEGER NOT NULL REFERENCES oficio_categorias(id) ON DELETE CASCADE,
  nombre TEXT NOT NULL,
  telefono TEXT,
  whatsapp TEXT,
  direccion_texto TEXT,
  descripcion TEXT,
  horario TEXT,
  estado oficio_estado NOT NULL DEFAULT 'pendiente',
  motivo_rechazo TEXT,
  premium BOOLEAN NOT NULL DEFAULT FALSE,
  premium_until TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE anuncios (
  id SERIAL PRIMARY KEY,
  titulo TEXT NOT NULL,
  contenido TEXT NOT NULL,
  categoria TEXT,
  publicado BOOLEAN NOT NULL DEFAULT TRUE,
  send_push BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE banners (
  id SERIAL PRIMARY KEY,
  titulo TEXT NOT NULL,
  image_url TEXT NOT NULL,
  link_url TEXT,
  starts_at TIMESTAMPTZ NOT NULL,
  ends_at TIMESTAMPTZ NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT TRUE
);
