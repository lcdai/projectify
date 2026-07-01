import { useEffect, useState } from "react";
import api from "../lib/api";

export default function Dashboard() {
  const [dashboard, setDashboard] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api
      .get("/dashboard")
      .then((response) => setDashboard(response.data))
      .finally(() => setLoading(false));
  }, []);

  if (loading) {
    return <p>Loading dashboard...</p>;
  }

  if (!dashboard) {
    return <p>Could not load dashboard.</p>;
  }

  const { stats, recent_activities } = dashboard;

  return (
    <div>
      <h1>Dashboard</h1>

      <div style={{ display: "grid", gridTemplateColumns: "repeat(4, 1fr)", gap: "16px" }}>
        <StatCard label="Projects" value={stats.projects_count} />
        <StatCard label="Tasks" value={stats.tasks_count} />
        <StatCard label="To Do" value={stats.todo_tasks_count} />
        <StatCard label="Completed" value={stats.completed_tasks_count} />
      </div>

      <h2 style={{ marginTop: "32px" }}>Recent Activity</h2>

      {recent_activities.length === 0 ? (
        <p>No recent activity yet.</p>
      ) : (
        <ul>
          {recent_activities.map((activity) => (
            <li key={activity.id} style={{ marginBottom: "12px" }}>
              <strong>{activity.action}</strong>
              <div>{activity.details}</div>
              <small>{new Date(activity.created_at).toLocaleString()}</small>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

function StatCard({ label, value }) {
  return (
    <div style={{ padding: "16px", border: "1px solid #ddd", borderRadius: "8px" }}>
      <div style={{ fontSize: "24px", fontWeight: "bold" }}>{value}</div>
      <div>{label}</div>
    </div>
  );
}
