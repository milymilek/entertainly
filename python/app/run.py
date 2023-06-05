import os

from fastapi import FastAPI, APIRouter
from graph.InterestTraversal import InterestTraversal

from schemas.interest_models import InterestResponse, InterestRequest, \
                                    AssignGroupResponse, AssignGroupRequest, MessageType

router = APIRouter(
    tags=['items'],
    responses={404: {"description": "Page not found"}}
)

app = FastAPI()
app.include_router(router)

interest = InterestTraversal("../data/hobbies.csv")


@app.get("/")
async def root():
    return "Welcome..."


@app.get("/health")
async def health():
    return 200


@app.post("/search_preference", response_model=InterestResponse)
async def search_preference(request: InterestRequest):
    user_id = request.user_id
    msg_type = request.msg_type

    match msg_type:
        case MessageType.START:
            interest_reco = interest.init_user(user_id)
        case MessageType.ACCEPT | MessageType.REJECT:
            ans = True if msg_type == MessageType.ACCEPT else False
            interest_reco = interest.response(user_id, ans)

    response = {"user_id": user_id, "interest_reco": interest_reco}
    return response


@app.post("/assign_group", response_model=AssignGroupResponse)
async def assign_group(request: AssignGroupRequest):
    user_id = request.user_id
    groups = interest.assign_user(user_id)

    response = {"user_id": user_id, "groups": groups}

    return response
