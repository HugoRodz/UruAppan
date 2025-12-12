type Props = { params: { catSlug: string } };
import { notFound } from 'next/navigation';
import { listCategoriasActivas, listOficiosByCategoriaSlug } from '@/lib/repos/oficios.repo';

type PageProps = { params: { catSlug: string } };

export default async function Page({ params }: PageProps) {
  const categorias = await listCategoriasActivas();
  const categoria = categorias.find((c: any) => c.slug === params.catSlug);
  if (!categoria) return notFound();
  const oficios = await listOficiosByCategoriaSlug(params.catSlug);
  return (
    <main className="max-w-xl mx-auto py-10">
      <h2 className="text-xl font-bold mb-4">{categoria.nombre}</h2>
      {oficios.length === 0 ? (
        <div>No hay oficios aprobados en esta categoría.</div>
      ) : (
        <ul className="space-y-4">
          {oficios.map((o: any) => (
            <li key={o.id} className="border rounded p-4">
              <div className="font-semibold">{o.nombre}</div>
              <div className="text-sm text-gray-600 mb-1">{o.descripcion}</div>
              {o.horario && <div className="text-xs text-gray-500 mb-1">Horario: {o.horario}</div>}
              <div className="flex gap-2 mt-2">
                {o.whatsapp && (
                  <a
                    href={`https://wa.me/${o.whatsapp}`}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-block px-3 py-1 bg-green-500 text-white rounded"
                  >
                    WhatsApp
                  </a>
                )}
                {o.telefono && (
                  <a
                    href={`tel:${o.telefono}`}
                    className="inline-block px-3 py-1 bg-blue-500 text-white rounded"
                  >
                    Llamar
                  </a>
                )}
              </div>
            </li>
          ))}
        </ul>
      )}
    </main>
  );

}
}
