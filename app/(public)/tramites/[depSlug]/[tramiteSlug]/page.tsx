import { notFound } from 'next/navigation';
import { getTramiteBySlugs, listRequisitosByTramiteId } from '@/lib/repos/tramites.repo';

type Props = { params: { depSlug: string; tramiteSlug: string } };

export default async function Page({ params }: Props) {
  const tramite = await getTramiteBySlugs(params.depSlug, params.tramiteSlug);
  if (!tramite) return notFound();
  const requisitos = await listRequisitosByTramiteId(tramite.id);
  return (
    <main className="max-w-xl mx-auto py-10">
      <h2 className="text-xl font-bold mb-2">{tramite.titulo}</h2>
      <p className="mb-4">{tramite.descripcion}</p>
      <h3 className="font-semibold mb-2">Requisitos</h3>
      <ul className="list-disc pl-6 mb-4">
        {requisitos.map((r: any) => (
          <li key={r.id}>{r.texto}</li>
        ))}
      </ul>
      <div className="text-sm text-gray-500 mb-4">
        Última actualización: {tramite.updated_at?.toLocaleString?.() || tramite.updated_at}
      </div>
      <button className="px-4 py-2 bg-gray-200 rounded" disabled>
        Reportar cambio (solo UI)
      </button>
    </main>
  );
}
}
