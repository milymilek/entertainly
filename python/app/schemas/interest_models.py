from enum import Enum
from typing import List
from pydantic import BaseModel


class MessageType(str, Enum):
    START = "START"
    ACCEPT = "ACCEPT"
    REJECT = "REJECT"
    END = "END"


class InterestRequest(BaseModel):
    user_id: int
    msg_type: MessageType


class InterestResponse(BaseModel):
    user_id: int
    interest_reco: str

