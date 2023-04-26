"""
This function is used to identify the number of leading basic modes according to the elbow point of Sigma curve
Syntax: 
    leading_number = get_leading_number(sigma)
Input：
    sigma: An N_basic * 1 vector, containing weights of basic modes, sorted in the descending order
Output:
    leading_number: a scalar denoting number of leading basic modes.

Written by Xi Chen, SSS, BNU, Beijing, 2023/4/13, xi.chen@mail.bnu.edu.cn
Reference for elbow-point detection: 
    Satopaa V et al. (2011) Finding a "kneedle" in a haystack: Dectecting knee points in system behavior. 
    In: 2011 31st international conference on distributed computing systems work shops. IEEE
"""

# this package is written by Kevin Arvai(available at https://github.com/arvkevi/kneed)
from kneed import KneeLocator
def get_leading_number(sigma):
    x = range(1,31)
    y = sigma[0:30] # The first 30 basic modes were considered when detecting the elbow point
    
    # detect the elbow point based on kneedle algorithm
    kn = KneeLocator(x, y, curve = 'convex', direction = 'decreasing', interp_method = 'polynomial', polynomial_degree = 7,S = 1) 
    elbow = kn.knee
    leading_number = elbow - 1
    return leading_number
