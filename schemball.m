function [N,E,d,st,cw,ec,sp,pea_cd2]=schemball(tacs,label,thre,plot)

% Covariance
cov_cd2 = cov(tacs(:,:)');
cov_cd2 = abs(cov_cd2 - diag(diag(cov_cd2)));

if (plot==2) 
figure;
imagesc(cov_cd2);
axis square;
cb = colorbar;
cb.Label.String = 'Covariance level';
title('|Covariance|');
ylabel('nodes');    xlabel('nodes');
end

% Pearson
pea_cd2 = corrcoef(tacs(:,:)');
pea_cd2 = abs(pea_cd2 - diag(diag(pea_cd2)));




% if (plot==0) imagesc(pea_cd2);  end


if (plot==1)
figure('Position',[100 100 800 550]);
subplot(121);
imagesc(pea_cd2); 
axis square;    colorbar;
title('|Pearson|');
% subplot(222)
% % plot(graph(pea_cd2))   % 'upper'
% axis off
% title('What an ugly network!')
end

% Threshold
W = threshold_proportional(pea_cd2, thre);   % look at this! "W" is now our matrix with threshold
%isconnected(W);                             % if this value is one, then "W" is connected
if (plot==1)
subplot(122);
imagesc(W); colorbar;   axis square;
title('Thresholded matrix');

% subplot(224)
% plot(graph(W))
% axis off
% title('A much better network to work...')
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]) %EXPANDING FIGURE ON SCREEN
end



%% Visualize network
matrix = W;
% [posx posy posz] = sphere(size(W,1)-1);
% pos = reshape([posx posy posz],size(W,1),size(W,1),3);
[posx,posy] = meshgrid(1:20);

if (plot==2)
figure
spy(matrix); % binary view
pcolor(matrix); % view of values for weighted networks
hist(nonzeros(matrix));
unique(nonzeros(matrix));
%% Spatial Network visualisation
% view from top
subplot(1,3,1); gplot(matrix,posx); axis equal;
% view from side
subplot(1,3,2); gplot(matrix,posy); axis equal;
% % view from back
% subplot(1,3,3); gplot(matrix,posz); axis equal
end

if (plot>0)
    h=schemaball(matrix,cellstr(label));colormap(jet);
    % set(h.s, 'MarkerEdgeColor','red','LineWidth',2,'SizeData',100)
    % keyboard
end


% Network features

% how many nodes are there?
N = length(W);
% how many edges are there (i.e. non-zero matrix elements)?
E = nnz(W);
% what is the edge density (likelihood that any two nodes are connected?
d = E / (N * (N-1));
% are there any loops (connections from node to itself)?
min(min(W)); % any negative value out there?
trace(W); % any non-zero diagonal elements (aka self-loops)

% strength
st = sum(W,2);
if (plot==2)
figure;
hold
stem(st);
[st_max, node_st_max] = max(st);
stem(node_st_max, st_max, 'r');
ylabel('Strength'); xlabel('nodes');
end

% clustering
cw = clustering_coef_wu(W);
if (plot==2)
figure
plot(cw);
hold;
[cw_max, node_cw_max] = max(cw);
stem(node_cw_max, cw_max, 'or');
ylabel('Weighted Clustering'); xlabel('nodes');
end

ec=1;
if (plot==2)
% eigenvector centrality
ec = eigenvector_centrality_und(W);
figure
plot(ec);
hold;
[ec_max, node_ec_max] = max(ec);
stem(node_ec_max, ec_max, 'or');
ylabel('eigenvector centrality');   xlabel('nodes');
end 

% average shortest path
L = weight_conversion(W, 'lengths');    % taking the inverse of matrix elements
D = distance_wei(L);                    % applying Dijkstra's algorithm
sp = charpath(D);                       % averaging shortest paths' matrix
if (plot==2)
    figure
    plot(1,sp, '*k');
    hold;
    boxplot(D(D~=0));
    legend(horzcat('sp = ', num2str(sp)));
    ylabel('Shortest Path');
end

end





% A = zeros(13, 13); %adjacency matrix, assume undirected graph
% link(1,:)=[1 2];
% link(2,:)=[1 3];
% link(3,:)=[1 4];
% link(4,:)=[2 6];
% link(5,:)=[3 6];
% link(6,:)=[3 7];
% link(7,:)=[4 8];
% link(8,:)=[4 9];
% link(9,:)=[6 10];
% link(10,:)=[7 10];
% link(11,:)=[8 11];
% link(12,:)=[8 12];
% link(13,:)=[9 12];
% link(14,:)=[9 13];
% link(15,:)=[1 5];
% link(16,:)=[5 13];
% nlinks  = length(link);
% inds    = sub2ind(size(A), link(:,1), link(:,2)) %convert to index in the adjacency matrix
% A(inds) = 1; %the points are connected
% %Making A symmetric (undirected graph)
% A = triu(A, 1);
% A = A + A';
% %Positioning the nodes in a circle
% theta = linspace(0, 2*pi, nlinks);
% x     = cos(theta);
% y     = sin(theta);
% gplot(A, [x' y'], 'o-')
% hold on
% %Put text at the nodes
% scale = 1.07; %radius of the text positions
% for i = 1:size(A,1)
%       if sum(A(i,:)) > 0 %if there are any links
%           text(scale*x(i), scale*y(i), num2str(i), 'fontsize', 16,...
%               'HorizontalAlignment', 'center')%num2str(nums(i)))
%       end
%   end
% axis([-1.1,1.1,-1.1,1.1])