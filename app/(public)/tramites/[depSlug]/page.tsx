import { notFound } from 'next/navigation';
import { getDependenciaBySlug } from '@/lib/repos/dependencias.repo';
import { listTramitesByDependenciaSlug } from '@/lib/repos/tramites.repo';

export default async function Page({ params }: { params: Promise<{ depSlug: string }> }) {
  const { depSlug } = await params;
  const dep = await getDependenciaBySlug(depSlug);
  if (!dep) return notFound();
  const tramites = await listTramitesByDependenciaSlug(depSlug);
  return (
    <main className="max-w-xl mx-auto py-10">
      <h2 className="text-xl font-bold mb-2">{dep.nombre}</h2>
      <p className="mb-4">{dep.descripcion}</p>
      <h3 className="font-semibold mb-2">Trámites</h3>
      {tramites.length === 0 ? (
        <div className="text-gray-500">No hay trámites publicados para esta dependencia.</div>
      ) : (
        <ul className="space-y-2">
          {tramites.map((t: any) => (
            <li key={t.id}>
              <a href={`/tramites/${dep.slug}/${t.slug}`} className="underline">
                {t.titulo}
              </a>
            </li>
          ))}
        </ul>
      )}
    </main>
  );
}
