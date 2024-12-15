Function: [N,E,d,st,cw,ec,sp] = netPro(W, plot)
% 
% Author: Tao Sun  
% Email: colddiesun@gmail.com  
% Date: 2014-12-15  
%
% Description:
% This function computes and visualizes various graph-theoretical measures
% for a weighted adjacency matrix W. Measures include:
% 1. Node count (N), edge count (E), and edge density (d).
% 2. Strength (st), weighted clustering coefficient (cw), and eigenvector
%    centrality (ec).
% 3. Average shortest path (sp) derived using Dijkstra's algorithm.
%
% Inputs:
% W    - Weighted adjacency matrix.
% plot - Set to 1 to enable plots for visualization.
%
% Outputs:
% N    - Number of nodes.
% E    - Number of edges (non-zero weights).
% d    - Edge density.
% st   - Node strengths (sum of edge weights per node).
% cw   - Clustering coefficients.
% ec   - Eigenvector centralities.
% sp   - Average shortest path length.
%
% Notes:
% - Ensure W is symmetric and non-negative for undirected networks.
% - Use 'weight_conversion' and 'distance_wei' functions from the Brain Connectivity Toolbox.
%

% how many nodes are there?
N = length(W)
% how many edges are there (i.e. non-zero matrix elements)?
E = nnz(W)
% what is the edge density (likelihood that any two nodes are connected?
d = E / (N * (N-1))
% are there any loops (connections from node to itself)?
min(min(W)) % any negative value out there?
trace(W) % any non-zero diagonal elements (aka self-loops)

% strength
st = sum(W,2);
if (plot==1)
figure;
hold
stem(st)
[st_max, node_st_max] = max(st);
stem(node_st_max, st_max, 'r')
ylabel('Strength'); xlabel('nodes')
end

% clustering
cw = clustering_coef_wu(W);
if (plot==1)
figure
stem(cw)
hold;
[cw_max, node_cw_max] = max(cw);
stem(node_cw_max, cw_max, 'or')
ylabel('Weighted Clustering'); xlabel('nodes')
end

ec=1;
if (plot==1)
% eigenvector centrality
ec = eigenvector_centrality_und(W);
figure
stem(ec)
hold;
[ec_max, node_ec_max] = max(ec);
stem(node_ec_max, ec_max, 'or')
ylabel('eigenvector centrality');   xlabel('nodes')
end 

% average shortest path
L = weight_conversion(W, 'lengths');    % taking the inverse of matrix elements
D = distance_wei(L);                    % applying Dijkstra's algorithm
sp = charpath(D);                       % averaging shortest paths' matrix
% if (plot==1)
% figure
% plot(1,sp, '*k')
% hold;
% boxplot(D(D~=0));
% legend(horzcat('sp = ', num2str(sp)))
% ylabel('Shortest Path')
% end


end
