import Link from "next/link";
import { listDependenciasActivas } from "@/lib/repos/dependencias.repo";

export default async function Page() {
  // Log temporal para debug de env
  console.log('DATABASE_URL:', process.env.DATABASE_URL);
  const dependencias = await listDependenciasActivas();

  return (
    <main className="max-w-xl mx-auto py-10">
      <h2 className="text-xl font-bold mb-4">Dependencias</h2>

      <ul className="space-y-2">
        {dependencias.map((dep: any) => (
          <li key={dep.id}>
            <Link href={`/tramites/${dep.slug}`} className="underline">
              {dep.nombre}
            </Link>
          </li>
        ))}
      </ul>
    </main>
  );
}
