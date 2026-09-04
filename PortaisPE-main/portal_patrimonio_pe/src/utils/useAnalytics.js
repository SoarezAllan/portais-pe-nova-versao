import { useEffect, useRef } from 'react';

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

async function sendEvent(payload) {
  try {
    await fetch(`${KEYSTONE_URL}/analytics/track`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload),
    });
  } catch (e) {}
}

export function useTrackPortalView() {
  const fired = useRef(false);
  useEffect(() => {
    if (fired.current) return;
    fired.current = true;
    const firedKey = 'portal_view_fired';
    if (sessionStorage.getItem(firedKey)) return;
    sessionStorage.setItem(firedKey, '1');
    const sessionId = getOrCreateSessionId();
    sendEvent({
      eventId: `PORTAL_VIEW:${SITE_TITLE}:${sessionId}`,
      type: 'PORTAL_VIEW',
      ts: new Date().toISOString(),
      portal: SITE_TITLE,
      area: SITE_AREA,
    });
  }, []);
}

export function useTrackServicoView(slug) {
  const fired = useRef(false);
  useEffect(() => {
    if (!slug || fired.current) return;
    fired.current = true;
    const sessionId = getOrCreateSessionId();
    sendEvent({
      eventId: `SERVICO_VIEW:${slug}:${sessionId}`,
      type: 'SERVICO_VIEW',
      ts: new Date().toISOString(),
      portal: SITE_TITLE,
      area: SITE_AREA,
      servicoSlug: slug,
    });
  }, [slug]);
}

export function useTrackNoticiaView(slug) {
  const fired = useRef(false);
  useEffect(() => {
    if (!slug || fired.current) return;
    fired.current = true;
    const sessionId = getOrCreateSessionId();
    sendEvent({
      eventId: `NOTICIA_VIEW:${slug}:${sessionId}`,
      type: 'NOTICIA_VIEW',
      ts: new Date().toISOString(),
      portal: SITE_TITLE,
      area: SITE_AREA,
      noticiaSlug: slug,
    });
  }, [slug]);
}