"""API routes for victims"""
from fastapi import APIRouter, HTTPException, Query
from typing import Optional
from app.models import VictimBase, VictimDetail, VictimList, SearchFilters, Sighting, PersonalEffect
from app.database import get_db_cursor

router = APIRouter(prefix="/api", tags=["victims"])


@router.get("/victim/random", response_model=VictimDetail)
async def get_random_victim():
    """Get a random victim with all related data"""
    try:
        with get_db_cursor() as cursor:
            # Get random victim
            cursor.execute("""
                SELECT * FROM victims
                ORDER BY RANDOM()
                LIMIT 1
            """)
            victim_data = cursor.fetchone()

            if not victim_data:
                raise HTTPException(status_code=404, detail="No victims found")

            victim = dict(victim_data)
            victim_id = victim['id']

            # Get sightings
            cursor.execute("""
                SELECT * FROM sightings
                WHERE victim_id = %s
                ORDER BY sighting_date DESC
            """, (victim_id,))
            sightings = [dict(row) for row in cursor.fetchall()]

            # Get personal effects
            cursor.execute("""
                SELECT * FROM personal_effects
                WHERE victim_id = %s
                ORDER BY found_date DESC
            """, (victim_id,))
            effects = [dict(row) for row in cursor.fetchall()]

            return VictimDetail(
                **victim,
                sightings=[Sighting(**s) for s in sightings],
                personal_effects=[PersonalEffect(**e) for e in effects]
            )

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")


@router.get("/victim/{victim_id}", response_model=VictimDetail)
async def get_victim(victim_id: int):
    """Get a specific victim by ID with all related data"""
    try:
        with get_db_cursor() as cursor:
            # Get victim
            cursor.execute("SELECT * FROM victims WHERE id = %s", (victim_id,))
            victim_data = cursor.fetchone()

            if not victim_data:
                raise HTTPException(status_code=404, detail="Victim not found")

            victim = dict(victim_data)

            # Get sightings
            cursor.execute("""
                SELECT * FROM sightings
                WHERE victim_id = %s
                ORDER BY sighting_date DESC
            """, (victim_id,))
            sightings = [dict(row) for row in cursor.fetchall()]

            # Get personal effects
            cursor.execute("""
                SELECT * FROM personal_effects
                WHERE victim_id = %s
                ORDER BY found_date DESC
            """, (victim_id,))
            effects = [dict(row) for row in cursor.fetchall()]

            return VictimDetail(
                **victim,
                sightings=[Sighting(**s) for s in sightings],
                personal_effects=[PersonalEffect(**e) for e in effects]
            )

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")


@router.get("/victims", response_model=VictimList)
async def get_victims(
    search: Optional[str] = Query(None, description="Search by name or case number"),
    decade: Optional[str] = Query(None, description="Filter by decade"),
    status: Optional[str] = Query(None, description="Filter by status"),
    age_min: Optional[int] = Query(None, description="Minimum age"),
    age_max: Optional[int] = Query(None, description="Maximum age"),
    location: Optional[str] = Query(None, description="Filter by location"),
    limit: int = Query(100, ge=1, le=1000, description="Number of results"),
    offset: int = Query(0, ge=0, description="Offset for pagination")
):
    """Get all victims with optional filtering"""
    try:
        with get_db_cursor() as cursor:
            # Build query
            query = "SELECT * FROM victims WHERE 1=1"
            params = []

            if search:
                query += " AND (LOWER(first_name) LIKE %s OR LOWER(last_name) LIKE %s OR LOWER(case_number) LIKE %s)"
                search_pattern = f"%{search.lower()}%"
                params.extend([search_pattern, search_pattern, search_pattern])

            if decade:
                query += " AND decade = %s"
                params.append(decade)

            if status:
                query += " AND status = %s"
                params.append(status)

            if age_min is not None:
                query += " AND age_at_disappearance >= %s"
                params.append(age_min)

            if age_max is not None:
                query += " AND age_at_disappearance <= %s"
                params.append(age_max)

            if location:
                query += " AND LOWER(last_seen_location) LIKE %s"
                params.append(f"%{location.lower()}%")

            # Get total count (use same WHERE conditions but without ORDER BY/LIMIT)
            count_query = f"SELECT COUNT(*) FROM victims WHERE 1=1"
            count_params = []
            
            if search:
                count_query += " AND (LOWER(first_name) LIKE %s OR LOWER(last_name) LIKE %s OR LOWER(case_number) LIKE %s)"
                search_pattern = f"%{search.lower()}%"
                count_params.extend([search_pattern, search_pattern, search_pattern])
            
            if decade:
                count_query += " AND decade = %s"
                count_params.append(decade)
            
            if status:
                count_query += " AND status = %s"
                count_params.append(status)
            
            if age_min is not None:
                count_query += " AND age_at_disappearance >= %s"
                count_params.append(age_min)
            
            if age_max is not None:
                count_query += " AND age_at_disappearance <= %s"
                count_params.append(age_max)
            
            if location:
                count_query += " AND LOWER(last_seen_location) LIKE %s"
                count_params.append(f"%{location.lower()}%")
            
            cursor.execute(count_query, count_params)
            total = cursor.fetchone()['count']

            # Get victims
            query += " ORDER BY disappearance_date DESC LIMIT %s OFFSET %s"
            params.extend([limit, offset])
            cursor.execute(query, params)
            victims = [dict(row) for row in cursor.fetchall()]

            return VictimList(
                total=total,
                victims=[VictimBase(**v) for v in victims]
            )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")


