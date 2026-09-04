export type EventType = 'PORTAL_VIEW' | 'SERVICO_VIEW' | 'NOTICIA_VIEW';

export type AnalyticsEvent = {
  eventId: string;
  type: EventType;
  ts: string; // ISO
  portal?: string;
  servicoSlug?: string;
  noticiaSlug?: string;
};

