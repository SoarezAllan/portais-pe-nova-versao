import "./style.css";

export default function GestorCard({ gestor }) {
  const base = import.meta.env.VITE_API_BASE_URL
    ? import.meta.env.VITE_API_BASE_URL.replace(/\/$/, '')
    : '';

  const fotoUrl = gestor?.foto?.url
    ? base
      ? `${base}${gestor.foto.url}`
      : gestor.foto.url
    : "/default-user.png";

  return (
    <div className="gestor-card">

      {/* Frente do card */}
      <div className="gestor-card-front">

        <img
          src={fotoUrl}
          alt={gestor?.nome || "Gestor"}
          className="gestor-foto"
        />

        <h3 className="gestor-nome">
          {gestor?.nome}
        </h3>

        <p className="gestor-cargo">
          {gestor?.cargo}
        </p>

        <p className="gestor-descricao">
          {gestor?.descricao}
        </p>

      </div>

      {/* Hover */}
      <div className="gestor-card-hover">

        <h4>Contato</h4>

        {gestor?.email && <p>{gestor.email}</p>}
        {gestor?.telefone && <p>{gestor.telefone}</p>}

        <h4>Áreas Responsáveis</h4>

        <ul>
          {gestor?.areas?.length > 0 ? (
            gestor.areas.map((area, index) => (
              <li key={area.id || index}>
                {area.nome}
              </li>
            ))
          ) : (
            <li>Não informado</li>
          )}
        </ul>

      </div>

    </div>
  );
}