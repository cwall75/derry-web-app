import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { victimApi } from '../services/api';
import MissingPoster from '../components/MissingPoster';

const VictimDetailPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [victim, setVictim] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    loadVictim();
  }, [id]);

  const loadVictim = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await victimApi.getById(id);
      setVictim(response.data);
    } catch (err) {
      setError('Failed to load victim details. The case file may not exist.');
      console.error('Error loading victim:', err);
    } finally {
      setLoading(false);
    }
  };

  const loadNextVictim = async () => {
    try {
      const response = await victimApi.getRandom();
      navigate(`/victim/${response.data.id}`);
    } catch (err) {
      console.error('Error loading next victim:', err);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="flex flex-col items-center space-y-4">
          <div className="spinner"></div>
          <p className="text-derry-aged text-xl typewriter-text">
            Retrieving case file...
          </p>
        </div>
      </div>
    );
  }

  if (error || !victim) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center space-y-4">
          <p className="text-derry-red text-xl">{error}</p>
          <button onClick={() => navigate('/')} className="vintage-button">
            Return to Home
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen p-4 py-12">
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Header */}
        <div className="text-center mb-8">
          <h1 className="creepy-title text-6xl mb-4">CASE FILE</h1>
          <p className="text-derry-aged text-xl typewriter-text">
            {victim.case_number}
          </p>
        </div>

        {/* Detailed Poster */}
        <MissingPoster victim={victim} showDetails={true} />

        {/* Navigation Buttons */}
        <div className="flex flex-wrap justify-center gap-4">
          <button
            onClick={loadNextVictim}
            className="vintage-button"
          >
            View Another Case
          </button>
          <button
            onClick={() => navigate('/search')}
            className="vintage-button"
          >
            Search Database
          </button>
          <button
            onClick={() => navigate('/')}
            className="vintage-button"
          >
            Return Home
          </button>
        </div>

        {/* Additional Case Information */}
        {(victim.sightings?.length > 0 || victim.personal_effects?.length > 0) && (
          <div className="bg-derry-charcoal p-6 rounded border-2 border-derry-aged">
            <h2 className="text-2xl font-vintage text-derry-red mb-4">
              Case Investigation Summary
            </h2>
            <div className="space-y-2 text-gray-300 typewriter-text">
              <p>• Total Sightings Reported: {victim.sightings?.length || 0}</p>
              <p>• Personal Effects Recovered: {victim.personal_effects?.length || 0}</p>
              <p>• Case Status: {victim.status}</p>
              <p>• Investigation Period: {victim.decade}</p>
            </div>
          </div>
        )}

        {/* Warning Notice */}
        <div className="bg-derry-blood bg-opacity-20 border-2 border-derry-red p-6 text-center">
          <p className="text-derry-aged font-vintage text-lg">
            This case remains open. If you have any information regarding this disappearance,
            please contact the Derry Police Department immediately.
          </p>
        </div>
      </div>
    </div>
  );
};

export default VictimDetailPage;
