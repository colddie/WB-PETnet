function [N,E,d,st,cw,ec,sp]=netPro(W,plot)


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
