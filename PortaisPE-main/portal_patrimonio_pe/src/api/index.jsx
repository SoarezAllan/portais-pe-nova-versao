import axios from "axios";

const baseURL = import.meta.env.VITE_API_BASE_URL || "";
const siteArea = import.meta.env.VITE_SITE_AREA || "Patrimônio";

const apiClient = axios.create({
  baseURL,
  withCredentials: false, // ✅ não envia cookie de sessão do Keystone
  headers: {
    "Content-Type": "application/json",
    "x-site-area": siteArea,
  },
});

function coerceIdFields(obj) {
  if (!obj || typeof obj !== "object") return obj;
  if (Array.isArray(obj)) {
    return obj.map(coerceIdFields);
  }
  const out = {};
  for (const [k, v] of Object.entries(obj)) {
    if (v == null) {
      out[k] = v;
      continue;
    }
    if (
      typeof v === "number" &&
      (/^id$/i.test(k) ||
        k.endsWith("Id") ||
        k.endsWith("_id") ||
        k.toLowerCase().includes("id"))
    ) {
      out[k] = String(v);
    } else if (Array.isArray(v)) {
      out[k] = v.map((el) =>
        typeof el === "number" ? String(el) : coerceIdFields(el)
      );
    } else if (typeof v === "object") {
      out[k] = coerceIdFields(v);
    } else {
      out[k] = v;
    }
  }
  return out;
}

apiClient.interceptors.request.use((config) => {
  config.headers["x-site-area"] = siteArea;
  if (
    config.data &&
    typeof config.data === "object" &&
    config.data.variables
  ) {
    config.data = {
      ...config.data,
      variables: coerceIdFields(config.data.variables),
    };
  }
  return config;
});

export default apiClient;