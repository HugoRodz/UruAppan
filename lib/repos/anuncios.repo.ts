import { query } from '../db';

export async function listAnunciosPublicados() {
  return query('SELECT * FROM anuncios WHERE publicado = true ORDER BY created_at DESC');
}
