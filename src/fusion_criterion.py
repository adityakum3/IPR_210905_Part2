import numpy as np
def final_fusion_criterion(L_k_v, x_k,tau, gamma_alpha, gamma_beta, i0, a1):
    if L_k_v > gamma_alpha:
        return i0 * x_k
    elif L_k_v < 1 / gamma_beta:
        return a1 * x_k
    else:
        return np.multiply(tau, x_k)
