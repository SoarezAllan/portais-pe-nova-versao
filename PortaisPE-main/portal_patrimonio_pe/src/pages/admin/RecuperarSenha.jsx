// src/pages/admin/RecuperarSenha.jsx
import React, { useState } from "react";
import { adminStyles } from "../../styles/adminStyles";

export default function RecuperarSenha() {
  const [email, setEmail] = useState("");
  const [success, setSuccess] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(""); setSuccess(""); setLoading(true);

    try {
      const API_URL = import.meta.env.VITE_API_BASE_URL
        ? `${import.meta.env.VITE_API_BASE_URL.replace(/\/$/, '')}/api/graphql`
        : '/api/graphql';

      const res = await fetch(API_URL, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          query: `
            mutation($email: String!) {
              forgotPassword(email: $email)
            }
          `,
          variables: { email },
        }),
      });

      const data = await res.json();
      if (data.errors) setError(data.errors[0].message);
      else setSuccess("Email enviado com sucesso!");
    } catch (err) {
      console.error(err);
      setError("Erro ao conectar com o servidor.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={adminStyles.container}>
      <div style={adminStyles.card}>
        <h2 style={adminStyles.title}>Recuperar Senha</h2>
        <p style={adminStyles.subtitle}>Digite seu email para receber uma senha temporária</p>
        {error && <p style={{ color: "red", marginBottom: 12 }}>{error}</p>}
        {success && <p style={{ color: "green", marginBottom: 12 }}>{success}</p>}
        <form onSubmit={handleSubmit}>
          <input
            type="email"
            placeholder="Digite seu email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            style={adminStyles.input}
          />
          <button type="submit" style={adminStyles.button}>
            {loading ? "Enviando..." : "Enviar email de recuperação"}
          </button>
        </form>
        <div
          style={adminStyles.link}
          onClick={() => (window.location.href = "/gerenciador-login")}
        >
          Voltar ao login
        </div>
      </div>
    </div>
  );
}