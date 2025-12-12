import { query } from '../db';

export async function listDependenciasActivas() {
  return query('SELECT * FROM dependencias WHERE activo = true ORDER BY nombre');
}

export async function getDependenciaBySlug(slug: string) {
  const res = await query('SELECT * FROM dependencias WHERE slug = $1 AND activo = true', [slug]);
  return res[0] || null;
}
