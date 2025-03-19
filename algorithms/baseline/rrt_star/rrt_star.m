function [path, derived_nodes] = rrt_star(environment)
    % RRT* 算法实现
    % 输入：environment - 包含障碍物和其他环境信息的结构体
    % 输出：path - 规划出的路径
    %       derived_nodes - 生成的节点

    % 参数设置
    start = [0, 0, 0];
    goal = [5, 5, 5];
    max_iter = 100; % 减少迭代次数
    step_size = 0.1;
    goal_threshold = 0.5; % 设置为0.5以避免数值误差问题
    
    % 初始化路径和节点
    path = [];
    derived_nodes = start;
    
    % 初始化树
    tree.vertices = start;
    tree.edges = [];

    for i = 1:max_iter
        fprintf('Iteration: %d\n', i); % 添加调试信息
        
        % 采样节点
        rand_node = sample_node(goal);
        
        % 找到最近节点
        nearest_node = find_nearest_node(tree, rand_node);
        
        % 扩展树
        new_node = extend_tree(nearest_node, rand_node, step_size);
        
        % 检查是否与障碍物碰撞
        if ~check_collision(new_node, environment)
            % 添加新节点到树中
            tree.vertices = [tree.vertices; new_node];
            tree.edges = [tree.edges; nearest_node, new_node];
            
            % 更新生成的节点
            derived_nodes = [derived_nodes; new_node];
            
            % 检查是否到达目标
            if norm(new_node - goal) < goal_threshold
                path = find_path(tree, start, goal);
                break;
            end
        end
    end
    
    % 如果未找到路径，返回空路径
    if isempty(path)
        disp('未找到路径');
    end
end

function rand_node = sample_node(goal)
    % 采样节点（简化示例）
    if rand() < 0.1
        rand_node = goal;
    else
        rand_node = rand(1, 3) * 10; % 随机生成一个节点
    end
end

function nearest_node = find_nearest_node(tree, rand_node)
    % 找到树中距离随机节点最近的节点
    distances = sum((tree.vertices - rand_node).^2, 2);
    [~, idx] = min(distances);
    nearest_node = tree.vertices(idx, :);
end

function new_node = extend_tree(nearest_node, rand_node, step_size)
    % 扩展树（沿着最近节点和随机节点之间的方向）
    direction = rand_node - nearest_node;
    direction = direction / norm(direction) * step_size;
    new_node = nearest_node + direction;
end

function collision = check_collision(node, environment)
    % 检查节点是否与障碍物碰撞
    collision = false;
    for i = 1:numel(environment.dynamic_obstacles)
        obstacle = environment.dynamic_obstacles(i);
        switch obstacle.type
            case 'cube'
                % 检查立方体障碍物的碰撞
                if all(abs(node - obstacle.position) <= obstacle.size / 2)
                    collision = true;
                    return;
                end
            case 'cylinder'
                % 检查圆柱体障碍物的碰撞
                d = norm(node(1:2) - obstacle.position(1:2));
                if d <= obstacle.radius && abs(node(3) - obstacle.position(3)) <= obstacle.height / 2
                    collision = true;
                    return;
                end
            case 'sphere'
                % 检查球体障碍物的碰撞
                if norm(node - obstacle.position) <= obstacle.radius
                    collision = true;
                    return;
                end
        end
    end
end

function path = find_path(tree, start, goal)
    % 找到从起点到目标的路径（简化示例）
    path = [goal];
    node = goal;
    while ~isequal(node, start)
        for i = size(tree.edges, 1):-1:1
            if isequal(tree.edges(i, 2), node)
                node = tree.edges(i, 1);
                path = [node; path];
                break;
            end
        end
    end
end