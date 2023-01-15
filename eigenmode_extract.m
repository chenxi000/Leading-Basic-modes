function [Eigenmode_group, Sigma2_group, Eigenmode_individual, Sigma2_individual] = eigenmode_extract(dir_data, eigenmode_number)
% =========================================================================
% This function is used to extract eigenmodes from R-fMRI time courses
% Syntax: [Eigenmode_group, Sigma_group, Eigenmode_individual, Sigma_individual] = eigenmode_extract(dir_data, eigenmode_number)
% Inputs:
%       dir_data: Full path of the data containing R-fMRI timeseries, e.g., “D:/Data”
%       eigenmode_number: Number of eigenmodes aimed to extract 
% Outputs:
%       Eigenmode_group: An N_ROI x N_eigen matrix denoting the group-level eigenmodes
%       Sigma2_group: An N_eigen x 1 vector denoting weights of the group-level eigenmodes
%       Eigenmode_individual: An N_sub x 1 cell, each cell contains an N_ROI x N_eigen matrix denoting the individual-level eigenmodes
%       Sigma2_individual: An N_sub x 1 cell, each cell contains an N_eigen x 1 vector denoting weights of individual-level eigenmodes
%
% Written by Xi Chen, SSS, BNU, Beijing, 2021/9/29, xi.chen@mail.bnu.edu.cn
% Reference for the eigen-microstate analysis: Sun Y, et al. (2021) Eigen microstates and their evolutions in complex systems. Communications in Theoretical Physics 73(6).
% =========================================================================
            
load([dir_data, filesep, 'zMTC.mat'], 'zMTC')
N_sub = length(zMTC);
[N_time, N_ROI] = size(zMTC{1});

% Concatenate the time courses across all participates and calculate the eigenmodes at the group and individual level
%% Group-level analysis
A = zeros(N_ROI, N_time * N_sub);
C2_individual = zeros(N_sub,1);
for i_sub = 1:N_sub
    sub_activity = zMTC{i_sub}';   % N_node x N_time
    C2_individual(i_sub) = sum(sub_activity(:).^2);

    % Generate the concatenated time courses 
    A = cat(2, A, sub_activity);
end
C2 = sum(C2_individual); 
A = A ./ sqrt(C2);

[Eigenmode_group, Sigma, ~] = svds(A, eigenmode_number);
Sigma2_group = diag(Sigma).^2;
clear C2

%% Individual-level analysis
Eigenmode_individual = cell(N_sub,1);
Sigma2_individual = cell(N_sub,1);
C2_individual = zeros(N_sub,1);
for i_sub = 1:N_sub
    sub_activity = zMTC{i_sub}';   % N_node x N_time
    C2_individual(i_sub) = sum(sub_activity(:).^2);
    
    activity_norm = sub_activity ./ sqrt(C2_individual(i_sub));
    [U_sub, Sigma_sub, ~] = svds(activity_norm, eigenmode_number);
    Sigma2_sub = diag(Sigma_sub).^2;
    Eigenmode_individual{i_sub} = U_sub;
    Sigma2_individual{i_sub} = Sigma2_sub;
end

end