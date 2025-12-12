import { listAnunciosPublicados } from '@/lib/repos/anuncios.repo';

export default async function Page() {
  const anuncios = await listAnunciosPublicados();
  return (
    <main className="max-w-xl mx-auto py-10">
      <h2 className="text-xl font-bold mb-4">Anuncios municipales</h2>
      {anuncios.length === 0 ? (
        <div>No hay anuncios publicados.</div>
      ) : (
        <ul className="space-y-4">
          {anuncios.map((a: any) => (
            <li key={a.id} className="border rounded p-4">
              <div className="font-semibold">{a.titulo}</div>
              <div className="text-xs text-gray-400 mb-1">{new Date(a.created_at).toLocaleString()}</div>
              <div className="text-sm text-gray-600 mb-2">
                {a.contenido.length > 120 ? (
                  <>
                    {a.contenido.slice(0, 120)}...
                    <details>
                      <summary className="cursor-pointer text-blue-600">Ver más</summary>
                      <div>{a.contenido}</div>
                    </details>
                  </>
                ) : (
                  a.contenido
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
