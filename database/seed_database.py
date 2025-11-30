import os
import random
import psycopg2
from datetime import datetime, timedelta
from faker import Faker

fake = Faker()

# Derry-specific locations from IT
DERRY_LOCATIONS = [
    "The Barrens",
    "Neibolt Street (The Old House)",
    "Canal Street Storm Drain",
    "The Standpipe",
    "Derry Elementary School",
    "Bassey Park",
    "Kansas Street",
    "Witcham Street",
    "Costello Avenue",
    "The Public Library",
    "Tracker Brothers Depot",
    "Derry High School",
    "Memorial Park",
    "The Kissing Bridge",
    "Up-Mile Hill",
    "The Derry Town House",
    "Silver Ball Arcade",
    "The Aladdin Theater",
    "Center Street",
    "Main Street"
]

# Items that might be found
PERSONAL_ITEMS = [
    "Yellow raincoat",
    "Paper boat",
    "Library book",
    "School backpack",
    "Baseball cap",
    "Red balloon",
    "Bicycle",
    "Sneakers",
    "Glasses",
    "Lunchbox",
    "Comic book",
    "Baseball glove",
    "Jacket",
    "Wristwatch",
    "Hair ribbon",
    "Skateboard",
    "Camera",
    "Notebook",
    "Toy car",
    "Silver dollar"
]

# Physical descriptions
HAIR_COLORS = ["Brown", "Blonde", "Black", "Red", "Light brown", "Dark brown", "Auburn"]
EYE_COLORS = ["Blue", "Brown", "Green", "Hazel", "Gray"]

# IT's 27-year cycle
CYCLES = [
    ("1929-1930", "1920s"),
    ("1957-1958", "1950s"),
    ("1984-1985", "1980s"),
    ("2016-2017", "2010s")
]

def connect_db():
    """Connect to PostgreSQL database"""
    return psycopg2.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        port=os.getenv('DB_PORT', '5432'),
        database=os.getenv('DB_NAME', 'derry_missing'),
        user=os.getenv('DB_USER', 'derry_admin'),
        password=os.getenv('DB_PASSWORD', 'pennywise1958')
    )

def generate_case_number(year, index):
    """Generate a case number like DPD-1957-0042"""
    return f"DPD-{year}-{index:04d}"

def generate_physical_description(age):
    """Generate a physical description"""
    height_inches = random.randint(48, 72) if age >= 12 else random.randint(36, 60)
    height_feet = height_inches // 12
    height_remaining = height_inches % 12
    
    hair = random.choice(HAIR_COLORS)
    eyes = random.choice(EYE_COLORS)
    
    descriptions = [
        f"{height_feet}'{height_remaining}\" tall, {hair.lower()} hair, {eyes.lower()} eyes",
        f"Approximately {height_feet}'{height_remaining}\", {hair.lower()} hair, {eyes.lower()} eyes",
        f"{hair} hair, {eyes.lower()} eyes, {height_feet} feet {height_remaining} inches tall"
    ]
    
    # Add distinctive features sometimes
    if random.random() > 0.6:
        features = [
            "Freckles across nose",
            "Small scar on left cheek",
            "Dimples when smiling",
            "Birthmark on right arm",
            "Missing front tooth",
            "Wears braces",
            "Small birthmark on neck"
        ]
        descriptions[0] += f". {random.choice(features)}"
    
    return random.choice(descriptions)

def generate_victims(conn, num_per_cycle=15):
    """Generate victim records"""
    cursor = conn.cursor()
    victim_ids = []
    
    for cycle_years, decade in CYCLES:
        start_year, end_year = map(int, cycle_years.split('-'))
        
        for i in range(num_per_cycle):
            # Generate dates
            disappearance_year = random.randint(start_year, end_year)
            disappearance_month = random.randint(1, 12)
            disappearance_day = random.randint(1, 28)
            disappearance_date = datetime(disappearance_year, disappearance_month, disappearance_day)
            
            # Age at disappearance (mostly children, some teens)
            age = random.randint(6, 16) if random.random() > 0.1 else random.randint(17, 25)
            
            # Calculate birth date
            birth_date = disappearance_date - timedelta(days=age*365.25)
            
            # Generate name
            is_male = random.choice([True, False])
            first_name = fake.first_name_male() if is_male else fake.first_name_female()
            last_name = fake.last_name()
            
            # Nickname (sometimes)
            nickname = None
            if random.random() > 0.7:
                nicknames = [first_name[:3] + "y", first_name[:4] + "ie", first_name]
                nickname = random.choice(nicknames) if first_name != random.choice(nicknames) else None
            
            # Location
            location = random.choice(DERRY_LOCATIONS)
            
            # Physical description
            description = generate_physical_description(age)
            
            # Status (mostly missing, some found)
            status = random.choices(
                ["Missing", "Presumed Dead", "Body Found"],
                weights=[0.85, 0.10, 0.05]
            )[0]
            
            # Case number
            case_number = generate_case_number(disappearance_year, i + 1)
            
            cursor.execute("""
                INSERT INTO victims (
                    first_name, last_name, nickname, age_at_disappearance,
                    date_of_birth, disappearance_date, last_seen_location,
                    physical_description, status, case_number, decade
                )
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING id
            """, (
                first_name, last_name, nickname, age,
                birth_date, disappearance_date, location,
                description, status, case_number, decade
            ))
            
            victim_id = cursor.fetchone()[0]
            victim_ids.append((victim_id, disappearance_date, location))
            
            print(f"Added victim: {first_name} {last_name}, age {age}, disappeared {disappearance_date.strftime('%Y-%m-%d')}")
    
    conn.commit()
    return victim_ids

