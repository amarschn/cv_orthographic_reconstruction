clc;close all;clear;

% Front
[v_f, a_f] = csv2vertices('example_part_3_front.csv');

% Top
[v_t, a_t] = csv2vertices('example_part_3_top.csv');

% Side
[v_s, a_s] = csv2vertices('example_part_3_side.csv');

%% Plot orthographic views
% Plot Front
subplot(2,2,4);
gplot(a_f, v_f, '-o');
axis([min(v_f(:,1)) - 10; max(v_f(:,1)) + 10; min(v_f(:,2)) - 10; max(v_f(:,2)) + 10]);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',3);
set(gca, 'YTickLabel', []);
set(gca, 'XTickLabel', []);
title('Front', 'fontweight', 'bold');
xlabel('X', 'fontweight', 'bold');
ylabel('Z', 'fontweight', 'bold');

% Plot Top
subplot(2,2,2);
gplot(a_t, v_t, '-o');
axis([min(v_t(:,1)) - 10; max(v_t(:,1)) + 10; min(v_t(:,2)) - 10; max(v_t(:,2)) + 10]);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',3);
set(gca, 'YTickLabel', []);
set(gca, 'XTickLabel', []);
title('Top', 'fontweight', 'bold');
xlabel('X', 'fontweight', 'bold');
ylabel('Y', 'fontweight', 'bold');

% Plot Side
subplot(2,2,3);
gplot(a_s, v_s, '-o');
axis([min(v_s(:,1)) - 10; max(v_s(:,1)) + 10; min(v_s(:,2)) - 10; max(v_s(:,2)) + 10]);
hline = findobj(gcf, 'type', 'line');
set(hline,'LineWidth',3);
set(gca, 'YTickLabel', []);
set(gca, 'XTickLabel', []);
title('Side', 'fontweight', 'bold');
xlabel('Y', 'fontweight', 'bold');
ylabel('Z', 'fontweight', 'bold');

% Construct pseudo vertex skeleton. Check perpendiculars in the X,Y,Z for each
% vertex in each orthographic view. Only vertices that are lying on at
% least 2 perpendiculars are selected. Check if each vertex has already
% been introduced, if not then add it to the list of 3D vertices
vertices{1} = v_f;
vertices{2} = v_t;
vertices{3} = v_s;



% Front : XZ
front = [v_f(:,1), zeros(size(v_f,1),1), v_f(:,2)];
% Top : XY
top = [v_t, zeros(size(v_t,1),1)];
% Side : YZ
side = [zeros(size(v_s,1),1), v_s];


[pseudo_vertices, pseudo_edges] = pseudoSkeleton(front, a_f, top, a_t, side, a_s);



subplot(2,2,1);
xlabel('X');
ylabel('Y');
zlabel('Z');
hold;
for i = 1:size(pseudo_edges,1)
    x = [pseudo_edges(i,1); pseudo_edges(i,4)];
    y = [pseudo_edges(i,2); pseudo_edges(i,5)];
    z = [pseudo_edges(i,3); pseudo_edges(i,6)];
    plot3(x,y,z);
end
scatter3(pseudo_vertices(:,1), pseudo_vertices(:,2), pseudo_vertices(:,3),'filled');
set(gca, 'YTickLabel', []);
set(gca, 'XTickLabel', []);
set(gca, 'ZTickLabel', []);
title('3D Wireframe Skeleton', 'fontweight', 'bold');
