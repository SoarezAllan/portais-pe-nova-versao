Template setup

1. Copy the project folder to create a new portal (e.g., `portal_patrimonio_imobiliario`).
2. In the new folder, update `.env` with:

VITE_API_BASE_URL=http://<backend-host>:3001
VITE_SITE_AREA=NameOfArea
VITE_SITE_TITLE="Portal do <Area>"

3. Install dependencies and run:

npm install
npm run dev

Notes
- Backend access control already filters public content by `VITE_SITE_AREA` if no session is present.
- Keep styles intact; `siteConfig` centralizes site title and area so components remain generic.

To add more customization, edit `src/config/siteConfig.js` or override values in `.env`.
