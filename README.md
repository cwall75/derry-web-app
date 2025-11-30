# Welcome to Derry - Missing Persons Database

<div align="center">

![Derry](https://img.shields.io/badge/Location-Derry%2C%20Maine-darkred)
![Status](https://img.shields.io/badge/Status-Active-red)
![Victims](https://img.shields.io/badge/Cases-60-crimson)

*"We all float down here..."*

</div>

A creepy, immersive web application featuring missing persons from Stephen King's "IT" - complete with authentic 1980s missing persons posters, database search functionality, and atmospheric horror vibes.

## 🎈 Features

- **Authentic Missing Persons Posters**: Vintage 1980s-style posters with aged paper texture, distressed aesthetics
- **Random Victim Display**: Click a button to view a random missing person case
- **Comprehensive Database**: 60 victims spanning 4 decades (1920s, 1950s, 1980s, 2010s)
- **Advanced Search & Filtering**: Search by name, case number, decade, status, age range, and location
- **Detailed Case Files**: View sightings, personal effects recovered, and full victim information
- **Dark, Atmospheric UI**: Blood-red accents, creepy fonts, and unsettling atmosphere
- **Fully Responsive**: Works on desktop, tablet, and mobile devices

## 🏗️ Architecture

### Tech Stack

- **Frontend**: React 18 + Vite + Tailwind CSS
- **Backend**: Python FastAPI
- **Database**: PostgreSQL 15
- **Deployment**: Docker Compose
- **Images**: 60 AI-generated victim photos

### Project Structure

```
derry-web-app/
├── docker-compose.yml          # Master orchestration file
├── database/                   # Database files
│   ├── init.sql               # Database schema
│   ├── derry_missing_backup.sql # Full database backup with data
│   ├── init-db.sh             # Database initialization script
│   ├── seed_database.py       # Optional seeding script
│   └── ...
├── backend/                    # FastAPI backend
│   ├── app/
│   │   ├── main.py            # Main application
│   │   ├── database.py        # Database connection
│   │   ├── models.py          # Pydantic models
│   │   └── routes/
│   │       └── victims.py     # API routes
│   ├── Dockerfile
│   └── requirements.txt
├── frontend/                   # React frontend
│   ├── src/
│   │   ├── components/        # React components
│   │   ├── pages/             # Page components
│   │   ├── services/          # API client
│   │   └── main.jsx
│   ├── Dockerfile
│   ├── nginx.conf             # Nginx configuration
│   └── package.json
└── static/                     # Static files
    └── images/
        └── victims/            # Victim photos (60 images)
```

## 🚀 Quick Start

### Prerequisites

- Docker Desktop installed
- At least 2GB of free RAM
- Port 80 (frontend), 8000 (backend), and 5432 (database) available

### One-Command Startup

```bash
docker-compose up --build
```

That's it! The application will:
1. Initialize the PostgreSQL database
2. Restore from backup (includes all 60 victims with photos)
3. Start the FastAPI backend
4. Build and launch the React frontend
5. Be available at http://localhost

### Accessing the Application

- **Frontend**: http://localhost
- **Backend API**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs
- **Database**: localhost:5432 (credentials in .env.example)

## 🗄️ Database

### Schema

#### `victims` Table
- **id**: Primary key
- **first_name, last_name, nickname**: Victim's name
- **age_at_disappearance**: Age when disappeared
- **date_of_birth**: Birth date
- **disappearance_date**: Date of disappearance
- **last_seen_location**: Last known location
- **physical_description**: Physical description
- **photo_url**: Path to victim photo
- **status**: Missing | Presumed Dead | Body Found
- **case_number**: Unique case identifier (e.g., DPD-1957-0042)
- **decade**: 1920s | 1950s | 1980s | 2010s

#### `sightings` Table
- **id**: Primary key
- **victim_id**: Foreign key to victims
- **location**: Sighting location
- **witness_name**: Name of witness
- **sighting_date**: Date of sighting
- **description**: Sighting details

#### `personal_effects` Table
- **id**: Primary key
- **victim_id**: Foreign key to victims
- **item_description**: Description of item found
- **found_location**: Where item was found
- **found_date**: When item was found

### Database Initialization

The database initialization process (`database/init-db.sh`):

1. **Checks for existing data**: If database already has victims, skips initialization
2. **Backup restoration**: If `derry_missing_backup.sql` exists, restores from backup (recommended)
3. **Fallback to schema**: If no backup, creates schema from `init.sql`

The backup file includes all 60 victims with photos already configured!

### Database Credentials

```
Host: localhost (or 'postgres' from within Docker network)
Port: 5432
Database: derry_missing
User: derry_admin
Password: pennywise1958
```

## 🔌 API Endpoints

### Victims

- `GET /api/victim/random` - Get random victim with all details
- `GET /api/victim/{id}` - Get specific victim by ID
- `GET /api/victims` - Get all victims (supports filtering)
- `GET /api/search?q={query}` - Search victims by name/case number
- `GET /api/filter?decade=1950s&status=Missing` - Filter victims
- `GET /api/stats` - Get database statistics

### Query Parameters

**`/api/victims` and `/api/filter`**:
- `search`: Search by name or case number
- `decade`: Filter by decade (1920s, 1950s, 1980s, 2010s)
- `status`: Filter by status
- `age_min`: Minimum age
- `age_max`: Maximum age
- `location`: Filter by location (partial match)
- `limit`: Results per page (default: 100)
- `offset`: Pagination offset (default: 0)

### Example Requests

```bash
# Get random victim
curl http://localhost:8000/api/victim/random

# Search for "George"
curl http://localhost:8000/api/search?q=George

# Filter 1950s cases
curl http://localhost:8000/api/filter?decade=1950s

# Get statistics
curl http://localhost:8000/api/stats
```

## 🎨 UI/UX Features

### Color Palette

- **Dark Background**: `#0a0a0a` (derry-dark)
- **Charcoal**: `#1a1a1a` (derry-charcoal)
- **Blood Red**: `#8b0000` (derry-blood)
- **Crimson**: `#dc143c` (derry-red)
- **Aged Paper**: `#f4f1e8` (derry-paper)

### Typography

- **Headlines**: Creepster (Google Fonts)
- **Body**: Special Elite (typewriter font)
- **Posters**: Georgia (vintage serif)
- **Code/Data**: Courier New (monospace)

### Poster Design

The missing persons posters are designed to look like authentic 1980s police flyers:

- Aged paper texture with grain
- Black border with shadow effects
- Large "MISSING" header in blood red
- Victim photo with vintage filter (sepia, high contrast)
- Official case number in police format
- Last seen date and location
- Physical description
- Derry Police Department contact info
- Weathered, distressed appearance

## 🖼️ Adding More Victims

### 1. Add Victim Photo

Place image in `static/images/victims/` with naming format:
```
DPD_YYYY_NNNN.jpg
```

Example: `DPD_1985_0015.jpg` (Derry Police Dept, 1985, case #15)

### 2. Add to Database

```sql
INSERT INTO victims (
    first_name, last_name, age_at_disappearance,
    date_of_birth, disappearance_date, last_seen_location,
    physical_description, photo_url, status, case_number, decade
) VALUES (
    'Jane', 'Doe', 14,
    '1971-05-20', '1985-07-15', 'The Barrens',
    '5''4", brown hair, green eyes',
    '/images/victims/DPD_1985_0015.jpg',
    'Missing', 'DPD-1985-0015', '1980s'
);
```

### 3. Rebuild

```bash
docker-compose down
docker-compose up --build
```

## 🛠️ Development

### Running in Development Mode

**Backend Only** (with hot reload):
```bash
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

**Frontend Only** (with hot reload):
```bash
cd frontend
npm install
npm run dev
```

**Database Only**:
```bash
docker-compose up postgres
```

### Environment Variables

Copy `.env.example` to `.env` and modify as needed:

```bash
cp .env.example .env
```

## 🧪 Testing

### Health Check

```bash
curl http://localhost:8000/health
```

Expected response:
```json
{
  "status": "healthy",
  "database": "connected"
}
```

### Verify Database

```bash
docker-compose exec postgres psql -U derry_admin -d derry_missing -c "SELECT COUNT(*) FROM victims;"
```

Should return: `60`

### Verify Images

```bash
ls -1 static/images/victims/ | wc -l
```

Should return: `60`

## 📊 Database Statistics

After startup, you should have:

- **60 victims** across 4 decades (15 per decade)
- **~24 sightings** (40% of victims have 1-3 sightings)
- **~30 personal effects** (50% of victims have 1-2 items)
- **Status distribution**: ~85% Missing, ~10% Presumed Dead, ~5% Body Found
- **Age range**: Mostly 6-16 years old (children), some 17-25 (young adults)

## 🎭 Themed Locations

Victims were last seen at authentic IT locations:

- The Barrens
- Neibolt Street (The Old House)
- Canal Street Storm Drain
- The Standpipe
- Derry Elementary School
- Bassey Park
- The Kissing Bridge
- Derry Public Library
- And more...

## 🐛 Troubleshooting

### Database Won't Initialize

```bash
# Remove volume and restart
docker-compose down -v
docker-compose up --build
```

### Frontend Can't Connect to Backend

Check nginx configuration in `frontend/nginx.conf`:
```nginx
location /api {
    proxy_pass http://backend:8000;
    ...
}
```

### Images Not Loading

Verify:
1. Images exist in `static/images/victims/`
2. Backend has volume mounted: `./static:/app/static:ro`
3. Photo URLs in database start with `/images/victims/`

### Port Already in Use

Edit `docker-compose.yml` to change ports:
```yaml
ports:
  - "8080:80"  # Frontend on 8080 instead of 80
```

## 📝 License

This project is for educational and entertainment purposes. Stephen King's "IT" and all related characters are property of Stephen King.

## 🙏 Credits

- **Stephen King** - Original IT novel and characters
- **AI-Generated Images** - Victim photos created with AI
- **Fonts**: Creepster, Special Elite (Google Fonts)

## 🌟 Future Enhancements

Potential stretch goals:

- [ ] Print-friendly CSS for posters
- [ ] Downloadable poster PDFs
- [ ] Timeline view across decades
- [ ] Interactive map of Derry locations
- [ ] Dark/light mode toggle
- [ ] Admin panel for adding victims
- [ ] Export database to JSON/CSV
- [ ] Advanced analytics dashboard

---

<div align="center">

**Remember: "We all float down here..."**

*Stay safe in Derry, Maine.*

</div>