def generate_sightings(conn, victim_ids):
    """Generate sighting records"""
    cursor = conn.cursor()
    
    # Generate 1-3 sightings for about 40% of victims
    for victim_id, disappearance_date, last_location in victim_ids:
        if random.random() > 0.6:
            num_sightings = random.randint(1, 3)
            
            for _ in range(num_sightings):
                # Sighting within 7 days before disappearance
                days_before = random.randint(1, 7)
                sighting_date = disappearance_date - timedelta(days=days_before)
                
                location = random.choice(DERRY_LOCATIONS)
                witness = f"{fake.first_name()} {fake.last_name()}"
                
                descriptions = [
                    f"Seen walking alone near {location}",
                    f"Observed playing with friends at {location}",
                    f"Spotted riding bicycle near {location}",
                    f"Last seen walking home from school",
                    f"Witnessed at {location} around dusk",
                    f"Seen with unknown adult near {location}",
                    f"Observed looking into storm drain"
                ]
                
                description = random.choice(descriptions)
                
                cursor.execute("""
                    INSERT INTO sightings (
                        victim_id, location, witness_name, sighting_date, description
                    )
                    VALUES (%s, %s, %s, %s, %s)
                """, (victim_id, location, witness, sighting_date, description))
    
    conn.commit()
    print(f"Generated sightings for victims")

def generate_personal_effects(conn, victim_ids):
    """Generate personal effects records"""
    cursor = conn.cursor()
    
    # Generate 1-2 items for about 50% of victims
    for victim_id, disappearance_date, last_location in victim_ids:
        if random.random() > 0.5:
            num_items = random.randint(1, 2)
            
            for _ in range(num_items):
                item = random.choice(PERSONAL_ITEMS)
                
                # Found within 30 days after disappearance
                days_after = random.randint(1, 30)
                found_date = disappearance_date + timedelta(days=days_after)
                
                # Usually found near last seen location or in The Barrens
                found_location = random.choice([last_location, "The Barrens", random.choice(DERRY_LOCATIONS)])
                
                cursor.execute("""
                    INSERT INTO personal_effects (
                        victim_id, item_description, found_location, found_date
                    )
                    VALUES (%s, %s, %s, %s)
                """, (victim_id, item, found_location, found_date))
    
    conn.commit()
    print(f"Generated personal effects for victims")

def main():
    print("Connecting to Derry Missing Persons Database...")
    
    try:
        conn = connect_db()
        print("Connected successfully!")
        
        print("\nGenerating victim records...")
        victim_ids = generate_victims(conn, num_per_cycle=15)
        
        print("\nGenerating sightings...")
        generate_sightings(conn, victim_ids)
        
        print("\nGenerating personal effects...")
        generate_personal_effects(conn, victim_ids)
        
        # Print summary
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*) FROM victims")
        victim_count = cursor.fetchone()[0]
        
        cursor.execute("SELECT COUNT(*) FROM sightings")
        sighting_count = cursor.fetchone()[0]
        
        cursor.execute("SELECT COUNT(*) FROM personal_effects")
        effects_count = cursor.fetchone()[0]
        
        print("\n" + "="*60)
        print("DATABASE SEEDING COMPLETE")
        print("="*60)
        print(f"Total victims: {victim_count}")
        print(f"Total sightings: {sighting_count}")
        print(f"Total personal effects: {effects_count}")
        print("="*60)
        
        conn.close()
        
    except Exception as e:
        print(f"Error: {e}")
        raise

if __name__ == "__main__":
    main()
