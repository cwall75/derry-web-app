import React from 'react';
import { Routes, Route } from 'react-router-dom';
import HomePage from './pages/HomePage';
import VictimDetailPage from './pages/VictimDetailPage';
import SearchPage from './pages/SearchPage';

function App() {
  return (
    <div className="min-h-screen bg-derry-dark">
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/victim/:id" element={<VictimDetailPage />} />
        <Route path="/search" element={<SearchPage />} />
      </Routes>
    </div>
  );
}

export default App;