@router.get("/search", response_model=VictimList)
async def search_victims(
    q: str = Query(..., min_length=1, description="Search query"),
    limit: int = Query(50, ge=1, le=1000),
    offset: int = Query(0, ge=0)
):
    """Search victims by name, case number, or location"""
    try:
        with get_db_cursor() as cursor:
            search_pattern = f"%{q.lower()}%"

            # Search query
            query = """
                SELECT * FROM victims
                WHERE LOWER(first_name) LIKE %s
                   OR LOWER(last_name) LIKE %s
                   OR LOWER(case_number) LIKE %s
                   OR LOWER(last_seen_location) LIKE %s
                   OR LOWER(CONCAT(first_name, ' ', last_name)) LIKE %s
                ORDER BY disappearance_date DESC
                LIMIT %s OFFSET %s
            """

            cursor.execute(query, (search_pattern, search_pattern, search_pattern,
                                  search_pattern, search_pattern, limit, offset))
            victims = [dict(row) for row in cursor.fetchall()]

            # Get total count
            count_query = """
                SELECT COUNT(*) FROM victims
                WHERE LOWER(first_name) LIKE %s
                   OR LOWER(last_name) LIKE %s
                   OR LOWER(case_number) LIKE %s
                   OR LOWER(last_seen_location) LIKE %s
                   OR LOWER(CONCAT(first_name, ' ', last_name)) LIKE %s
            """
            cursor.execute(count_query, (search_pattern, search_pattern, search_pattern,
                                        search_pattern, search_pattern))
            total = cursor.fetchone()['count']

            return VictimList(
                total=total,
                victims=[VictimBase(**v) for v in victims]
            )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")


@router.get("/filter", response_model=VictimList)
async def filter_victims(
    decade: Optional[str] = Query(None),
    status: Optional[str] = Query(None),
    age_min: Optional[int] = Query(None),
    age_max: Optional[int] = Query(None),
    limit: int = Query(100, ge=1, le=1000),
    offset: int = Query(0, ge=0)
):
    """Filter victims by decade, status, and age range"""
    return await get_victims(
        decade=decade,
        status=status,
        age_min=age_min,
        age_max=age_max,
        limit=limit,
        offset=offset
    )


@router.get("/stats")
async def get_statistics():
    """Get database statistics"""
    try:
        with get_db_cursor() as cursor:
            # Total victims
            cursor.execute("SELECT COUNT(*) as count FROM victims")
            total_victims = cursor.fetchone()['count']

            # Victims by decade
            cursor.execute("""
                SELECT decade, COUNT(*) as count
                FROM victims
                GROUP BY decade
                ORDER BY decade
            """)
            by_decade = {row['decade']: row['count'] for row in cursor.fetchall()}

            # Victims by status
            cursor.execute("""
                SELECT status, COUNT(*) as count
                FROM victims
                GROUP BY status
                ORDER BY count DESC
            """)
            by_status = {row['status']: row['count'] for row in cursor.fetchall()}

            # Total sightings
            cursor.execute("SELECT COUNT(*) as count FROM sightings")
            total_sightings = cursor.fetchone()['count']

            # Total personal effects
            cursor.execute("SELECT COUNT(*) as count FROM personal_effects")
            total_effects = cursor.fetchone()['count']

            return {
                "total_victims": total_victims,
                "by_decade": by_decade,
                "by_status": by_status,
                "total_sightings": total_sightings,
                "total_personal_effects": total_effects
            }

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
