import React, { useState } from 'react';
import { useAuth } from '@/hooks/useAuth';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';
import { AlertCircle, Loader2, Lock, Mail, Eye, EyeOff, ShieldCheck, ExternalLink, Globe } from 'lucide-react';

export function LoginPage() {
  const { login } = useAuth();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      await login(email, password);
    } catch (err: any) {
      setError(err.message || 'Credenciais inválidas. Verifique seu e-mail e senha.');
    } finally {
      setLoading(false);
    }
  };

  const hostname = typeof window !== 'undefined' ? window.location.hostname : 'localhost';

  const portais = [
    { nome: 'Patrimônio', url: `http://${hostname}:5174` },
    { nome: 'Engenharia e Arquitetura', url: `http://${hostname}:5175` },
    { nome: 'Contratos Corporativos', url: `http://${hostname}:5176` },
  ];

  return (
    <div className="min-h-screen flex flex-col justify-between bg-gradient-to-br from-[#06152d] via-[#0b2447] to-[#001738] text-slate-100 relative overflow-hidden selection:bg-amber-400 selection:text-slate-900">
      {/* Luzes de Fundo Ambientais */}
      <div className="absolute -top-40 -left-40 w-96 h-96 bg-blue-600/20 rounded-full blur-3xl pointer-events-none" />
      <div className="absolute top-1/3 -right-40 w-96 h-96 bg-indigo-500/15 rounded-full blur-3xl pointer-events-none" />
      <div className="absolute -bottom-40 left-1/3 w-96 h-96 bg-amber-500/10 rounded-full blur-3xl pointer-events-none" />

      {/* Cabeçalho Institucional Superior */}
      <header className="w-full py-6 px-6 sm:px-12 flex items-center justify-between z-10">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-amber-400 to-amber-600 flex items-center justify-center shadow-lg shadow-amber-500/20">
            <ShieldCheck className="h-6 w-6 text-slate-950 font-bold" />
          </div>
          <div>
            <h1 className="text-lg font-extrabold tracking-tight text-white leading-tight">
              Governo de Pernambuco
            </h1>
            <p className="text-xs text-blue-200/80 font-medium">
              Secretaria de Administração — SAD
            </p>
          </div>
        </div>

        <div className="hidden sm:flex items-center gap-2 text-xs font-semibold px-3 py-1.5 rounded-full bg-white/10 backdrop-blur-md border border-white/15 text-blue-100">
          <span className="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span>
          Ambiente Administrativo Seguro
        </div>
      </header>

      {/* Conteúdo Central: Card de Login & Apresentação */}
      <main className="flex-1 flex items-center justify-center px-4 py-8 z-10">
        <div className="w-full max-w-md">
          {/* Card Principal */}
          <Card className="border border-white/20 bg-white/95 backdrop-blur-2xl shadow-2xl rounded-2xl overflow-hidden text-slate-900">
            <div className="h-2 bg-gradient-to-r from-[#003087] via-[#0055b8] to-[#FFCC00]"></div>
            
            <CardHeader className="text-center pt-8 pb-4">
              <div className="inline-flex items-center justify-center w-14 h-14 rounded-2xl bg-blue-50 text-blue-800 border border-blue-100 shadow-sm mx-auto mb-3">
                <Globe className="h-7 w-7 text-blue-700" />
              </div>
              <CardTitle className="text-2xl font-black text-slate-900 tracking-tight">
                Gerenciamento de conteúdo
              </CardTitle>
              <p className="text-xs font-bold uppercase tracking-widest text-[#003087] mt-0.5">
                Portais PE
              </p>
              <p className="text-sm text-slate-500 mt-2">
                Acesse com suas credenciais institucionais
              </p>
            </CardHeader>

            <CardContent className="px-6 sm:px-8 pb-8 pt-2">
              <form onSubmit={handleSubmit} className="space-y-4">
                {error && (
                  <div className="flex items-start gap-2.5 p-3.5 bg-red-50 border border-red-200 text-red-700 rounded-xl text-xs font-medium animate-shake">
                    <AlertCircle className="h-4 w-4 shrink-0 mt-0.5 text-red-600" />
                    <span>{error}</span>
                  </div>
                )}

                <div className="space-y-1.5">
                  <Label htmlFor="email" className="text-xs font-bold text-slate-700 uppercase tracking-wider">
                    E-mail Institucional
                  </Label>
                  <div className="relative">
                    <Mail className="absolute left-3.5 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400" />
                    <Input
                      id="email"
                      type="email"
                      placeholder="usuario@sad.pe.gov.br"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      required
                      className="pl-10 h-11 bg-slate-50/70 border-slate-200 focus:bg-white focus:border-blue-600 rounded-xl text-sm"
                    />
                  </div>
                </div>

                <div className="space-y-1.5">
                  <div className="flex items-center justify-between">
                    <Label htmlFor="password" className="text-xs font-bold text-slate-700 uppercase tracking-wider">
                      Senha de Acesso
                    </Label>
                  </div>
                  <div className="relative">
                    <Lock className="absolute left-3.5 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400" />
                    <Input
                      id="password"
                      type={showPassword ? 'text' : 'password'}
                      placeholder="••••••••"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      required
                      className="pl-10 pr-10 h-11 bg-slate-50/70 border-slate-200 focus:bg-white focus:border-blue-600 rounded-xl text-sm"
                    />
                    <button
                      type="button"
                      onClick={() => setShowPassword(!showPassword)}
                      className="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 focus:outline-none"
                      aria-label={showPassword ? 'Ocultar senha' : 'Ver senha'}
                    >
                      {showPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                    </button>
                  </div>
                </div>

                <Button
                  type="submit"
                  className="w-full h-11 mt-2 bg-gradient-to-r from-[#003087] to-[#004A8D] hover:from-[#002466] hover:to-[#00396e] text-white font-bold rounded-xl shadow-md transition-all transform active:scale-[0.99]"
                  disabled={loading}
                >
                  {loading ? (
                    <>
                      <Loader2 className="h-4 w-4 mr-2 animate-spin text-amber-300" />
                      Autenticando...
                    </>
                  ) : (
                    'Entrar no Sistema'
                  )}
                </Button>
              </form>
            </CardContent>
          </Card>
        </div>
      </main>

      {/* Rodapé com Atalhos para os Portais Públicos */}
      <footer className="w-full py-6 px-4 z-10 border-t border-white/10 bg-slate-950/40 backdrop-blur-md text-center">
        <div className="max-w-4xl mx-auto flex flex-col sm:flex-row items-center justify-between gap-4">
          <div className="flex flex-wrap items-center justify-center gap-2">
            <span className="text-xs text-blue-200/70 mr-1">Portais Públicos:</span>
            {portais.map((p) => (
              <a
                key={p.nome}
                href={p.url}
                target="_blank"
                rel="noreferrer"
                className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg text-xs font-medium bg-white/10 hover:bg-white/20 text-white transition-colors border border-white/10"
              >
                {p.nome}
                <ExternalLink className="h-3 w-3 text-amber-300" />
              </a>
            ))}
          </div>

          <p className="text-xs text-blue-200/60">
            © {new Date().getFullYear()} Governo do Estado de Pernambuco
          </p>
        </div>
      </footer>
    </div>
  );
}

export default LoginPage;
