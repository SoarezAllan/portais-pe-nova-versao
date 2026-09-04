import apiClient from "./apiClient";

export async function login(email, password) {
  try {
    const query = `
      mutation($email: String!, $password: String!) {
        authenticateUserWithPassword(email: $email, password: $password) {
          ... on UserAuthenticationWithPasswordSuccess {
            sessionToken
            item {
              id
              name
              email
              role
            }
          }
          ... on UserAuthenticationWithPasswordFailure {
            message
          }
        }
      }
    `;
    const variables = { email, password };
    const res = await apiClient.post("/graphql", { query, variables });
    return res.data.data.authenticateUserWithPassword;
  } catch (err) {
    console.error(err);
    throw new Error("Erro ao conectar com o servidor");
  }
}

export async function resetPassword(email) {
  try {
    const query = `
      mutation($email: String!) {
        forgotPassword(email: $email)
      }
    `;
    const variables = { email };
    const res = await apiClient.post("/graphql", { query, variables });
    return res.data.data.forgotPassword;
  } catch (err) {
    console.error(err);
    throw new Error("Erro ao enviar email de reset");
  }
}