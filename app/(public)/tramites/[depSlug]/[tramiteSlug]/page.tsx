
import { notFound } from 'next/navigation';
import Link from 'next/link';
import { getDependenciaBySlug } from '@/lib/repos/dependencias.repo';
import { listTramitesByDependenciaSlug } from '@/lib/repos/tramites.repo';
import React from 'react';

export default async function Page({ params }: { params: Promise<{ depSlug: string; tramiteSlug: string }> }) {
	const { depSlug, tramiteSlug } = await params;
	const dependencia = await getDependenciaBySlug(depSlug);
	if (!dependencia) return notFound();
	const tramites = await listTramitesByDependenciaSlug(depSlug);
	const tramite = tramites.find(
		(t: any) => t.slug === tramiteSlug && t.publicado === true && t.dependencia_id === dependencia.id
	);
	if (!tramite) return notFound();

	// UX: extraer campos destacados de la descripción
	const tiempoRespuesta = extraerCampo(tramite.descripcion, 'Tiempo de respuesta');
	const dondeSeRealiza = extraerCampo(tramite.descripcion, 'Dónde se realiza');

	return (
		<main className="max-w-2xl mx-auto py-10 px-2 sm:px-0">
			{/* Breadcrumb */}
			<nav className="mb-8 flex items-center text-sm text-gray-500 gap-2">
				<Link href="/tramites" className="hover:text-green-700 transition-colors">Trámites</Link>
				<span className="text-gray-300">/</span>
				<Link href={`/tramites/${depSlug}`} className="hover:text-green-700 transition-colors">{dependencia.nombre}</Link>
				<span className="text-gray-300">/</span>
				<span className="text-green-700 font-semibold truncate">{tramite.titulo}</span>
			</nav>

			{/* Card principal */}
			<section className="bg-white/95 border border-green-100 rounded-3xl shadow-2xl p-8 mb-8 flex flex-col gap-6">
				{/* Título y badge */}
				<div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
					<h1 className="text-3xl sm:text-4xl font-extrabold text-green-900 tracking-tight leading-tight flex items-center gap-2">
						<span className="inline-block">📄</span>
						{tramite.titulo}
					</h1>
					<span className="inline-flex items-center gap-2 bg-green-50 text-green-800 text-xs font-bold px-4 py-1.5 rounded-full border border-green-200 shadow-sm mt-2 sm:mt-0">
						<svg className="w-4 h-4 text-green-400" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 20 20"><circle cx="10" cy="10" r="8" /></svg>
						{dependencia.nombre}
					</span>
				</div>

				{/* Secciones destacadas */}
				<div className="flex flex-col sm:flex-row gap-4">
					{tiempoRespuesta && (
						<div className="flex-1 bg-green-50/60 border border-green-100 rounded-xl p-4 flex items-center gap-3">
							<span className="text-green-600 text-xl">⏱️</span>
							<div>
								<div className="text-xs text-green-700 font-semibold uppercase tracking-wide">Tiempo de respuesta</div>
								<div className="text-green-900 font-medium">{tiempoRespuesta}</div>
							</div>
						</div>
					)}
					{dondeSeRealiza && (
						<div className="flex-1 bg-green-50/60 border border-green-100 rounded-xl p-4 flex items-center gap-3">
							<span className="text-green-600 text-xl">📍</span>
							<div>
								<div className="text-xs text-green-700 font-semibold uppercase tracking-wide">Dónde se realiza</div>
								<div className="text-green-900 font-medium">{dondeSeRealiza}</div>
							</div>
						</div>
					)}
				</div>

				{/* Descripción */}
				<DescripcionSeccion descripcion={tramite.descripcion} />

				{/* Requisitos */}
				{tramite.requisitos && tramite.requisitos.trim() !== '' && (
					<section className="mt-2">
						<h2 className="text-lg font-semibold text-green-700 mb-2 flex items-center gap-2">
							<span className="text-xl">✅</span> Requisitos
						</h2>
						<ul className="space-y-2">
							{tramite.requisitos.split('\n').map((req: string, i: number) =>
								req.trim() ? (
									<li key={i} className="flex items-start gap-2">
										<span className="mt-1 text-green-500">✔️</span>
										<span className="text-gray-800">{req.trim()}</span>
									</li>
								) : null
							)}
						</ul>
					</section>
				)}

				{/* Última actualización */}
				<div className="pt-4 border-t border-green-100 flex justify-between items-center text-xs text-gray-500">
					<span>Última actualización:</span>
					<span className="text-gray-700">
						{tramite.updated_at ? new Date(tramite.updated_at).toLocaleDateString() : 'N/A'}
					</span>
				</div>
			</section>
		</main>
	);
}

