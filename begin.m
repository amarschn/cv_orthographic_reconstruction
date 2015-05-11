clc;clear;close all;
im = rgb2gray(imread('test_part_ortho.PNG'));
im = im < mean(mean(im));

im2 = zeros(size(im));

CC = bwconncomp(im);
centers = [];

for i = 1:length(CC.PixelIdxList)
    % Get the connected components
    component = CC.PixelIdxList{i};
    % Change color of components
    im2(component) = i * 20;
    % Set the x and y positions of the component
    [row, col] = ind2sub(size(im2), component);
    
    % Define centers by X and Y position
    X_center = min(col) + (max(col) - min(col))/2;
    Y_center = min(row) + (max(row) - min(row))/2;
    centers(i,:) = [X_center, Y_center];
    %     bounding_points(i,:) = [min(row), min(col)];
end

imagesc(im2);

% Create grid for determining location and neighbors of all centers
X_grid = unique(centers(:,1));
Y_grid = unique(centers(:,2));

grid = zeros(length(Y_grid), length(X_grid));

% Set position of each center in grid
for i = 1:size(centers,1)
    x = find(X_grid == centers(i,1));
    y = find(Y_grid == centers(i,2));
    grid(y,x) = 1;
    center_id(i) = [x,y];
end


% Move through the graph

