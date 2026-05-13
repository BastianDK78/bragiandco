import { redirect } from 'next/navigation';
import { Nav } from '@/components/layout/Nav';
import { Footer } from '@/components/layout/Footer';
import { MarkdownRenderer } from '@/components/content/MarkdownRenderer';
import { getSession } from '@/lib/auth';
import { readContentFile } from '@/lib/content';

export default async function ObligationDecoderPage() {
  const user = await getSession();
  if (!user) redirect('/login?next=/obligation-decoder');
  const content = await readContentFile('obligation-decoder.md');
  return (
    <div className="flex flex-col min-h-screen bg-cream">
      <Nav />
      <main className="flex-1 max-w-4xl mx-auto px-6 py-10 w-full">
        <MarkdownRenderer content={content} />
      </main>
      <Footer />
    </div>
  );
}
