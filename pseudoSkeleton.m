function [ pseudo_vertices, pseudo_edges ] = pseudoSkeleton( front, A_front, top, A_top, side, A_side )
    % pseudoVertices : Returns pseudo vertices given vertices in the front,
    % top, and side projections.
    %
    % Given:::
    % front : vertices of front projection
    % A_front : adjacency matrix of front vertices
    % top : vertices of top projection
    % A_top : adjacency matrix of top vertices
    % side : vertices of side projection
    % A_side : adjacency matrix of side vertices
    
    pseudo_vertices = [];
    pseudo_edges = [];
    
    % Check perpendiculars in the X,Y,Z for each
    % vertex in each orthographic view. Only vertices that are lying on at
    % least 2 perpendiculars are selected.
    
    % loop through vertices in front view. We want to replace the Y
    % variable for each front vertex
    for f = 1:size(front,1)
        % the given front vertex
        fx = front(f,1);
        fy = front(f,2);
        fz = front(f,3);
        % look for top vertices that match the front vertex X value
        for t = 1:size(top,1)
            tx = top(t,1);
            ty = top(t,2);
            tz = top(t,3);
            
            if fx == tx
                v = [fx, ty, fz];
                pseudo_vertices = [pseudo_vertices; v];
            end
        end
        
        % look for side vertices that match the front vertex Z value
        for s = 1:size(side,1)
            sx = side(s,1);
            sy = side(s,2);
            sz = side(s,3);
            
            if fz == sz
                v = [fx, sy, fz];
                pseudo_vertices = [pseudo_vertices; v];
            end
        end
    end
    
    % loop through vertices in top view. We want to replace the Z variable
    % for each top vertex
    for t = 1:size(top,1)
        tx = top(t,1);
        ty = top(t,2);
        tz = top(t,3);
        
        % look for front vertices that match the top vertex X value
        for f = 1:size(front,1)
            fx = front(f,1);
            fy = front(f,2);
            fz = front(f,3);
            
            if tx == fx
                v = [tx, ty, fz];
                pseudo_vertices = [pseudo_vertices; v];
            end
        end
        
        % look for side vertices that match the top vertex Y value
        for s = 1:size(side,1)
            sx = side(s,1);
            sy = side(s,2);
            sz = side(s,3);
            
            if ty == sy
                v = [tx, ty, sz];
                pseudo_vertices = [pseudo_vertices; v];
            end
        end
    end
    
    % loop through vertices in side view. We want to replace the X variable
    % for each side vertex
    for s = 1:size(side,1)
        sx = side(s,1);
        sy = side(s,2);
        sz = side(s,3);
        
        % look for front vertices that match the side vertex Z value
        for f = 1:size(front,1)
            fx = front(f,1);
            fy = front(f,2);
            fz = front(f,3);
            
            if sz == fz
                v = [fx, sy, sz];
                pseudo_vertices = [pseudo_vertices; v];
            end
        end
        
        % look for top vertices that match the side vertex Y value
        for t = 1:size(top,1)
            tx = top(t,1);
            ty = top(t,2);
            tz = top(t,3);
            
            if sy == ty
                v = [tx, sy, sz];
                pseudo_vertices = [pseudo_vertices; v];
            end
        end
    end
    
    % Remove all redundant vertices. Have to do this specially to remove
    % the problem with finding unique doubles
    pseudo_vertices = unique(pseudo_vertices, 'rows');
    
    
    pseudo_edges = [];
    
    % Add ones to the diagonal of the adjacency matrices, this is so that
    % the vertex checker will count vertex connections right on top of each
    % other in a given projection
    o_f = diag(ones(length(A_front),1));
    o_t = diag(ones(length(A_top),1));
    o_s = diag(ones(length(A_side),1));
    A_front = A_front + o_f;
    A_top = A_top + o_t;
    A_side = A_side + o_s;
    
    
    % Go through all vertices and compare to every other vertex in every
    % projection to see if there is an edge connection in every projection
    for i = 1:size(pseudo_vertices,1)
        
        
        px1 = pseudo_vertices(i,1);
        py1 = pseudo_vertices(i,2);
        pz1 = pseudo_vertices(i,3);
        
        % find relevant front vertex
        idx_f1 = find(ismember(front, [px1, 0, pz1], 'rows'));
        
        % find relevant top vertex
        idx_t1 = find(ismember(top, [px1, py1, 0], 'rows'));
        
        % find relevant side vertex
        idx_s1 = find(ismember(side, [0, py1, pz1], 'rows'));
        
        
        for j = 1:size(pseudo_vertices,1)
            if j == i
                continue
            end
            px2 = pseudo_vertices(j,1);
            py2 = pseudo_vertices(j,2);
            pz2 = pseudo_vertices(j,3);
            
            
            % find relevant front vertex
            idx_f2 = find(ismember(front, [px2, 0, pz2], 'rows'));
            
            % find relevant top vertex
            idx_t2 = find(ismember(top, [px2, py2, 0], 'rows'));
            
            % find relevant side vertex
            idx_s2 = find(ismember(side, [0, py2, pz2], 'rows'));
            
            % boolean values defining whether the adjacency matrix is 0 or
            % 1 at each given projection
            f = A_front(idx_f1, idx_f2);
            t = A_top(idx_t1, idx_t2);
            s = A_side(idx_s1, idx_s2);
            
            % If there is an edge at every projection then add the edge to
            % pseudo edges
            if f & t & s
                pseudo_edges = [pseudo_edges; px1, py1, pz1, px2, py2, pz2];
            end
            
        end

    end
    
    pseudo_edges = unique(pseudo_edges, 'rows');
    
    
end

