import {
  createBrowserRouter,
} from "react-router-dom";

import Home from "./pages/Home";
import Login from "./pages/Login";
import Projects from "./pages/Projects";

const router = createBrowserRouter([
  {
    path: "/",
    element: <Home />,
  },
  {
    path: "/login",
    element: <Login />,
  },
  {
    path: "/projects",
    element: <Projects />,
  },
]);

export default router;
