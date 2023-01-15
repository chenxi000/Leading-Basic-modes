function leading_number = calc_leading_eigenmode_number(sigma2)
% =========================================================================
% This function is used to identify the number of leading eigenmodes according to the adjustment angle along the weight curve
% Syntax:leading_number = calc_leading_eigenmode_number(sigma)
% Input:
%       sigma2: An N_eigen*1 vector, containing weights of eigenmodes, sorted in the descending order 
% Output:
%       leading_number:  a scalar denoting number of leading eigenmodes.
%
% Written by Xi Chen, SSS, BNU, Beijing, 2022/12/28, xi.chen@mail.bnu.edu.cn
% =========================================================================
N_eigenmode = length(sigma2);
cos0 = zeros(N_eigenmode,1);
angle0 = zeros(N_eigenmode,1);

% Estimate the adjustment angle of each eigenmode by comparing the decreasing slopes of this eigenmode and the slope of the previous one
for ii = 2:(N_eigenmode - 1)
    y1 = sigma2(ii-1) - sigma2(ii);
    y2 = sigma2(ii+1) - sigma2(ii);
    mod1 = sqrt(1+y1^2);
    mod2 = sqrt(1+y2^2);
    cos0(ii,1) =  (-1 + y1 * y2 )/ (mod1 * mod2);
    angle0(ii,1) =  pi - acos(cos0(ii));
end

temp = find(islocalmax(angle0)==1); % Identify all the local maximal along the curve
elbow_point = temp(2); % Identify the second local maximal as the elbow point
leading_number = elbow_point -1;

end