import { Nav } from '@/components/layout/Nav';
import { Footer } from '@/components/layout/Footer';
import { LoginForm } from '@/components/auth/LoginForm';

interface Props {
  searchParams: Promise<{ error?: string; next?: string }>;
}

export default async function LoginPage({ searchParams }: Props) {
  const { error, next } = await searchParams;

  return (
    <div className="flex flex-col min-h-screen bg-cream">
      <Nav />
      <main className="flex-1 flex items-center justify-center px-6 py-16">
        <div className="w-full max-w-sm">
          <p className="text-xs font-bold tracking-[0.1em] uppercase text-cedar mb-2">
            Subscriber access
          </p>
          <h1 className="text-2xl font-extrabold text-zinc-dark mb-1">Sign in</h1>
          <p className="text-sm text-cedar mb-6">
            Enter the work email you used to purchase. We&apos;ll send you a one-time access link.
          </p>
          <LoginForm errorParam={error} next={next} />
          <p className="text-xs text-cedar mt-6">
            Don&apos;t have access yet?{' '}
            <a href="/" className="text-oak underline">
              Get the Vendor Risk Heatmap →
            </a>
          </p>
        </div>
      </main>
      <Footer />
    </div>
  );
}
