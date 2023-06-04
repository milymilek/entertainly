import os

from fastapi import FastAPI, APIRouter
from graph.InterestTraversal import InterestTraversal

from schemas.interest_models import InterestResponse, InterestRequest, MessageType

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

    if msg_type != MessageType.END:
        msg_type = True if msg_type == MessageType.ACCEPT else False
        interest_reco = interest(user_id, msg_type)
        response = {"user_id": user_id, "interest_reco": interest_reco}
    else:
        # writeToDatabaseAndAssignGroup(user_id)
        print("end")
        response = {"user_id": user_id, "interest_reco": ""}
    return response
