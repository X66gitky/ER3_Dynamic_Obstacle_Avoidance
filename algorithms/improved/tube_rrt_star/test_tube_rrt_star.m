% 测试 Tube-RRT* 算法
clc; clear; close all;

% 初始化环境
[robot, obstacles] = init_environment();

% 初始化起始点和目标点
start = [0, 0];
goal = [5, 5];

% 运行 Tube-RRT* 算法
max_iter = 1000;
[path, derived_nodes] = tube_rrt_star(start, goal, obstacles, max_iter);

% 生成三种测试结果图
plot_derived_nodes_and_final_path(obstacles, derived_nodes, path);
plot_final_path(obstacles, path);
plot_robot_motion(robot, obstacles, path);

function plot_derived_nodes_and_final_path(obstacles, derived_nodes, path)
    % 绘制障碍物、路径寻找时的衍生节点以及一条最终路径
    figure;
    hold on;
    scatter(obstacles(:, 1), obstacles(:, 2), 'k', 'filled');
    scatter(derived_nodes(:, 1), derived_nodes(:, 2), 'b', 'filled');
    plot(path(:, 1), path(:, 2), 'r-', 'LineWidth', 2);
    title('Derived Nodes and Final Path');
    xlabel('X');
    ylabel('Y');
    grid on;
    hold off;
end

function plot_final_path(obstacles, path)
    % 绘制障碍物和最终路径
    figure;
    hold on;
    scatter(obstacles(:, 1), obstacles(:, 2), 'k', 'filled');
    plot(path(:, 1), path(:, 2), 'r-', 'LineWidth', 2);
    title('Final Path');
    xlabel('X');
    ylabel('Y');
    grid on;
    hold off;
end

function plot_robot_motion(robot, obstacles, path)
    % 绘制机械臂的运动过程、障碍物和一条最终路径
    figure;
    hold on;
    scatter(obstacles(:, 1), obstacles(:, 2), 'k', 'filled');
    plot(path(:, 1), path(:, 2), 'r-', 'LineWidth', 2);
    for i = 1:size(path, 1)
        show(robot, path(i, :), 'PreservePlot', false);
        pause(0.1); % 动画效果
    end
    title('Robot Motion and Final Path');
    xlabel('X');
    ylabel('Y');
    grid on;
    hold off;
end