import React, { useState } from "react";
import { useSearchParams } from "react-router-dom";
import apiClient from "../../services/apiClient";
import { adminStyles } from "../../styles/adminStyles";

export default function ResetSenha() {
  const [searchParams] = useSearchParams();
  const email = searchParams.get("email");
  const token = searchParams.get("token");

  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");

  const handleReset = async (e) => {
    e.preventDefault();
    setError("");
    setSuccess("");

    if (!email || !token) {
      setError("Link inválido.");
      return;
    }

    if (password !== confirmPassword) {
      setError("As senhas não conferem");
      return;
    }

    try {
      const res = await apiClient.post("/graphql", {
        query: `
          mutation($email: String!, $tempPassword: String!, $newPassword: String!) {
            resetPassword(email: $email, tempPassword: $tempPassword, newPassword: $newPassword)
          }
        `,
        variables: {
          email,
          tempPassword: token,
          newPassword: password,
        },
      });

      if (res.data.errors) {
        setError(res.data.errors[0].message);
      } else {
        setSuccess("Senha redefinida com sucesso!");
        setTimeout(() => {
          window.location.href = "/gerenciador-login";
        }, 2000);
      }
    } catch (err) {
      console.error(err);
      setError("Erro ao conectar com o servidor.");
    }
  };

  return (
    <div style={adminStyles.container}>
      <div style={adminStyles.card}>
        <h2 style={adminStyles.title}>Redefinir Senha</h2>
        <p style={adminStyles.subtitle}>Digite a nova senha</p>

        {error && <p style={{ color: "red", marginBottom: 12 }}>{error}</p>}
        {success && <p style={{ color: "green", marginBottom: 12 }}>{success}</p>}

        <form onSubmit={handleReset}>
          <input
            type="password"
            placeholder="Nova senha"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            style={adminStyles.input}
          />

          <input
            type="password"
            placeholder="Confirme nova senha"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            required
            style={adminStyles.input}
          />

          <button type="submit" style={adminStyles.button}>
            Redefinir
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