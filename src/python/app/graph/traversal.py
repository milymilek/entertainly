import numpy as np
import requests
from app.graph.create import nodes


def get_user_feedback(node):
    data = {"node": nodes[node]}
    r = requests.post("10.0.5.80:5173/preference_path", json=data)
    print(r.content)
    return r.content['success']


def graph_quasi_traversation(adj_matrix, initial_nodes):
    ret_list = []
    #tu trzeba ogarnac mapowanie z wyrazow ktore dostajemy na keye z dictionary `nodes`
    initial_nodes = [nodes[i] for i in initial_nodes]
    adj_matrix = np.copy(adj_matrix)
    past_nodes = initial_nodes.copy()
    current_node = np.random.choice(past_nodes)
    fb_positive = initial_nodes.copy()
    next_possible_nodes = np.setdiff1d(np.nonzero(adj_matrix[current_node])[0], past_nodes)

    while len(next_possible_nodes) or len(past_nodes) != 1:
        if current_node in fb_positive:
            fb = 1
        else:
            fb = get_user_feedback(current_node)
            if fb:
                fb_positive.append(current_node)

        if not fb or not next_possible_nodes.size:
            adj_matrix[current_node, :] = 0
            adj_matrix[:, current_node] = 0
            if not fb:
                past_nodes.pop()
            else:
                ret_list.append(past_nodes.pop())
            current_node = past_nodes[-1]
        else:
            proba_possible_nodes = np.array([np.sum(adj_matrix[past_nodes, i]) for i in next_possible_nodes])
            proba_possible_nodes /= np.sum(proba_possible_nodes)
            current_node = np.random.choice(next_possible_nodes, p=proba_possible_nodes)
            past_nodes.append(current_node)
        next_possible_nodes = np.setdiff1d(np.nonzero(adj_matrix[current_node])[0], past_nodes)

    for p in reversed(past_nodes):
        ret_list.append(p)

    return ret_list