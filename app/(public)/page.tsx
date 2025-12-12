import Link from 'next/link';

export default function Page() {
  return (
    <main className="max-w-xl mx-auto py-10">
      <h1 className="text-2xl font-bold mb-6">UruAppan</h1>
      <div className="flex flex-col gap-4 mb-8">
        <Link href="/tramites" className="block p-4 border rounded hover:bg-gray-50">Trámites</Link>
        <Link href="/oficios" className="block p-4 border rounded hover:bg-gray-50">Oficios</Link>
      </div>
      <input
        type="text"
        placeholder="Buscar trámites u oficios... (solo UI)"
        className="w-full p-2 border rounded"
        disabled
      />
    </main>
  );
}
}
