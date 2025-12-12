export const DATABASE_URL = process.env.DATABASE_URL;

if (!DATABASE_URL) {
  throw new Error('Falta la variable de entorno DATABASE_URL. Configura .env.local');
}