// Utilidad para extraer un campo de la descripción por palabra clave
function extraerCampo(descripcion: string, campo: string): string | null {
	if (!descripcion) return null;
	const regex = new RegExp(`${campo}:?\\s*(.*)`, 'i');
	const match = descripcion.split(/\r?\n/).find(line => regex.test(line));
	if (match) {
		const res = match.match(regex);
		if (res && res[1]) return res[1].trim();
	}
	return null;
}

// Formatea la descripción en secciones por palabras clave y convierte "Requisitos" en lista visual
function DescripcionSeccion({ descripcion }: { descripcion: string }) {
	if (!descripcion) return null;
	const keywords = [
		'Requisitos',
		'Procedimiento',
		'Documentos',
		'Costo',
		'Tiempo de respuesta',
		'Observaciones',
		'Contacto',
		'Notas',
		'Dónde se realiza',
	];
	const sections: { title: string; content: string }[] = [];
	let current = { title: 'Descripción', content: '' };
	const lines = descripcion.split(/\r?\n/);
	for (const line of lines) {
		const keyword = keywords.find(k => line.trim().startsWith(k));
		if (keyword) {
			if (current.content.trim()) sections.push({ ...current });
			current = { title: keyword, content: line.replace(keyword, '').replace(':', '').trim() };
		} else {
			current.content += (current.content ? '\n' : '') + line;
		}
	}
	if (current.content.trim()) sections.push(current);

	// Detectar si el primer bloque es informativo
	const infoBlock = sections[0]?.content || '';
	// Buscar sección de requisitos
	const reqSection = sections.find(sec => sec.title === 'Requisitos');
	let requisitos: string[] = [];
	if (reqSection) {
		requisitos = reqSection.content
			.split(',')
			.map(item => item.trim())
			.filter(item => item.length > 0 && !/^Tiempo de respuesta/i.test(item));
		// Si "Copia del INE" está dentro, lo separamos como punto aparte
		const idxIne = requisitos.findIndex(r => /^copia del ine/i.test(r));
		if (idxIne !== -1) {
			const ine = requisitos.splice(idxIne, 1)[0];
			requisitos.unshift(ine); // Lo ponemos como primer punto
		}
	}

	return (
		<section className="space-y-8 mt-2">
			{/* Bloque informativo destacado */}
			{infoBlock && (
				<div className="border-l-4 border-green-400 pl-5 py-2 bg-green-50/60 rounded-md">
					<p className="font-bold text-gray-900 text-base mb-0 whitespace-pre-line">{infoBlock}</p>
				</div>
			)}

			{/* Lista de requisitos visual */}
			{requisitos.length > 0 && (
				<div className="border-l-4 border-green-200 pl-5 py-2 bg-green-50/40 rounded-md">
					<h2 className="text-lg font-semibold text-green-700 mb-1 flex items-center gap-2">
						<span className="text-xl">✅</span> Requisitos
					</h2>
					<ul className="list-disc pl-5 space-y-1 text-gray-800">
						{requisitos.map((item, idx) => (
							<li key={idx}>{item}</li>
						))}
					</ul>
				</div>
			)}

			{/* Otras secciones */}
			{sections.slice(1).map((sec, i) => {
				if (sec.title === 'Requisitos') return null; // Ya renderizado arriba
				return (
					<div
						key={i}
						className="border-l-4 border-green-200 pl-5 py-2 bg-green-50/40 rounded-md"
					>
						<h2 className="text-lg font-semibold text-green-700 mb-1 flex items-center gap-2">
							{sec.title === 'Descripción' && <span className="text-xl">ℹ️</span>}
							{sec.title === 'Procedimiento' && <span className="text-xl">📝</span>}
							{sec.title === 'Documentos' && <span className="text-xl">📑</span>}
							{sec.title === 'Costo' && <span className="text-xl">💲</span>}
							{sec.title === 'Tiempo de respuesta' && <span className="text-xl">⏱️</span>}
							{sec.title === 'Observaciones' && <span className="text-xl">💡</span>}
							{sec.title === 'Contacto' && <span className="text-xl">☎️</span>}
							{sec.title === 'Notas' && <span className="text-xl">🗒️</span>}
							{sec.title === 'Dónde se realiza' && <span className="text-xl">📍</span>}
							{sec.title}
						</h2>
						<p className="text-gray-800 whitespace-pre-line">{sec.content}</p>
					</div>
				);
			})}
		</section>
	);
}
