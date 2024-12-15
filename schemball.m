% Function: [N,E,d,st,cw,ec,sp,pea_cd2] = schemball(tacs, label, thre, plot)
%
% Author: Tao Sun  
% Email: colddiesun@gmail.com  
% Date: 2014-12-15  
%
% Description:
% This function analyzes and visualizes the network features of a dataset
% derived from time-activity curves (TACs). It calculates covariance and
% Pearson correlation matrices, thresholds the network, and computes graph
% measures such as node count, edge count, clustering, and eigenvector centrality.
% Optional visualization of matrices, networks, and network features is included.
%
% Inputs:
% tacs  - Time-activity curves (matrix: nodes x time points).
% label - Cell array of labels for the nodes.
% thre  - Threshold proportionality for network pruning.
% plot  - Plotting level: 
%         0 = No plots,
%         1 = Basic plots,
%         2 = Full visualization (recommended for debugging).
%
% Outputs:
% N       - Number of nodes in the network.
% E       - Number of edges after thresholding.
% d       - Edge density (likelihood of connection between nodes).
% st      - Node strengths (sum of edge weights per node).
% cw      - Clustering coefficients.
% ec      - Eigenvector centralities.
% sp      - Average shortest path length.
% pea_cd2 - Pearson correlation matrix (absolute, diagonal removed).
%
% Notes:
% - Functions from the Brain Connectivity Toolbox are required for advanced
%   graph metrics (e.g., clustering_coef_wu, eigenvector_centrality_und, etc.).
%
function [N,E,d,st,cw,ec,sp,pea_cd2] = schemball(tacs, label, thre, plot)

    % Step 1: Covariance Matrix
    cov_cd2 = cov(tacs(:,:)');
    cov_cd2 = abs(cov_cd2 - diag(diag(cov_cd2))); % Remove diagonal elements
    if plot == 2
        figure;
        imagesc(cov_cd2);
        axis square;
        cb = colorbar;
        cb.Label.String = 'Covariance level';
        title('|Covariance|');
        ylabel('Nodes'); xlabel('Nodes');
    end
    
    % Step 2: Pearson Correlation Matrix
    pea_cd2 = corrcoef(tacs(:,:)');
    pea_cd2 = abs(pea_cd2 - diag(diag(pea_cd2))); % Remove diagonal elements
    if plot == 1
        figure('Position', [100, 100, 800, 550]);
        subplot(121);
        imagesc(pea_cd2);
        axis square; colorbar;
        title('|Pearson|');
    end
    
    % Step 3: Thresholding
    W = threshold_proportional(pea_cd2, thre); % Apply proportional threshold
    if plot == 1
        subplot(122);
        imagesc(W);
        colorbar; axis square;
        title('Thresholded Matrix');
    end
    
    % Step 4: Network Visualization
    if plot == 2
        figure;
        spy(W); % Binary view of the matrix
        pcolor(W); % Weighted view
        hist(nonzeros(W));
        unique(nonzeros(W));
    
        subplot(1,3,1); gplot(W, ones(size(W,1))); axis equal;
        subplot(1,3,2); gplot(W, ones(size(W,1))); axis equal;
    end
    
    if plot > 0
        h = schemaball(W, cellstr(label));
        colormap(jet);
    end
    
    % Step 5: Network Features
    % Number of nodes and edges
    N = length(W);
    E = nnz(W);
    d = E / (N * (N - 1)); % Edge density
    trace(W); % Check for self-loops
    
    % Strength
    st = sum(W, 2);
    if plot == 2
        figure;
        hold on;
        stem(st);
        [st_max, node_st_max] = max(st);
        stem(node_st_max, st_max, 'r');
        ylabel('Strength'); xlabel('Nodes');
    end
    
    % Clustering Coefficients
    cw = clustering_coef_wu(W);
    if plot == 2
        figure;
        plot(cw);
        hold on;
        [cw_max, node_cw_max] = max(cw);
        stem(node_cw_max, cw_max, 'or');
        ylabel('Weighted Clustering'); xlabel('Nodes');
    end
    
    % Eigenvector Centrality
    ec = eigenvector_centrality_und(W);
    if plot == 2
        figure;
        plot(ec);
        hold on;
        [ec_max, node_ec_max] = max(ec);
        stem(node_ec_max, ec_max, 'or');
        ylabel('Eigenvector Centrality'); xlabel('Nodes');
    end
    
    % Average Shortest Path
    L = weight_conversion(W, 'lengths'); % Convert weights to lengths
    D = distance_wei(L); % Calculate shortest paths
    sp = charpath(D); % Compute average shortest path
    if plot == 2
        figure;
        plot(1, sp, '*k');
        hold on;
        boxplot(D(D ~= 0));
        legend(['sp = ', num2str(sp)]);
        ylabel('Shortest Path');
    end
    
    end
    