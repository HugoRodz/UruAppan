import Link from 'next/link';
import { listCategoriasActivas } from '@/lib/repos/oficios.repo';

export default async function Page() {
  const categorias = await listCategoriasActivas();
  return (
    <main className="max-w-xl mx-auto py-10">
      <h2 className="text-xl font-bold mb-4">Categorías de oficios</h2>
      <ul className="space-y-2">
        {categorias.map((cat: any) => (
          <li key={cat.id}>
            <Link href={`/oficios/${cat.slug}`} className="underline">
              {cat.nombre}
            </Link>
          </li>
        ))}
      </ul>
    </main>
  );
}
}
