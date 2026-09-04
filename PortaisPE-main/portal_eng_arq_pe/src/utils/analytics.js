const KEYSTONE_URL = import.meta.env.VITE_API_BASE_URL || '';
const SITE_AREA = import.meta.env.VITE_SITE_AREA || '';
const SITE_TITLE = import.meta.env.VITE_SITE_TITLE || 'Portal';

function getOrCreateSessionId() {
  const key = 'portal_session_id';
  let id = sessionStorage.getItem(key);
  if (!id) {
    id = `${Date.now()}-${Math.random().toString(36).slice(2)}`;
    sessionStorage.setItem(key, id);
  }
  return id;
}

export async function trackPortalView() {
  const sessionId = getOrCreateSessionId();
  const eventId = `PORTAL_VIEW:${SITE_TITLE}:${sessionId}`;
  const firedKey = 'portal_view_fired';
  if (sessionStorage.getItem(firedKey)) return;
  sessionStorage.setItem(firedKey, '1');
  try {
    await fetch(`${KEYSTONE_URL}/analytics/track`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        eventId,
        type: 'PORTAL_VIEW',
        ts: new Date().toISOString(),
        portal: SITE_TITLE,
        area: SITE_AREA,
      }),
    });
  } catch (e) {}
}

export async function trackServicoView(slug) {
  const sessionId = getOrCreateSessionId();
  const eventId = `SERVICO_VIEW:${slug}:${sessionId}`;
  try {
    await fetch(`${KEYSTONE_URL}/analytics/track`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        eventId,
        type: 'SERVICO_VIEW',
        ts: new Date().toISOString(),
        portal: SITE_TITLE,
        area: SITE_AREA,
        servicoSlug: slug,
      }),
    });
  } catch (e) {}
}

export async function trackNoticiaView(slug) {
  const sessionId = getOrCreateSessionId();
  const eventId = `NOTICIA_VIEW:${slug}:${sessionId}`;
  try {
    await fetch(`${KEYSTONE_URL}/analytics/track`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        eventId,
        type: 'NOTICIA_VIEW',
        ts: new Date().toISOString(),
        portal: SITE_TITLE,
        area: SITE_AREA,
        noticiaSlug: slug,
      }),
    });
  } catch (e) {}
}

