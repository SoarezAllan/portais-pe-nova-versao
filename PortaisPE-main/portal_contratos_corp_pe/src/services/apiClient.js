import axios from "axios";
import siteConfig from "../config/siteConfig";

const baseURL = import.meta.env.VITE_API_BASE_URL || "";

const apiClient = axios.create({
  baseURL,
  headers: {
    "Content-Type": "application/json",
    "x-site-area": siteConfig.SITE_AREA,
  },
  withCredentials: true,
});

function coerceIdFields(obj) {
  if (!obj || typeof obj !== 'object') return obj;
  if (Array.isArray(obj)) return obj.map(coerceIdFields);
  const out = {};
  for (const [k, v] of Object.entries(obj)) {
    if (v == null) {
      out[k] = v;
      continue;
    }
    if (typeof v === 'number' && (/^id$|id$|Id$|_id$/i.test(k) || k.toLowerCase().includes('id'))) {
      out[k] = String(v);
    } else if (Array.isArray(v)) {
      out[k] = v.map((el) => (typeof el === 'number' ? String(el) : coerceIdFields(el)));
    } else if (typeof v === 'object') {
      out[k] = coerceIdFields(v);
    } else {
      out[k] = v;
    }
  }
  return out;
}

apiClient.interceptors.request.use((config) => {
  try {
    if (config.data && typeof config.data === 'object' && config.data.variables) {
      config.data = {
        ...config.data,
        variables: coerceIdFields(config.data.variables),
      };
    }
  } catch (e) {
    // não quebrar a requisição se algo falhar aqui
  }
  return config;
});

export default apiClient;