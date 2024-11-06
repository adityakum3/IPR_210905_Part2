from scipy.stats import norm
import numpy as np
def estimate_gaussian_params(scores):
    mean = np.mean(scores)
    std_dev = np.std(scores)
    return mean, std_dev

def likelihood_ratio_test(score, gen_params, imp_params):
    gen_mean, gen_std = gen_params
    imp_mean, imp_std = imp_params
    
    p_gen = norm.pdf(score, gen_mean, gen_std)
    p_imp = norm.pdf(score, imp_mean, imp_std)
    likelihood_ratio = p_gen / p_imp
    
    return np.mean(likelihood_ratio)

