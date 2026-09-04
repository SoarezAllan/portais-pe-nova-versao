// Helper to attach area and audit metadata on create/update
export async function resolveAreaAndAudit({
  operation,
  resolvedData,
  context,
}: {
  operation: 'create' | 'update' | string;
  resolvedData: any;
  context: any;
}) {
  const session = (context as any).session;
  const data = { ...(resolvedData || {}) };

  if (!session) return data;

  const isAdmin = session.data?.role === 'admin';

  if (operation === 'create') {
    if (isAdmin) {
      if (!data.createdBy) data.createdBy = 'Gerado por Administrador';
    } else {
      if (!data.createdBy) data.createdBy = session.data?.name || session.data?.email || 'Usuário';

      // auto-connect areaResponsavel to first area of the user if not provided
      if (!data.areaResponsavel && Array.isArray(session.data?.areas) && session.data.areas.length) {
        data.areaResponsavel = { connect: { id: session.data.areas[0].id } };
      }
    }
  }

  if (operation === 'update') {
    data.updatedBy = session.data?.name || session.data?.email || 'Usuário';
    data.updatedAt = new Date().toISOString();
  }

  return data;
}
