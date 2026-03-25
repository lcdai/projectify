import React from "react";
import { Link } from "react-router-dom";

const MainLayout = ({ children }) => {
  return (
    <div>
      <nav style={{ padding: "10px", borderBottom: "1px solid #ccc" }}>
        <Link to="/" style={{ marginRight: "10px" }}>Home</Link>
        <Link to="/projects">Projects</Link>
      </nav>

      <main style={{ padding: "20px" }}>
        {children}
      </main>
    </div>
  );
};

export default MainLayout;
