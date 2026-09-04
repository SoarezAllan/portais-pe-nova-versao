import React, { useState } from "react";
import { adminStyles } from "../../styles/adminStyles";
import siteConfig from "../../config/siteConfig";

const API_URL = import.meta.env.VITE_API_BASE_URL
  ? `${import.meta.env.VITE_API_BASE_URL.replace(/\/$/, '')}/api/graphql`
  : '/api/graphql';

const BACKEND_ROOT = import.meta.env.VITE_API_BASE_URL
  ? import.meta.env.VITE_API_BASE_URL.replace(/\/$/, '')
  : '';

export default function LoginAdmin() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [hover, setHover] = useState(false);

  const handleLogin = async (e) => {
    e.preventDefault();
    setError("");

    try {
      const res = await fetch(API_URL, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include", // 🔥 ESSENCIAL
        body: JSON.stringify({
          query: `
            mutation($email: String!, $password: String!) {
              authenticateUserWithPassword(email: $email, password: $password) {
                ... on UserAuthenticationWithPasswordSuccess {
                  sessionToken
                  item { id name role }
                }
                ... on UserAuthenticationWithPasswordFailure {
                  message
                }
              }
            }
          `,
          variables: { email, password },
        }),
      });

      const data = await res.json();
      const result = data?.data?.authenticateUserWithPassword;

      if (result?.sessionToken) {
        // 🔥 redireciona direto pro admin logado (se BACKEND definido, usa ele)
        window.location.href = BACKEND_ROOT || '/';
      } else {
        setError(result?.message || "Erro ao autenticar usuário");
      }
    } catch (err) {
      console.error(err);
      setError("Erro ao conectar com o servidor");
    }
  };

  return (
    <div style={adminStyles.container}>
      <div style={adminStyles.leftPanel}>
        <h1 style={adminStyles.leftTitle}>
          {`Gerenciador de Conteúdo do ${siteConfig.SITE_TITLE}`}
        </h1>
        <p style={adminStyles.leftSubtitle}>Secretaria de Administração</p>
      </div>

      <div style={adminStyles.rightPanel}>
        <div style={adminStyles.card}>
          <h2 style={adminStyles.title}>Login</h2>
          <p style={adminStyles.subtitle}>
            Digite suas credenciais para acessar o painel
          </p>

          {error && <p style={{ color: "red", marginBottom: 12 }}>{error}</p>}

          <form onSubmit={handleLogin}>
            <input
              type="email"
              placeholder="Email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              style={adminStyles.input}
            />

            <input
              type="password"
              placeholder="Senha"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              style={adminStyles.input}
            />

            <button
              type="submit"
              style={{
                ...adminStyles.button,
                ...(hover ? adminStyles.buttonHover : {}),
              }}
              onMouseEnter={() => setHover(true)}
              onMouseLeave={() => setHover(false)}
            >
              Entrar
            </button>
          </form>

          <div
            style={adminStyles.link}
            onClick={() => (window.location.href = "/recuperar-senha")}
          >
            Esqueci minha senha
          </div>
        </div>
      </div>
    </div>
  );
}