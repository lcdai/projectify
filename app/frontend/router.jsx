import React from "react"
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom"

export default function AppRouter() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<h1 className="p-6 text-3xl font-bold">Projectify</h1>} />
        <Route path="*" element={<Navigate to="/" />} />
      </Routes>
    </BrowserRouter>
  )
}
