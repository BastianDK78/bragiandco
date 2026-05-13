import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';

export function MarkdownRenderer({ content }: { content: string }) {
  return (
    <div className="prose prose-sm max-w-none
      prose-headings:font-extrabold prose-headings:text-zinc-dark
      prose-h1:text-2xl prose-h2:text-lg prose-h2:mt-8 prose-h2:mb-3
      prose-p:text-zinc-dark prose-p:leading-relaxed
      prose-li:text-zinc-dark
      prose-a:text-oak prose-a:no-underline hover:prose-a:underline
      prose-strong:text-zinc-dark
      prose-code:text-zinc-dark prose-code:bg-stone/30 prose-code:rounded
      prose-hr:border-stone
      prose-table:text-sm
      prose-th:bg-zinc-dark prose-th:text-cream prose-th:font-bold prose-th:text-xs
      prose-th:uppercase prose-th:tracking-wide prose-th:px-4 prose-th:py-2
      prose-td:px-4 prose-td:py-2 prose-td:border-b prose-td:border-stone
    ">
      <ReactMarkdown remarkPlugins={[remarkGfm]}>{content}</ReactMarkdown>
    </div>
  );
}
