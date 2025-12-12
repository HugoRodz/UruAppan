import { query } from '../db';

export async function listCategoriasActivas() {
  return query('SELECT * FROM oficio_categorias WHERE activo = true ORDER BY nombre');
}

export async function listOficiosByCategoriaSlug(catSlug: string) {
  return query(
    `SELECT o.* FROM oficios_publicaciones o
     JOIN oficio_categorias c ON o.categoria_id = c.id
     WHERE c.slug = $1 AND o.estado = 'aprobado'
     ORDER BY o.premium DESC, o.premium_until DESC NULLS LAST, o.created_at DESC`,
    [catSlug]
  );
}

export async function getOficioById(id: number) {
  const res = await query("SELECT * FROM oficios_publicaciones WHERE id = $1 AND estado = 'aprobado'", [id]);
  return res[0] || null;
}
