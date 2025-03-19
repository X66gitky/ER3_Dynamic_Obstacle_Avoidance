% 主脚本文件，用于分别测试三个算法
% 清理工作区和命令窗口
clear;
clc;

% 设置项目路径
project_path = 'ER3_Dynamic_Obstacle_Avoidance';
addpath(genpath(project_path));

% 初始化日志目录
create_logs_directory();

% 选择算法
fprintf('请选择要测试的算法:\n');
fprintf('1. RRT*\n');
fprintf('2. Informed RRT*\n');
fprintf('3. Tube RRT*\n');
fprintf('4. Fuzzy Adaptive RRT*N\n');
choice = input('输入对应的数字进行选择: ');

% 根据选择运行相应的算法
switch choice
    case 1
        algorithm_name = 'rrt_star';
    case 2
        algorithm_name = 'informed_rrt_star';
    case 3
        algorithm_name = 'tube_rrt_star';
    case 4
        algorithm_name = 'fuzzy_adaptive_rrt_n';
    otherwise
        error('无效的选择，请输入1到4之间的数字。');
end

fprintf('Running experiment for algorithm: %s\n', algorithm_name);
run_single_algorithm(algorithm_name);

% 生成平均结果比较图
plot_avg_comparison();

function create_logs_directory()
    % 创建 logs 目录（如果不存在）
    log_dir = fullfile('ER3_Dynamic_Obstacle_Avoidance', 'logs');
    if ~exist(log_dir, 'dir')
        mkdir(log_dir);
    end
end