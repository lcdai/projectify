import { Link } from "react-router-dom";

export default function MainLayout({ children }) {
  return (
    <div>
      <nav style={{ padding: "10px", borderBottom: "1px solid #ccc" }}>
        <Link to="/" style={{ marginRight: "10px" }}>Home</Link>
        <Link to="/dashboard" style={{ marginRight: "10px" }}>Dashboard</Link>
        <Link to="/projects" style={{ marginRight: "10px" }}>Projects</Link>
        <Link to="/login">Login</Link>
      </nav>

      <main style={{ padding: "20px" }}>
        {children}
      </main>
    </div>
  );
}
