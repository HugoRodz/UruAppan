import { query } from '../db';

export async function listTramitesByDependenciaSlug(depSlug: string) {
  return query(
    `SELECT t.* FROM tramites t
     JOIN dependencias d ON t.dependencia_id = d.id
     WHERE d.slug = $1 AND t.publicado = true
     ORDER BY t.titulo`,
    [depSlug]
  );
}

export async function getTramiteBySlugs(depSlug: string, tramiteSlug: string) {
  const res = await query(
    `SELECT t.* FROM tramites t
     JOIN dependencias d ON t.dependencia_id = d.id
     WHERE d.slug = $1 AND t.slug = $2 AND t.publicado = true`,
    [depSlug, tramiteSlug]
  );
  return res[0] || null;
}

export async function listRequisitosByTramiteId(tramiteId: number) {
  return query(
    `SELECT * FROM tramite_requisitos WHERE tramite_id = $1 ORDER BY orden`,
    [tramiteId]
  );
}
