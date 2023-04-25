function FC_reconst = reconst_FC(mode, Sigma2, N_time, C2, n_basic)
% =========================================================================
% This function is used to reconstruct functional connectivity matrix using serval basic modes
% Syntax:FC_reconst = Reconst_FC(mode, Sigma2, N_time, C, n_basic)
% Inputs:
%       mode: An N_ROI x N_basic marix, each column represents an basic modes extract from R-fMRI time courses
%       Sigma2:    An N_basic x 1 vector containing weights of N_basic basic modes
%       N_time:   A scalar denoting number of time points of the original R-fMRI timeseries used for extracting basic modes
%       C2:       A scalar denoting sum square of all elements in the nodal R-fMRI time courses
%       n_basic:   A scalar denoting number of basic modes that were used to reconstructed functional connectivity matrix
% Output:
%       FC_reconst:  An N_ROI x N_ROI matrix, representing reconstructed functional connectivity matrix
%
% Written by Xi Chen, SSS, BNU, Beijing, 2021/4/7, xi.chen@mail.bnu.edu.cn
% =========================================================================
N_parcels = size(mode,1);% Number of nodes in the parcellation
N_basic = size(mode, 2);% Number of basic modes that were provided
if n_eign > N_basic
    Error('Please check the number of basic modes');
end

FC_reconst = zeros(N_parcels);
for i_basic = 1:n_basic
    FC_reconst = FC_reconst + mode(:,i_basic) * mode(:,i_basic)' * Sigma2(i_basic);
end

FC_reconst = FC_reconst .* C2 ./ (N_time-1);
FC_reconst = FC_reconst - diag(diag(FC_reconst));

end
