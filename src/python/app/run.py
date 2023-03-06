import os
print(os.path.abspath(os.curdir))
os.chdir("..")
print(os.path.abspath(os.curdir))

from fastapi import FastAPI, APIRouter
from app.graph.create import create_adj_matrix
from app.graph.traversal import graph_quasi_traversation

from app.schemas.preferences_models import PreferencesResponse, PreferencesRequest

router = APIRouter(
    tags=['items'],
    responses={404: {"description": "Page not found"}}
)

app = FastAPI()
app.include_router(router)


adj_matrix = create_adj_matrix()


@app.get("/")
async def root():
    return "Welcome................"


@app.get("/health")
async def health():
    return 200


@app.post("/search_preference", response_model=PreferencesResponse)
async def search_preference(request: PreferencesRequest):
    init_preferences = request.init_preferences

    preferences_list = graph_quasi_traversation(adj_matrix, init_preferences)
    preferences_dict = {"preferences": preferences_list}
    return preferences_dict