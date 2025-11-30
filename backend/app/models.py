"""Pydantic models for API"""
from pydantic import BaseModel
from typing import Optional, List
from datetime import date, datetime


class Sighting(BaseModel):
    id: int
    victim_id: int
    location: str
    witness_name: Optional[str]
    sighting_date: date
    description: Optional[str]
    created_at: Optional[datetime]

    class Config:
        from_attributes = True


class PersonalEffect(BaseModel):
    id: int
    victim_id: int
    item_description: str
    found_location: Optional[str]
    found_date: Optional[date]
    created_at: Optional[datetime]

    class Config:
        from_attributes = True


class VictimBase(BaseModel):
    id: int
    first_name: str
    last_name: str
    nickname: Optional[str]
    age_at_disappearance: int
    date_of_birth: date
    disappearance_date: date
    last_seen_location: str
    physical_description: Optional[str]
    photo_url: Optional[str]
    status: str
    case_number: str
    decade: str
    created_at: Optional[datetime]

    class Config:
        from_attributes = True


class VictimDetail(VictimBase):
    """Victim with related sightings and personal effects"""
    sightings: List[Sighting] = []
    personal_effects: List[PersonalEffect] = []


class VictimList(BaseModel):
    """List of victims with pagination info"""
    total: int
    victims: List[VictimBase]


class SearchFilters(BaseModel):
    """Search and filter parameters"""
    search: Optional[str] = None
    decade: Optional[str] = None
    status: Optional[str] = None
    age_min: Optional[int] = None
    age_max: Optional[int] = None
    location: Optional[str] = None
    limit: int = 100
    offset: int = 0
