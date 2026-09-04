import nodemailer from 'nodemailer';

export async function sendPasswordResetEmail(email: string, resetLink: string) {
  try {
    const transporter = nodemailer.createTransport({
      host: process.env.SMTP_HOST,
      port: Number(process.env.SMTP_PORT),
      secure: false,
      auth: {
        user: process.env.SMTP_USER,
        pass: process.env.SMTP_PASS,
      },
      tls: {
        rejectUnauthorized: false,
      },
    });

    await transporter.sendMail({
      from: `"Sistema de Patrimônio" <${process.env.EMAIL_FROM_ADDRESS}>`,
      to: email,
      subject: 'Recuperação de Senha',
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto;">
          <h2 style="color: #1e3a8a;">Recuperação de Senha</h2>

          <p>Olá,</p>
          <p>Recebemos uma solicitação para redefinir sua senha.</p>

          <p>Clique no botão abaixo para criar uma nova senha:</p>

          <div style="text-align: center; margin: 24px 0;">
            <a href="${resetLink}" style="
                background: #1e3a8a;
                color: #ffffff;
                padding: 12px 28px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: bold;
                font-size: 16px;
                display: inline-block;
              ">Redefinir senha</a>
          </div>

          <p style="font-size: 13px; color: #64748b;">
            Se o botão não funcionar, copie e cole o link abaixo no seu navegador:
          </p>
          <p style="font-size: 13px; word-break: break-all;">
            <a href="${resetLink}">${resetLink}</a>
          </p>

          <p style="font-size: 12px; color: #64748b; margin-top: 24px;">
            Se você não solicitou essa alteração, ignore este email.
          </p>
        </div>
      `,
    });

    console.log(`✅ Email enviado para: ${email}`);
  } catch (error) {
    console.error('❌ ERRO AO ENVIAR EMAIL:', error);
    throw new Error('Falha no envio de email');
  }
}