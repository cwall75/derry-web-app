-- Database schema for Derry Missing Persons Registry

CREATE TABLE IF NOT EXISTS victims (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    nickname VARCHAR(50),
    age_at_disappearance INTEGER NOT NULL,
    date_of_birth DATE NOT NULL,
    disappearance_date DATE NOT NULL,
    last_seen_location VARCHAR(255) NOT NULL,
    physical_description TEXT,
    photo_url VARCHAR(500),
    status VARCHAR(50) DEFAULT 'Missing',
    case_number VARCHAR(50) UNIQUE NOT NULL,
    decade VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS sightings (
    id SERIAL PRIMARY KEY,
    victim_id INTEGER REFERENCES victims(id) ON DELETE CASCADE,
    location VARCHAR(255) NOT NULL,
    witness_name VARCHAR(200),
    sighting_date DATE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS personal_effects (
    id SERIAL PRIMARY KEY,
    victim_id INTEGER REFERENCES victims(id) ON DELETE CASCADE,
    item_description VARCHAR(255) NOT NULL,
    found_location VARCHAR(255),
    found_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for faster searches
CREATE INDEX idx_victims_last_name ON victims(last_name);
CREATE INDEX idx_victims_disappearance_date ON victims(disappearance_date);
CREATE INDEX idx_victims_decade ON victims(decade);
CREATE INDEX idx_victims_status ON victims(status);
CREATE INDEX idx_sightings_victim_id ON sightings(victim_id);
CREATE INDEX idx_personal_effects_victim_id ON personal_effects(victim_id);
