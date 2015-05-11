function [ vertices, A ] = csv2vertices( dxf_file )
    % csv2vertices: gets vertices and edges from a dxf file of the following format
    %   [x1,y1,z1,x2,y2,z2]
    %
    % vertices : M x 2 matrix of x and y coordinates of unique points
    % A : M x M adjacency matrix of connected vertices
    %
    
    vertices = csvread(dxf_file);
    
    v1 = vertices(:,1:2); % start points of each edge
    v2 = vertices(:,4:5); % end points of each edge
    % Remove minimum x and y from all vertices
    minXY = [min([v1(:,1);v2(:,1)]), min([v1(:,2);v2(:,2)])];
    v1 = v1 - repmat(minXY, size(v1,1),1);
    v2 = v2 - repmat(minXY, size(v2,1),1);
    v1 = round(v1 * 1000);
    v2 = round(v2 * 1000);
    vertices = [v1; v2]; % put all vertices in matrix
    vertices = unique(vertices, 'rows');
    
    % Edges is a to-from matrix with indices matching those of vertices
    edges = zeros(size(v1,1), 2);
    for i = 1:size(vertices,1)
        x1 = vertices(i,1);
        y1 = vertices(i,2);
        
        % Go through all of the "from" vertices, and label each one an
        % index
        for j = 1:size(v1,1)
            x2 = v1(j,1);
            y2 = v1(j,2);
            if x1 == x2 & y1 == y2
                edges(j,1) = i;
            end
        end
        
        % Go through all of the "to" vertices, and label each one an
        % index
        for j = 1:size(v2,1)
            x2 = v2(j,1);
            y2 = v2(j,2);
            if x1 == x2 & y1 == y2
                edges(j,2) = i;
            end
        end
    end
    
    % Add any edges that could potentially exist but not be described by
    % the DXF file. These edges can be created using the "segmentation"
    % algorithm, by which every edge must be checked for possible
    % intermediate vertices. If there is a possible intermediate vertex
    % along an edge, then 2 new edges are added to the list of "new edges"
    new_edges = [];
    for i = 1:size(edges,1)
        from = edges(i,1);
        to = edges(i,2);
        x1 = vertices(from,1);
        y1 = vertices(from,2);
        x2 = vertices(to,1);
        y2 = vertices(to,2);
        
        min_x = min([x1, x2]);
        min_y = min([y1, y2]);
        max_x = max([x1, x2]);
        max_y = max([y1, y2]);
        
        edge_list = [to; from];
        
        if x1 ~= x2
            slope = (y2 - y1) / (x2 - x1);
            intercept = y1 - slope * x1;
            % If a vertex lies along the given edge, then add all possible new
            % "segments" to a new edge list
            for j = 1:size(vertices,1)
                xp = vertices(j,1);
                yp = vertices(j,2);
                
                % if the point is the same as the to or from point of the
                % edge, then move on to the next point. If the point is on
                % the edge and is not the to or from point, then add it to
                % the list of new edges
                if (xp == x1 && yp == y1) || (xp == x2 && yp == y2)
                    continue;
                elseif (xp < min_x && yp < min_y) || (xp > max_x && yp > max_y)
                    continue;
                elseif yp == slope * xp + intercept
                    edge_list = [edge_list; j];
                end
                
            end
        elseif x1 == x2
            for j = 1:size(vertices,1)
                xp = vertices(j,1);
                yp = vertices(j,2);
                
                if (xp == x1 && yp == y1) || (xp == x2 && yp == y2)
                    continue;
                elseif (xp < min_x && yp < min_y) || (xp > max_x && yp > max_y)
                    continue;
                elseif xp == x1
                    edge_list = [edge_list; j];
                end
                
            end
        end
        
        % Create all possible combinations of the edge list and add it to
        % the new_edges list
        new_edges = [new_edges; unique(combnk(edge_list, 2), 'rows')];
        
    end
    
    % Remove any non-unique edges
    edges = unique([edges; new_edges], 'rows');
    
    
    % Check for co-linear edges and add any combined possible edges
    new_edges = [];
    for i = 1:size(edges, 1)
        to1 = edges(i,2);
        from1 = edges(i,1);
        e1x1 = vertices(to1,1);
        e1x2 = vertices(from1,1);
        e1y1 = vertices(to1,2);
        e1y2 = vertices(from1,2);
        slope1 = (e1y2 - e1y1) / (e1x2 - e1x1);
        
        for j = 1:size(edges, 1)
            if i == j
                continue
            else
                to2 = edges(j,2);
                from2 = edges(j,1);
                e2x1 = vertices(from2,1);
                e2x2 = vertices(to2,1);
                e2y1 = vertices(from2,2);
                e2y2 = vertices(to2,2);
                slope2 = (e2y2 - e2y1) / (e2x2 - e2x1);
                
                if slope1 == slope2
                    if (isequal([e1x1,e1y1],[e2x1,e2y1]) || isequal([e1x1,e1y1],[e2x2,e2y2]) || isequal([e1x2,e1y2],[e2x1,e2y1]) || isequal([e1x2,e1y2],[e2x2,e2y2]))
                        n = [from1, to2; from2, to1];
                        new_edges = [new_edges; n];
                    end
                end
            end
            
        end
        
    end
    edges = [edges; new_edges];
    
    % Remove any non-unique edges
    edges = unique([edges; new_edges], 'rows');
    
    % Create adjacency matrix from the edges
    A = zeros(size(vertices,1));
    for i = 1:size(edges,1)
        vertex1 = edges(i,1);
        vertex2 = edges(i,2);
        A(vertex1, vertex2) = 1;
        A(vertex2, vertex1) = 1;
    end
    
end

