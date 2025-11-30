import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { victimApi } from '../services/api';

const SearchPage = () => {
  const navigate = useNavigate();
  const [victims, setVictims] = useState([]);
  const [loading, setLoading] = useState(false);
  const [stats, setStats] = useState(null);

  // Filter state
  const [searchQuery, setSearchQuery] = useState('');
  const [filters, setFilters] = useState({
    decade: '',
    status: '',
    age_min: '',
    age_max: '',
  });

  useEffect(() => {
    loadStats();
    loadVictims();
  }, []);

  const loadStats = async () => {
    try {
      const response = await victimApi.getStats();
      setStats(response.data);
    } catch (err) {
      console.error('Error loading stats:', err);
    }
  };

  const loadVictims = async () => {
    setLoading(true);
    try {
      const params = {
        ...filters,
        search: searchQuery || undefined,
        limit: 100,
      };

      // Remove empty values
      Object.keys(params).forEach(key => {
        if (params[key] === '' || params[key] === undefined) {
          delete params[key];
        }
      });

      const response = await victimApi.getAll(params);
      setVictims(response.data.victims);
    } catch (err) {
      console.error('Error loading victims:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleSearch = (e) => {
    e.preventDefault();
    loadVictims();
  };

  const handleFilterChange = (key, value) => {
    setFilters(prev => ({ ...prev, [key]: value }));
  };

  const clearFilters = () => {
    setSearchQuery('');
    setFilters({
      decade: '',
      status: '',
      age_min: '',
      age_max: '',
    });
    setTimeout(loadVictims, 100);
  };

  const VictimCard = ({ victim }) => {
    const placeholderImage = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="200" height="250"%3E%3Crect fill="%23333333" width="200" height="250"/%3E%3Ctext x="50%25" y="50%25" text-anchor="middle" fill="%23666666" font-size="12" font-family="Arial"%3ENo Photo%3C/text%3E%3C/svg%3E';

    return (
      <div
        onClick={() => navigate(`/victim/${victim.id}`)}
        className="bg-derry-paper border-4 border-black p-4 cursor-pointer hover:scale-105 transition-transform shadow-lg"
      >
        <img
          src={victim.photo_url || placeholderImage}
          alt={`${victim.first_name} ${victim.last_name}`}
          className="w-full h-48 object-cover border-2 border-black mb-3"
          onError={(e) => {
            e.target.src = placeholderImage;
          }}
        />
        <div className="text-center">
          <p className="text-derry-blood font-bold text-lg mb-1">MISSING</p>
          <h3 className="font-vintage text-xl font-bold">
            {victim.first_name} {victim.last_name}
          </h3>
          <p className="text-sm text-gray-700 mt-1">Age {victim.age_at_disappearance}</p>
          <p className="text-xs text-gray-600 mt-1">{victim.case_number}</p>
          <p className="text-xs text-gray-600">{victim.decade}</p>
        </div>
      </div>
    );
  };

  return (
    <div className="min-h-screen p-4 py-12">
      <div className="max-w-7xl mx-auto">
        {/* Header */}
        <div className="text-center mb-8">
          <h1 className="creepy-title text-7xl mb-4">DATABASE SEARCH</h1>
          <p className="text-derry-aged text-xl typewriter-text">
            Derry Missing Persons Registry
          </p>
          <button
            onClick={() => navigate('/')}
            className="mt-4 text-derry-aged hover:text-derry-red transition-colors underline"
          >
            ← Return to Home
          </button>
        </div>

        {/* Statistics */}
        {stats && (
          <div className="bg-derry-charcoal p-6 rounded border-2 border-derry-aged mb-8">
            <h2 className="text-2xl font-vintage text-derry-red mb-4">Registry Statistics</h2>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
              <div>
                <p className="text-3xl font-bold text-derry-red">{stats.total_victims}</p>
                <p className="text-gray-400 text-sm">Total Cases</p>
              </div>
              <div>
                <p className="text-3xl font-bold text-derry-red">{stats.total_sightings}</p>
                <p className="text-gray-400 text-sm">Sightings</p>
              </div>
              <div>
                <p className="text-3xl font-bold text-derry-red">{stats.total_personal_effects}</p>
                <p className="text-gray-400 text-sm">Effects Found</p>
              </div>
              <div>
                <p className="text-3xl font-bold text-derry-red">
                  {Object.keys(stats.by_decade).length}
                </p>
                <p className="text-gray-400 text-sm">Decades</p>
              </div>
            </div>
          </div>
        )}

        {/* Search and Filters */}
        <div className="bg-derry-charcoal p-6 rounded border-2 border-derry-aged mb-8">
          <form onSubmit={handleSearch} className="space-y-4">
            {/* Search Bar */}
            <div>
              <label className="block text-derry-aged mb-2 font-vintage">
                Search by Name or Case Number
              </label>
              <div className="flex gap-2">
                <input
                  type="text"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  placeholder="Enter name or case number..."
                  className="flex-1 px-4 py-2 bg-derry-dark border-2 border-derry-aged text-gray-200 font-typewriter focus:border-derry-red outline-none"
                />
                <button type="submit" className="vintage-button">
                  Search
                </button>
              </div>
            </div>

            {/* Filters */}
            <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
              <div>
                <label className="block text-derry-aged mb-2 text-sm">Decade</label>
                <select
                  value={filters.decade}
                  onChange={(e) => handleFilterChange('decade', e.target.value)}
                  className="w-full px-3 py-2 bg-derry-dark border-2 border-derry-aged text-gray-200 font-typewriter focus:border-derry-red outline-none"
                >
                  <option value="">All Decades</option>
                  <option value="1920s">1920s</option>
                  <option value="1950s">1950s</option>
                  <option value="1980s">1980s</option>
                  <option value="2010s">2010s</option>
                </select>
              </div>

              <div>
                <label className="block text-derry-aged mb-2 text-sm">Status</label>
                <select
                  value={filters.status}
                  onChange={(e) => handleFilterChange('status', e.target.value)}
                  className="w-full px-3 py-2 bg-derry-dark border-2 border-derry-aged text-gray-200 font-typewriter focus:border-derry-red outline-none"
                >
                  <option value="">All Statuses</option>
                  <option value="Missing">Missing</option>
                  <option value="Presumed Dead">Presumed Dead</option>
                  <option value="Body Found">Body Found</option>
                </select>
              </div>

              <div>
                <label className="block text-derry-aged mb-2 text-sm">Min Age</label>
                <input
                  type="number"
                  value={filters.age_min}
                  onChange={(e) => handleFilterChange('age_min', e.target.value)}
                  placeholder="Min"
                  className="w-full px-3 py-2 bg-derry-dark border-2 border-derry-aged text-gray-200 font-typewriter focus:border-derry-red outline-none"
                />
              </div>

              <div>
                <label className="block text-derry-aged mb-2 text-sm">Max Age</label>
                <input
                  type="number"
                  value={filters.age_max}
                  onChange={(e) => handleFilterChange('age_max', e.target.value)}
                  placeholder="Max"
                  className="w-full px-3 py-2 bg-derry-dark border-2 border-derry-aged text-gray-200 font-typewriter focus:border-derry-red outline-none"
                />
              </div>
            </div>

            <div className="flex gap-2">
              <button
                type="button"
                onClick={loadVictims}
                className="vintage-button"
              >
                Apply Filters
              </button>
              <button
                type="button"
                onClick={clearFilters}
                className="vintage-button"
              >
                Clear All
              </button>
            </div>
          </form>
        </div>

        {/* Results */}
        {loading ? (
          <div className="flex justify-center items-center py-12">
            <div className="spinner"></div>
          </div>
        ) : (
          <>
            <div className="mb-4 text-derry-aged typewriter-text">
              Found {victims.length} case{victims.length !== 1 ? 's' : ''}
            </div>

            {victims.length === 0 ? (
              <div className="text-center py-12 text-derry-aged">
                <p className="text-xl mb-2">No cases found matching your criteria.</p>
                <p className="text-sm">Try adjusting your search filters.</p>
              </div>
            ) : (
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                {victims.map((victim) => (
                  <VictimCard key={victim.id} victim={victim} />
                ))}
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
};

export default SearchPage;
