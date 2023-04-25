function [mode_group, Sigma2_group, mode_individual, Sigma2_individual] = Mode_extract(dir_data, mode_number)
% =========================================================================
% This function is used to extract basic modes from R-fMRI time courses
% Syntax: [mode_group, Sigma2_group, mode_individual, Sigma2_individual] = Mode_extract(dir_data, mode_number)
% Inputs:
%       dir_data: Full path of the data containing R-fMRI timeseries, e.g., “D:/Data”
%       mode_number: Number of basic modes aimed to extract 
% Outputs:
%       mode_group: An N_ROI x N_basic matrix denoting the group-level basic modes
%       Sigma2_group: An N_basic x 1 vector denoting weights of the group-level basic modes
%       mode_individual: An N_sub x 1 cell, each cell contains an N_ROI x N_basic matrix denoting the individual-level basic modes
%       Sigma2_individual: An N_sub x 1 cell, each cell contains an N_basic x 1 vector denoting weights of individual-level basic modes
%
% Written by Xi Chen, SSS, BNU, Beijing, 2021/9/29, xi.chen@mail.bnu.edu.cn
% Reference for the eigen-microstate analysis: Sun Y, et al. (2021) Eigen microstates and their evolutions in complex systems. Communications in Theoretical Physics 73(6).
% =========================================================================
            
load([dir_data, filesep, 'zMTC.mat'], 'zMTC')
N_sub = length(zMTC);
[N_time, N_ROI] = size(zMTC{1});

% Concatenate the time courses across all participates and calculate the basic modes at the group and individual level
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

[mode_group, Sigma, ~] = svds(A, mode_number);
Sigma2_group = diag(Sigma).^2;
clear C2

%% Individual-level analysis
mode_individual = cell(N_sub,1);
Sigma2_individual = cell(N_sub,1);
C2_individual = zeros(N_sub,1);
for i_sub = 1:N_sub
    sub_activity = zMTC{i_sub}';   % N_node x N_time
    C2_individual(i_sub) = sum(sub_activity(:).^2);
    
    activity_norm = sub_activity ./ sqrt(C2_individual(i_sub));
    [U_sub, Sigma_sub, ~] = svds(activity_norm, mode_number);
    Sigma2_sub = diag(Sigma_sub).^2;
    mode_individual{i_sub} = U_sub;
    Sigma2_individual{i_sub} = Sigma2_sub;
end

end
