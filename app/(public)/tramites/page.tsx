import Link from "next/link";
import { listDependenciasActivas } from "@/lib/repos/dependencias.repo";

export default async function Page() {
  const dependencias = await listDependenciasActivas();
  return (
    <main className="max-w-xl mx-auto py-10">
      <h2 className="text-xl font-bold mb-4">Dependencias</h2>
      {dependencias.length === 0 ? (
        <div className="text-gray-500">No hay dependencias registradas.</div>
      ) : (
        <ul className="space-y-2">
          {dependencias.map((dep: any) => (
            <li key={dep.id}>
              <Link href={`/tramites/${dep.slug}`} className="underline">
                {dep.nombre}
              </Link>
            </li>
          ))}
        </ul>
      )}
    </main>
  );
}
