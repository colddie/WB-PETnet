% Author: Tao Sun
% Email: colddiesun@gmail.com
% Date: 2014-12-15
%
% This script performs single-subject level connectivity network analysis
% for a patient group, utilizing SUL normalization, Pearson correlation,
% and various visualization and graph-based analyses. It includes:
% 1. Loading and preprocessing data for normal and patient groups.
% 2. Constructing connectivity networks and correlation matrices.
% 3. Visualizing networks and computing graph features.
% Note: Customize paths, subject groups, and ROI labels as required.
%
% Caution: Ensure proper backups are made before modifying this script!

% Paths and subject groups
pad0 = '/code/work/network/subjects/';
studyn = ["005", "007", "008", "011", "018", "041", "055", "062", "063", "066"]; % Normal group
studyp = ["002"]; % Patient group
studys1 = [studyn, studyp];

% ROI labels
labels = {"muscle", "kidney_L", "kidney_R", "blood", "spleen", "lung", "liver", "brain", "LV", "pancrea", "spine"};
labelid = 1:length(labels); % Automatically assign label IDs

% Load data for normal and patient groups
SULn = load_SUL_data(studyn, pad0, labels);
SULp = load_SUL_data(studys1, pad0, labels);

% Reorder to match label IDs
order = [10, 8, 9, 2, 7, 4, 5, 1, 3, 6, 11]; % Custom label order
tacs1 = SULn(order, :);
tacs2 = SULp(order, :);

% Compute Pearson correlation for normal and patient groups
[N1, E1, d1, st1, cw1, ec1, sp1, pea_cd1] = schemball(tacs1, labels, 0.5, 0);
pea_cd1(isnan(pea_cd1)) = 0;
[N2, E2, d2, st2, cw2, ec2, sp2, pea_cd2] = schemball(tacs2, labels, 0.5, 0);
pea_cd2(isnan(pea_cd2)) = 0;

% Compute difference between networks
tmp = pea_cd1 - pea_cd2;

% Visualize individual graph
h = schemaball(tmp, cellstr(labels), [1, 1, 0], [0, 1, 0]);
set(h.l(~isnan(h.l)), 'LineWidth', 1.4);
set(h.s, 'SizeData', 48, 'LineWidth', 2, 'MarkerEdgeColor', [1, 1, 1]);
set(findobj('type', 'text'), 'color', 'black');
set(gcf, 'color', 'w');

% Visualize the correlation matrix
tmp(eye(size(tmp, 1)) ~= 0) = 0; % Set diagonal to zero
figure;
imagesc(tmp, [-0.25, 0.25]);
colorbar;
title('Correlation Matrix Difference');
xticks(1:length(labels)); % Add x-axis ticks
yticks(1:length(labels)); % Add y-axis ticks
xticklabels(labels);      % Set x-axis labels
yticklabels(labels);      % Set y-axis labels
xtickangle(45);           % Rotate x-axis labels for better readability
xlabel('ROI');
ylabel('ROI');

% Compute Z-score matrix
% zscore = atanh(tmp)
zscore = tmp ./ sqrt(1 - pea_cd2.^2) * (size(studyn, 2) - 1);

% Graph features and significance testing
p = normcdf(zscore); % Hypothesis testing
significant_edges = find(p < 0.05); % Locate significant edges
fprintf('Number of significant edges: %d\n', numel(significant_edges));
[N, E, d, st, cw, ec, sp] = netPro(abs(zscore), 1); % Compute graph features


% Helper function for loading data
function [SUL] = load_SUL_data(subjects, pad0, labels)
    SUL = [];
    for istudy = 1:numel(subjects)
        tmps = dir(fullfile(pad0, strcat(subjects(istudy), '*')));
        if isempty(tmps)
            error('No matching directory found for subject: %s', subjects(istudy));
        end
        pad1 = tmps(1).name;

        % Load weight and dose
        filename = fullfile(pad0, pad1, 'weightDose.txt');
        if ~isfile(filename)
            error('File not found: %s', filename);
        end
        tmp = textread(filename, '%f', 'delimiter', ' ');
        weight = tmp(1);
        dose = tmp(2) / 1e3;

        % Load SUL data
        filename = fullfile(pad0, pad1, 'results_SUL.txt');
        if ~isfile(filename)
            error('File not found: %s', filename);
        end
        [~, B, ~, ~, ~, ~, ~, ~, ~, ~] = textread(filename, '%f %f %f %f %f %f %f %f %f %f', 'headerlines', 2, 'delimiter', ' ');
        SUL = [SUL, B / dose * weight];
    end
end