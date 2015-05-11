clc;close all;clear;
%% References:
% From 2D Orthographic views to 3D Pseudo-Wireframe:An Automatic Procedure
% “3D reconstruction problem”: an automated procedure
% http://www.cs.umaine.edu/~markov/FleshingOutWireFrames.pdf


%% Procedure

%% Extract entities from DXF
% http://pythonhosted.org/ezdxf/tutorials/getting_data.html

% Sample "endpoints", i.e. a 2n X 3 matrix containing the start and end
% X,Y,Z points defining a line

% Get DXF views
frontDXF = 1;
sideDXF = 2;
topDXF = 3;

% Split DXF endpoints into 3 sets of data (front, side, top)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Start off with made up data for a cube
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Front view
% vertices : (x,y,z) => using X and Z
v_f = [0,0,0; 0,0,10; 10,0,0; 10,0,10];
% edges : (x1, y1, z1, x2, y2, z2)
e_f(:,:,1) = [v_f(1,:); v_f(2,:)];
e_f(:,:,2) = [v_f(1,:); v_f(3,:)];
e_f(:,:,3) = [v_f(2,:); v_f(4,:)];
e_f(:,:,4) = [v_f(3,:); v_f(4,:)];

front.edges = e_f;
front.vertices = v_f;
% Create 2D vertices in appropriate view plane (XZ)
front.display_vertices = [v_f(:,1), v_f(:,3)];
front.adjacency = [0, 1, 1, 0;
                   1, 0, 0, 1;
                   1, 0, 0, 1
                   0, 1, 1, 0];

% Side view
% vertices : (x,y,z) => Using Y and Z
v_s = [0,0,0; 0,0,10; 0,10,0; 0,10,10];
% edges : (x1, y1, x2, y2)
e_s(:,:,1) = [v_s(1,:); v_s(2,:)];
e_s(:,:,2) = [v_s(1,:); v_s(3,:)];
e_s(:,:,3) = [v_s(2,:); v_s(4,:)];
e_s(:,:,4) = [v_s(3,:); v_s(4,:)];

side.edges = e_s;
side.vertices = v_s;
% Create 2D vertices in appropriate view plane (YZ)
side.display_vertices = [v_s(:,2), v_s(:,3)];
side.adjacency = [0, 1, 1, 0;
                  1, 0, 0, 1;
                  1, 0, 0, 1
                  0, 1, 1, 0];

% Top view => Using X and Y
% vertices : (x,y,z)
v_t = [0,0,0; 0,10,0; 10,0,0; 10,10,0];
% edges : (x1, y1, x2, y2)
e_t(:,:,1) = [v_t(1,:); v_t(2,:)];
e_t(:,:,2) = [v_t(1,:); v_t(3,:)];
e_t(:,:,3) = [v_t(2,:); v_t(4,:)];
e_t(:,:,4) = [v_t(3,:); v_t(4,:)];

top.edges = e_t;
top.vertices = v_t;
% Create 2D vertices in appropriate view plane (XY)
top.display_vertices = [v_t(:,1), v_t(:,2)];
top.adjacency = [0, 1, 1, 0;
                 1, 0, 0, 1;
                 1, 0, 0, 1
                 0, 1, 1, 0];
               
% Label vertices in each set of data


% Create "segmented" data (new edges based on intersections)


% Perform collinearity check on all edges and create concatenation matrix
% and parallelism matrix


% Show the pseudo wireframe
f = figure;

% Plot Side
subplot(2,2,3);
gplot(side.adjacency, side.display_vertices, '-o');
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',3);
axis([-1, 11, -1, 11]);
title('Side');
xlabel('Y');
ylabel('Z');

% Plot Top
subplot(2,2,2);
gplot(top.adjacency, top.display_vertices, '-o');
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',3);
axis([-1, 11, -1, 11]);
title('Top');
xlabel('X');
ylabel('Y');

% Plot Front
subplot(2,2,4);
gplot(front.adjacency, front.display_vertices, '-o');
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',3);
axis([-1, 11, -1, 11]);
title('Front');
xlabel('X');
ylabel('Z');



% Project algorithm
% for every vertex in each view:
%   



% Plot 3d view
%subplot(2,2,1);
%plot3();




