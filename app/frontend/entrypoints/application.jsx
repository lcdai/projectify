import React from "react"
import { createRoot } from "react-dom/client"
import Router from "../router"

const el = document.getElementById("root")
if (el) {
  createRoot(el).render(<Router />)
}
