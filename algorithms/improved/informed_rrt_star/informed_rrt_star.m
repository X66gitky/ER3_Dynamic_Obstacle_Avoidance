function [path, derived_nodes] = informed_rrt_star(start, goal, obstacles, max_iter)
    % Informed RRT* 算法的实现
    % 输入:
    %   start - 起始点 [x, y]
    %   goal - 目标点 [x, y]
    %   obstacles - 障碍物信息
    %   max_iter - 最大迭代次数
    % 输出:
    %   path - 规划出的路径
    %   derived_nodes - 路径寻找时的衍生节点

    % 初始化树结构
    tree = start;
    derived_nodes = [];
    path = [];
    
    % 主循环
    for i = 1:max_iter
        % 生成随机点（使用启发式信息引导采样）
        rand_point = generate_informed_sample(start, goal, tree);
        
        % 找到最近的树节点
        [nearest_node, nearest_idx] = find_nearest(tree, rand_point);
        
        % 生成新节点
        new_node = steer(nearest_node, rand_point);
        
        % 检查新节点是否碰撞
        if ~check_collision(new_node, obstacles)
            % 将新节点添加到树中
            tree = [tree; new_node];
            derived_nodes = [derived_nodes; new_node]; % 记录衍生节点
            
            % 检查新节点是否到达目标
            if norm(new_node - goal) < 0.1
                path = trace_path(tree, nearest_idx);
                return;
            end
        end
    end
end

function rand_point = generate_informed_sample(start, goal, tree)
    % 生成启发式引导的随机样本点
    % 此处可实现具体的启发式采样方法
    rand_point = [rand * 10 - 5, rand * 10 - 5];
end

function nearest_node = find_nearest(tree, point)
    % 找到树中最近的节点
    distances = vecnorm(tree - point, 2, 2);
    [~, nearest_idx] = min(distances);
    nearest_node = tree(nearest_idx, :);
end

function new_node = steer(from_node, to_point)
    % 生成新节点
    direction = to_point - from_node;
    new_node = from_node + direction / norm(direction) * 0.1; % 步长
end

function collision = check_collision(node, obstacles)
    % 检查节点是否碰撞
    collision = false;
    for i = 1:length(obstacles)
        if norm(node - obstacles(i).position) < obstacles(i).radius
            collision = true;
            return;
        end
    end
end

function path = trace_path(tree, end_idx)
    % 追踪路径
    path = tree(1:end_idx, :);
end