function FC_reconst = reconst_FC(Eigenmode, Sigma2, N_time, C2, n_eigen)
% =========================================================================
% This function is used to reconstruct functional connectivity matrix using serval eigenmodes
% Syntax:FC_reconst = Reconst_FC(Eigenmode, Sigma2, N_time, C, n_eigen)
% Inputs:
%       Eigenmode: An N_ROI x N_eigen marix, each column represents an eigenmodes extract from R-fMRI time courses
%       Sigma2:    An N_eigen x 1 vector containing weights of N_eigen eigenmodes
%       N_time:   A scalar denoting number of time points of the original R-fMRI timeseries used for extracting eigenmodes
%       C2:       A scalar denoting sum square of all elements in the nodal R-fMRI time courses
%       n_eigen:   A scalar denoting number of eigenmodes that were used to reconstructed functional connectivity matrix
% Output:
%       FC_reconst:  An N_ROI x N_ROI matrix, representing reconstructed functional connectivity matrix
%
% Written by Xi Chen, SSS, BNU, Beijing, 2021/4/7, xi.chen@mail.bnu.edu.cn
% =========================================================================
N_parcels = size(Eigenmode,1);% Number of nodes in the parcellation
N_eigen = size(Eigenmode, 2);% Number of eigenmodes that were provided
if n_eign > N_eigen
    Error('Please check the number of eigenmodes');
end

FC_reconst = zeros(N_parcels);
for i_eigen = 1:n_eigen
    FC_reconst = FC_reconst + Eigenmode(:,i_eigen) * Eigenmode(:,i_eigen)' * Sigma2(i_eigen);
end

FC_reconst = FC_reconst .* C2 ./ (N_time-1);
FC_reconst = FC_reconst - diag(diag(FC_reconst));

end