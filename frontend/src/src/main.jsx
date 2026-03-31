import React from 'react';
import ReactDOM from 'react-dom/client';

function App() {
  const [health, setHealth] = React.useState({ loading: true });

  React.useEffect(() => {
    let cancelled = false;

    async function loadHealth() {
      try {
        const response = await fetch('/api/health');
        const data = await response.json();
        if (!cancelled) {
          setHealth({ loading: false, data });
        }
      } catch (error) {
        if (!cancelled) {
          setHealth({ loading: false, error: error.message });
        }
      }
    }

    loadHealth();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <main style={styles.page}>
      <section style={styles.card}>
        <p style={styles.kicker}>Jerney</p>
        <h1 style={styles.title}>Frontend container is running</h1>
        <p style={styles.body}>
          This lightweight React entrypoint was added so the Vite build has a valid
          application root and can confirm backend connectivity.
        </p>
        <div style={styles.statusBox}>
          {health.loading ? 'Checking backend health...' : null}
          {health.data ? `Backend: ${health.data.status} - ${health.data.message}` : null}
          {health.error ? `Backend check failed: ${health.error}` : null}
        </div>
      </section>
    </main>
  );
}

const styles = {
  page: {
    minHeight: '100vh',
    margin: 0,
    display: 'grid',
    placeItems: 'center',
    background: 'linear-gradient(135deg, #081f2c 0%, #12344a 45%, #f4b942 100%)',
    color: '#f7fafc',
    fontFamily: 'Segoe UI, sans-serif',
    padding: '24px',
  },
  card: {
    width: 'min(640px, 100%)',
    background: 'rgba(5, 12, 20, 0.72)',
    border: '1px solid rgba(255, 255, 255, 0.12)',
    borderRadius: '24px',
    padding: '32px',
    boxShadow: '0 20px 60px rgba(0, 0, 0, 0.35)',
  },
  kicker: {
    textTransform: 'uppercase',
    letterSpacing: '0.2em',
    color: '#f4b942',
    fontSize: '0.8rem',
    marginBottom: '12px',
  },
  title: {
    margin: '0 0 16px',
    fontSize: 'clamp(2rem, 4vw, 3rem)',
  },
  body: {
    margin: '0 0 24px',
    lineHeight: 1.6,
    color: '#d7e3ed',
  },
  statusBox: {
    padding: '16px 18px',
    borderRadius: '16px',
    background: 'rgba(255, 255, 255, 0.08)',
    color: '#fef3c7',
    lineHeight: 1.5,
  },
};

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
