import random
import pandas as pd
import numpy as np


class InterestTraversal:
    def __init__(self, path):
        self.graph = None
        self.nodes = None
        self.node_clusters = None
        self.n_vertices = None
        self.n_clusters = None
        self.cache = {}
        self.eps = 0.3
        self.depth_rate = 0.7
        self.n_groups = 10
        self.init_graph(path)

    def init_graph(self, df_path):
        self.nodes = pd.read_csv("../data/hobbies_clusters.csv", index_col=[0]).to_dict()['HOBBIES']
        self.node_clusters = pd.read_csv("../data/hobbies_clusters.csv", index_col=[0]).to_dict()['labels']
        self.graph = np.load("../data/adj_hobbies.npy")

        self.n_vertices = self.graph.shape[0]
        self.n_clusters = max(self.node_clusters.values()) + 1

    @staticmethod
    def softmax(x):
        return np.exp(x) / np.sum(np.exp(x), axis=0)

    def state(self, user_history):
        neg = np.array([key for key, value in user_history.items() if value is False], dtype=int)
        visited = np.array([key for key, value in user_history.items() if value is True], dtype=int)

        adj_matrix = np.copy(self.graph)

        if neg.size:
            adj_matrix[neg] = 0
            adj_matrix[:, neg] = 0

        return adj_matrix, visited

    def possible_transitions(self, adj_matrix, visited):
        depth = random.uniform(0.0, 1.0) < self.depth_rate
        exploit = random.uniform(0.0, 1.0) > self.eps

        if visited.size and exploit:
            adj_nodes = adj_matrix[visited].sum(axis=0)
            adj_nodes[visited] = 0
        else:
            adj_nodes = np.ones(self.n_vertices, dtype=int)
            adj_nodes[visited] = 0

        p = adj_nodes / sum(adj_nodes)
        next_nodes = np.nonzero(adj_nodes)[0]

        return next_nodes, p[next_nodes]

    def traversal(self, user):
        user_history = self.cache[user]
        state_matrix, visited = self.state(user_history)

        next_nodes, p = self.possible_transitions(state_matrix, visited)

        try:
            choice = np.random.choice(next_nodes, p=p)
        except Exception:
            choice = random.randint(0, self.n_vertices)

        return choice

    def store_preference(self, user: int):
        pref = self.traversal(user)
        self.cache[user][pref] = None
        return self.nodes[pref]

    def init_user(self, user: int):
        self.cache[user] = {}
        return self.store_preference(user)

    def response(self, user: int, prev_response: bool):
        last_pref = list(self.cache[user].items())[-1][0]
        self.cache[user][last_pref] = prev_response
        return self.store_preference(user)

    def assign_user(self, user: int):
        pos = np.array([key for key, value in self.cache[user].items() if value is True], dtype=int)
        neg = np.array([key for key, value in self.cache[user].items() if value is False], dtype=int)

        hobbies = np.zeros(self.n_vertices)
        hobbies[pos] = 1
        hobbies[neg] = -1

        cluster_count = np.zeros(self.n_clusters, dtype=int)
        for idx_h, h in enumerate(hobbies):
            cluster_count[self.node_clusters[idx_h]] += h
        cluster_count += abs(min(cluster_count))
        cluster_count = InterestTraversal.softmax(cluster_count)
        cluster_prob = None

        groups = np.random.choice(pos, p=cluster_prob, size=10)
        groups = np.unique(groups)
        groups_str = [self.nodes[h] for h in groups]

        return groups_str
