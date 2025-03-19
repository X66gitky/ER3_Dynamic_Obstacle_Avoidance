function [path, derived_nodes] = fuzzy_adaptive_rrt_n(start, goal, obstacles, max_iter)
    % Fuzzy Adaptive RRT*N 算法的实现
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
        % 生成随机点
        rand_point = generate_random_sample(start, goal);
        
        % 找到最近的树节点
        [nearest_node, nearest_idx] = find_nearest(tree, rand_point);
        
        % 生成新节点
        new_node = steer_with_fuzzy_logic(nearest_node, rand_point);
        
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

function rand_point = generate_random_sample(start, goal)
    % 生成随机样本点
    rand_point = start + (goal - start) .* rand(size(start));
end

function nearest_node = find_nearest(tree, point)
    % 找到树中最近的节点
    distances = vecnorm(tree - point, 2, 2);
    [~, nearest_idx] = min(distances);
    nearest_node = tree(nearest_idx, :);
end

function new_node = steer_with_fuzzy_logic(from_node, to_point)
    % 使用模糊逻辑生成新节点
    direction = to_point - from_node;
    new_node = from_node + direction / norm(direction) * 0.1; % 步长
    
    % 添加模糊逻辑调整路径规划
    fuzzy_adjustment = apply_fuzzy_logic(direction);
    new_node = new_node