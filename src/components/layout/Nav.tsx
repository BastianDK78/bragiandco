import Link from 'next/link';

export function Nav({ activePage }: { activePage?: string }) {
  const links = [
    { label: 'Heatmap',           href: '/heatmap' },
    { label: 'Obligation Decoder', href: '/obligation-decoder' },
    { label: '90-Day Roadmap',    href: '/roadmap' },
    { label: 'Notice Templates',  href: '/templates' },
  ];

  return (
    <header
      className="sticky top-0 z-50"
      style={{ background: '#F5F0E8', borderBottom: '2px solid #C4985A' }}
    >
      <div
        className="flex items-center justify-between gap-6 px-8"
        style={{ maxWidth: '1400px', margin: '0 auto', height: '65px' }}
      >
        {/* Logo */}
        <Link href="/" className="flex items-center gap-3 no-underline">
          <span
            aria-label="Bragi rune mark"
            style={{
              width: '32px',
              height: '32px',
              background: '#C4985A',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              borderRadius: '2px',
              fontFamily: 'Inter, Arial, sans-serif',
              fontWeight: 800,
              fontSize: '1.05rem',
              color: '#F5F0E8',
              lineHeight: 1,
              flexShrink: 0,
            }}
          >
            B
          </span>
          <span
            style={{
              fontWeight: 800,
              fontSize: '0.78rem',
              letterSpacing: '0.15em',
              textTransform: 'uppercase',
              color: '#1C1C1C',
            }}
          >
            Bragi &amp; Co.
          </span>
        </Link>

        {/* Nav links */}
        <nav className="flex items-center gap-7" aria-label="Product navigation">
          {links.map(({ label, href }) => {
            const isActive = activePage === href;
            return (
              <Link
                key={href}
                href={href}
                className="no-underline transition-colors"
                style={{
                  fontSize: '0.78rem',
                  fontWeight: isActive ? 700 : 500,
                  color: isActive ? '#1C1C1C' : '#9B9B8C',
                  position: 'relative',
                  paddingBottom: isActive ? '0.35rem' : '0',
                  ...(isActive ? {
                    // Oak underline via box shadow (no pseudo-elements in inline styles)
                  } : {}),
                }}
              >
                {label}
                {isActive && (
                  <span
                    aria-hidden
                    style={{
                      position: 'absolute',
                      left: 0,
                      right: 0,
                      bottom: '-0.35rem',
                      height: '2px',
                      background: '#C4985A',
                    }}
                  />
                )}
              </Link>
            );
          })}
          <a
            href="mailto:bastian@bragiandco.com"
            style={{
              fontSize: '0.78rem',
              fontWeight: 700,
              color: '#B0864A',
              textDecoration: 'none',
            }}
          >
            Contact
          </a>
        </nav>
      </div>
    </header>
  );
}
