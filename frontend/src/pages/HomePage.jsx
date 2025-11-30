import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { victimApi } from '../services/api';
import MissingPoster from '../components/MissingPoster';

const HomePage = () => {
  const [victim, setVictim] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  const loadRandomVictim = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await victimApi.getRandom();
      setVictim(response.data);
    } catch (err) {
      setError('Failed to load victim data. Please try again.');
      console.error('Error loading victim:', err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex flex-col items-center justify-center p-4">
      {/* Landing Page - shown when no victim is loaded */}
      {!victim && !loading && (
        <div className="text-center space-y-8 max-w-4xl">
          {/* Title */}
          <div className="space-y-4">
            <h1 className="creepy-title text-8xl md:text-9xl flicker">
              WELCOME TO DERRY
            </h1>
            <div className="h-1 bg-derry-red w-3/4 mx-auto"></div>
            <p className="typewriter-text text-2xl md:text-3xl text-derry-aged tracking-widest">
              Missing Persons Database
            </p>
            <p className="text-lg text-gray-400 italic">
              Derry, Maine • Est. 1715
            </p>
          </div>

          {/* Main CTA Button */}
          <div className="pt-8">
            <button
              onClick={loadRandomVictim}
              className="vintage-button text-2xl px-12 py-6 transform hover:scale-105 transition-transform"
            >
              VIEW MISSING PERSONS
            </button>
          </div>

          {/* Secondary Actions */}
          <div className="pt-8 space-y-4">
            <button
              onClick={() => navigate('/search')}
              className="block mx-auto text-derry-aged hover:text-derry-red transition-colors underline text-lg"
            >
              Search Database
            </button>
          </div>

          {/* Atmospheric Footer */}
          <div className="pt-16 text-center text-sm text-gray-600 typewriter-text">
            <p className="flex items-center justify-center gap-2">
              "We all float down here..."
              <span className="text-2xl animate-pulse" style={{ filter: 'drop-shadow(0 0 3px #dc143c)' }}>
                🎈
              </span>
            </p>
          </div>
        </div>
      )}

      {/* Loading State */}
      {loading && (
        <div className="flex flex-col items-center space-y-4">
          <div className="spinner"></div>
          <p className="text-derry-aged text-xl typewriter-text">
            Loading case file...
          </p>
        </div>
      )}

      {/* Error State */}
      {error && (
        <div className="text-center space-y-4">
          <p className="text-derry-red text-xl">{error}</p>
          <button onClick={loadRandomVictim} className="vintage-button">
            Try Again
          </button>
        </div>
      )}

      {/* Poster Display */}
      {victim && !loading && (
        <div className="space-y-6 w-full max-w-3xl animate-fadeIn">
          <MissingPoster victim={victim} />

          {/* Action Buttons */}
          <div className="flex flex-wrap justify-center gap-4">
            <button
              onClick={loadRandomVictim}
              className="vintage-button"
            >
              View Another Case
            </button>
            <button
              onClick={() => navigate(`/victim/${victim.id}`)}
              className="vintage-button"
            >
              Full Case Details
            </button>
            <button
              onClick={() => navigate('/search')}
              className="vintage-button"
            >
              Search Database
            </button>
          </div>

          {/* Back to Home */}
          <div className="text-center">
            <button
              onClick={() => setVictim(null)}
              className="text-derry-aged hover:text-derry-red transition-colors underline"
            >
              ← Back to Home
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default HomePage;
