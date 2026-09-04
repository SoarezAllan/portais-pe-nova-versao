import { useState } from "react";
import { login, resetPassword } from "../../services/auth";

export default function Login({ onLogin }) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [message, setMessage] = useState("");
  const [resetMode, setResetMode] = useState(false);

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const data = await login(email, password);
      if (data.sessionToken) {
        // salvar token no localStorage
        localStorage.setItem("sessionToken", data.sessionToken);
        onLogin(data.item);
      } else {
        setMessage(data.message || "Login falhou");
      }
    } catch (err) {
      setMessage(err.message);
    }
  };

  const handleReset = async () => {
    try {
      await resetPassword(email);
      setMessage("Email de reset enviado!");
      setResetMode(false);
    } catch (err) {
      setMessage(err.message);
    }
  };

  return (
    <div style={{ maxWidth: 400, margin: "50px auto", textAlign: "center" }}>
      <h2>{resetMode ? "Resetar Senha" : "Login"}</h2>
      {message && <p>{message}</p>}
      <form onSubmit={handleLogin}>
        <input
          type="email"
          placeholder="Email"
          value={email}
          required
          onChange={(e) => setEmail(e.target.value)}
          style={{ width: "100%", marginBottom: 10, padding: 8 }}
        />
        {!resetMode && (
          <input
            type="password"
            placeholder="Senha"
            value={password}
            required
            onChange={(e) => setPassword(e.target.value)}
            style={{ width: "100%", marginBottom: 10, padding: 8 }}
          />
        )}
        <button type="submit" style={{ width: "100%", padding: 10 }}>
          {resetMode ? "Enviar Reset" : "Login"}
        </button>
      </form>
      {!resetMode && (
        <p style={{ marginTop: 10, cursor: "pointer", color: "blue" }} onClick={() => setResetMode(true)}>
          Esqueci a senha
        </p>
      )}
      {resetMode && (
        <p style={{ marginTop: 10, cursor: "pointer", color: "blue" }} onClick={() => setResetMode(false)}>
          Voltar ao login
        </p>
      )}
    </div>
  );
}