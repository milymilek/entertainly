from typing import List
from pydantic import BaseModel


class PreferencesRequest(BaseModel):
    init_preferences: List[str]


class PreferencesResponse(BaseModel):
    preferences: List[str]

