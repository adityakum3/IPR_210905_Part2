from scipy.stats import wasserstein_distance

def compute_wasserstein_distance(gen_scores, imp_scores):
    return wasserstein_distance(gen_scores, imp_scores)

def adaptive_weighting(w_v, w_p, z):
    tau_v = w_v**z / (w_v**z + w_p**z)
    tau_p = w_p**z / (w_v**z + w_p**z)
    return tau_v, tau_p
