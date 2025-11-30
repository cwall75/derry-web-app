import React from 'react';

const MissingPoster = ({ victim, showDetails = false }) => {
  if (!victim) return null;

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      month: 'long',
      day: 'numeric',
      year: 'numeric'
    });
  };

  const placeholderImage = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="400" height="500"%3E%3Crect fill="%23cccccc" width="400" height="500"/%3E%3Ctext x="50%25" y="50%25" text-anchor="middle" fill="%23666666" font-size="20" font-family="Arial"%3ENo Photo Available%3C/text%3E%3C/svg%3E';

  return (
    <div className="poster-container poster-border aged-paper max-w-2xl mx-auto p-8">
      {/* Header */}
      <div className="text-center mb-6">
        <h1 className="missing-header mb-2">MISSING</h1>
        <div className="h-1 bg-black w-full my-4"></div>
        <p className="case-number text-gray-700">
          CASE NO: {victim.case_number}
        </p>
      </div>

      {/* Photo */}
      <div className="flex justify-center mb-6">
        <img
          src={victim.photo_url || placeholderImage}
          alt={`${victim.first_name} ${victim.last_name}`}
          className="victim-photo w-64 h-80 object-cover"
          onError={(e) => {
            e.target.src = placeholderImage;
          }}
        />
      </div>

      {/* Victim Information */}
      <div className="space-y-4 mb-6 font-vintage">
        <div className="text-center">
          <h2 className="text-4xl font-bold mb-2">
            {victim.first_name} {victim.last_name}
            {victim.nickname && (
              <span className="text-2xl text-gray-600 ml-2">"{victim.nickname}"</span>
            )}
          </h2>
        </div>

        <div className="grid grid-cols-2 gap-4 text-lg">
          <div>
            <span className="font-bold">AGE:</span> {victim.age_at_disappearance}
          </div>
          <div>
            <span className="font-bold">STATUS:</span> {victim.status}
          </div>
        </div>

        <div className="border-t-2 border-black pt-4">
          <p className="font-bold text-xl mb-2">LAST SEEN:</p>
          <p className="text-lg">{formatDate(victim.disappearance_date)}</p>
          <p className="text-lg">{victim.last_seen_location}</p>
          <p className="text-sm text-gray-600 mt-1">Derry, Maine</p>
        </div>

        {victim.physical_description && (
          <div className="border-t-2 border-black pt-4">
            <p className="font-bold text-xl mb-2">PHYSICAL DESCRIPTION:</p>
            <p className="text-lg">{victim.physical_description}</p>
          </div>
        )}

        {/* Sightings */}
        {showDetails && victim.sightings && victim.sightings.length > 0 && (
          <div className="border-t-2 border-black pt-4">
            <p className="font-bold text-xl mb-3">REPORTED SIGHTINGS:</p>
            <div className="space-y-3">
              {victim.sightings.map((sighting) => (
                <div key={sighting.id} className="bg-derry-aged p-3 rounded">
                  <p className="text-sm font-bold">{formatDate(sighting.sighting_date)}</p>
                  <p className="text-sm">Location: {sighting.location}</p>
                  {sighting.witness_name && (
                    <p className="text-sm">Witness: {sighting.witness_name}</p>
                  )}
                  {sighting.description && (
                    <p className="text-sm mt-1 italic">{sighting.description}</p>
                  )}
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Personal Effects */}
        {showDetails && victim.personal_effects && victim.personal_effects.length > 0 && (
          <div className="border-t-2 border-black pt-4">
            <p className="font-bold text-xl mb-3">PERSONAL EFFECTS RECOVERED:</p>
            <div className="space-y-2">
              {victim.personal_effects.map((effect) => (
                <div key={effect.id} className="bg-derry-aged p-3 rounded">
                  <p className="font-bold">{effect.item_description}</p>
                  {effect.found_location && (
                    <p className="text-sm">Found at: {effect.found_location}</p>
                  )}
                  {effect.found_date && (
                    <p className="text-sm">Found on: {formatDate(effect.found_date)}</p>
                  )}
                </div>
              ))}
            </div>
          </div>
        )}
      </div>

      {/* Footer */}
      <div className="border-t-4 border-double border-black pt-6 text-center">
        <p className="text-lg font-bold mb-2">
          IF YOU HAVE ANY INFORMATION
        </p>
        <p className="text-base mb-1">
          Please contact Derry Police Department
        </p>
        <p className="text-2xl font-bold tracking-wider">
          207-555-DERRY
        </p>
        <p className="text-sm text-gray-600 mt-4 italic">
          Derry Police Department • Derry, Maine • {victim.decade}
        </p>
      </div>
    </div>
  );
};

export default MissingPoster;
