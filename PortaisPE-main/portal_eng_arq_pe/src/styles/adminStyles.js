export const adminStyles = {
  // Estilos gerais do container para qualquer página
  container: {
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    height: "100vh",
    width: "100vw",
    fontFamily: "'Inter', sans-serif",
    backgroundColor: "#f8f9fa", // Fundo neutro para páginas comuns
  },

  // Card genérico, usado em todas as páginas exceto login
  card: {
    backgroundColor: "#ffffff",
    padding: "40px 30px",
    borderRadius: "16px",
    boxShadow: "0 8px 24px rgba(0,0,0,0.15)",
    maxWidth: "400px",
    width: "100%",
    textAlign: "center",
  },

  // Títulos e textos genéricos
  title: {
    fontSize: "28px",
    fontWeight: "700",
    color: "#001219",
    marginBottom: "10px",
  },
  subtitle: {
    fontSize: "14px",
    color: "#495057",
    marginBottom: "24px",
  },

  // Inputs e botão genéricos
  input: {
    width: "100%",
    padding: "12px 16px",
    marginBottom: "16px",
    borderRadius: "8px",
    border: "1px solid #ced4da",
    fontSize: "14px",
    outline: "none",
    transition: "all 0.2s",
  },
  button: {
    width: "100%",
    padding: "12px 16px",
    backgroundColor: "#003087", // Azul GoPE
    color: "#ffffff",
    fontWeight: "600",
    fontSize: "16px",
    border: "none",
    borderRadius: "8px",
    cursor: "pointer",
    transition: "background-color 0.3s",
  },
  buttonHover: {
    backgroundColor: "#001f54", // Azul GoPE mais escuro para hover
  },
  link: {
    marginTop: "16px",
    fontSize: "14px",
    color: "#003087",
    cursor: "pointer",
    textDecoration: "underline",
    transition: "color 0.2s",
  },

  // ===== Estilos específicos para a tela de login =====
  loginContainer: {
    display: "flex",
    height: "100vh",
    width: "100vw",
  },
  leftPanel: {
    flex: 1,
    backgroundColor: "#003087", // Azul GoPE
    color: "#ffffff",
    display: "flex",
    flexDirection: "column",
    justifyContent: "center",
    alignItems: "center",
    padding: "40px",
    textAlign: "center",
  },
  leftTitle: {
    fontSize: "28px",
    fontWeight: "700",
    marginBottom: "20px",
    lineHeight: "1.4",
  },
  leftSubtitle: {
    fontSize: "16px",
    fontWeight: "400",
    marginBottom: "30px",
  },
  rightPanel: {
    flex: 1,
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#f8f9fa",
  },
};