export default function MaintenancePage() {
  return (
    <div
      style={{
        fontFamily: 'Inter, Arial, Helvetica, sans-serif',
        background: '#F5F0E8',
        minHeight: '100vh',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '2rem',
      }}
    >
      <div style={{ maxWidth: '480px', textAlign: 'center' }}>
        {/* Rune mark */}
        <span
          style={{
            display: 'inline-flex',
            alignItems: 'center',
            justifyContent: 'center',
            width: '56px',
            height: '56px',
            background: '#C4985A',
            borderRadius: '2px',
            fontWeight: 800,
            fontSize: '1.6rem',
            color: '#F5F0E8',
            lineHeight: 1,
            marginBottom: '2.5rem',
          }}
        >
          B
        </span>

        <h1
          style={{
            fontSize: 'clamp(2rem, 4vw, 2.75rem)',
            fontWeight: 800,
            lineHeight: 1.1,
            letterSpacing: '-0.02em',
            color: '#1C1C1C',
            marginBottom: '1rem',
          }}
        >
          Bragi &amp; Co.
        </h1>

        <div
          style={{
            width: '3rem',
            height: '2px',
            background: '#C4985A',
            margin: '0 auto 1.5rem',
          }}
        />

        <p
          style={{
            fontSize: '1rem',
            lineHeight: 1.6,
            color: '#9B9B8C',
            marginBottom: '2rem',
          }}
        >
          AI strategy and compliance advisory for enterprise teams.
          Launching soon.
        </p>

        <a
          href="mailto:info@bragiandco.com"
          style={{
            display: 'inline-block',
            fontSize: '0.88rem',
            fontWeight: 700,
            color: '#C4985A',
            textDecoration: 'none',
            borderBottom: '1px solid #C4985A',
            paddingBottom: '2px',
          }}
        >
          info@bragiandco.com
        </a>
      </div>

      <footer
        style={{
          position: 'absolute',
          bottom: '2rem',
          fontSize: '0.72rem',
          color: '#9B9B8C',
        }}
      >
        &copy; 2026 Bragi &amp; Co. ApS &middot; Copenhagen
      </footer>
    </div>
  );
}