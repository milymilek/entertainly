import random

import pandas as pd
import numpy as np

# nodes = {
#     0: "music", 1: "club_music", 2: "concert", 3: "jazz", 4: "classical_music",
#     5: "opera", 6: "recital", 7: "board_games", 8: "card_games", 9: "spiritual",
#     10: "handwork", 11: "politics", 12: "nature", 13: "trips", 14: "dancing",
#     15: "fashion", 16: "latino_culture", 17: "long_term_commitment", 18: "memorization",
#     19: "asian_culture", 20: "physical", 21: "martial_arts", 22: "muay_thai",
#     23: "mountains", 24: "videography", 25: "history", 26: "improvisation",
#     27: "planning", 28: "quick_decision", 29: "speeches", 30: "hidden_meaning",
#     31: "introvert", 32: "extravert", 33: "outsider", 34: "constantly_improving",
#     35: "social", 36: "technology", 37: "sense_of_rhythm", 38: "attention_to_detail",
#     39: "creativity", 40: "body_coordination", 41: "focus", 42: "problem-solving",
#     43: "self-expression", 44: "social_connection", 45: "resilience", 46: "curiosity",
#     47: "outside", 48: "inside", 49: "solo", 50: "group", 51: "quiet_env",
#     52: "brain", 53: "patience", 54: "eternalization", 55: "digital_arts"
# }
# paths = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6],
#          [4, 5], [7, 8], [0, 14], [14, 15], [14, 19], [12, 18],
#          [13, 18], [20, 21], [21, 22], [17, 34], [33, 31], [33, 12],
#          [33, 13], [33, 23], [33, 36], [36, 42], [32, 35], [42, 46],
#          [47, 12], [47, 13], [47, 23], [47, 2], [48, 0], [48, 7],
#          [48, 10], [48, 36], [48, 15], [48, 10], [29, 11], [32, 33],
#          [32, 44], [50, 44], [50, 52], [45, 22], [23, 45], [45, 40],
#          [46, 36], [46, 42], [46, 41], [43, 0], [43, 14], [43, 9],
#          [37, 0], [37, 14], [53, 42], [53, 34], [53, 17], [53, 11],
#          [16, 14], [16, 9], [26, 11], [26, 3], [49, 10], [49, 41], [49, 29],
#          [51, 41], [51, 31], [51, 12], [27, 52], [27, 8], [24, 54], [24, 55],
#          [30, 33], [30, 9], [30, 11], [39, 54], [39, 27], [38, 10], [38, 49],
#          [38, 52], [28, 21], [28, 14], [28, 26]
#          ]


class InterestTraversal:
    def __init__(self, path):
        self.graph = None
        self.nodes = None
        self.cache = {}
        self.init_graph(path)

    def init_graph(self, df_path):
        self.nodes = pd.read_csv("../data/hobbies_clusters.csv", index_col=[0]).to_dict()['HOBBIES']
        self.graph = np.load("../data/adj_hobbies.npy")

    def add_user_to_cache(self, user):
        self.cache.setdefault(user, {})

    def state(self, user_history):
        neg = np.array([key for key, value in user_history.items() if value is False], dtype=int)
        visited = np.array([key for key, value in user_history.items() if value is True], dtype=int)

        print("neg: ", neg)
        print("visited: ", visited)

        adj_matrix = np.copy(self.graph)

        if neg.size:
            adj_matrix[neg] = 0
            adj_matrix[:, neg] = 0

        return adj_matrix, visited

    def get_next_nodes(self, adj_matrix, visited):
        #print(visited)
        adj_edges = adj_matrix[visited].sum(axis=0)

        if visited.size:
            adj_edges[visited] = 0

        if not adj_edges.any():
            next_nodes = np.ones_like(adj_edges)
            next_nodes[visited] = 0
            p = next_nodes / sum(next_nodes)
            next_nodes = np.nonzero(next_nodes)[0]
        else:
            p = adj_edges / sum(adj_edges)
            next_nodes = np.nonzero(adj_edges)[0]

        #print("next_nodes: ", next_nodes)
        #print("p: ", p)

        return next_nodes, p[next_nodes]

    def traversal(self, user):
        user_history = self.cache[user]
        #print("history: ", user_history)
        state_matrix, visited = self.state(user_history)

        #print("visited: ", visited)

        next_nodes, p = self.get_next_nodes(state_matrix, visited)

        choice = np.random.choice(next_nodes, p=p)

        return choice


    def __call__(self, user: int, prev_response: bool):
        self.add_user_to_cache(user)

        if self.cache[user]:
            last_pref = list(self.cache[user].items())[-1][0]
            self.cache[user][last_pref] = prev_response

        pref = self.traversal(user)
        self.cache[user][pref] = None
        print(self.cache)
        return self.nodes[pref]
