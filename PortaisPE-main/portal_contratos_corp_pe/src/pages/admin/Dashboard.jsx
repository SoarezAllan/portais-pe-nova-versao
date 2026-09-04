import { useEffect, useState } from "react";
import apiClient from "../../services/apiClient";

export default function Dashboard({ user }) {
  const [servicos, setServicos] = useState([]);
  const [solucoes, setSolucoes] = useState([]);

  useEffect(() => {
    const fetchServicos = async () => {
      const query = `{ servicos { id nome } }`;
      const res = await apiClient.post("/graphql", { query });
      setServicos(res.data.data.servicos);
    };
    const fetchSolucoes = async () => {
      const query = `{ solucoes { id nome } }`;
      const res = await apiClient.post("/graphql", { query });
      setSolucoes(res.data.data.solucoes);
    };
    fetchServicos();
    fetchSolucoes();
  }, []);

  return (
    <div style={{ padding: 20 }}>
      <h1>Dashboard</h1>
      <p>Bem-vindo, {user.role}</p>

      <h2>Serviços</h2>
      <ul>
        {servicos.map((s) => (
          <li key={s.id}>{s.nome}</li>
        ))}
      </ul>

      <h2>Soluções</h2>
      <ul>
        {solucoes.map((s) => (
          <li key={s.id}>{s.nome}</li>
        ))}
      </ul>
    </div>
  );
}