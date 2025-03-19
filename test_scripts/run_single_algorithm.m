function run_single_algorithm(algorithm_name)
    % 运行单个算法的实验并记录日志
    
    % 创建 logs 目录（如果不存在）
    create_logs_directory();
    
    % 日志文件路径
    log_file = fullfile('logs', [algorithm_name, '.log']);
    
    % 打开日志文件（追加模式）
    fid = fopen(log_file, 'a');
    
    % 记录实验开始时间
    fprintf(fid, '%s - Experiment started\n', datestr(now, 'yyyy-mm-dd HH:MM:SS'));
    fprintf(fid, 'Algorithm: %s\n', algorithm_name);
    fprintf(fid, 'Parameters: { ... }\n');
    
    % 加载环境，假设需要动态障碍物
    is_dynamic = true;
    environment = init_environment(is_dynamic);
    
    % 运行指定算法
    switch algorithm_name
        case 'rrt_star'
            [path, derived_nodes] = rrt_star(environment);
        case 'informed_rrt_star'
            [path, derived_nodes] = informed_rrt_star(environment);
        case 'tube_rrt_star'
            [path, derived_nodes] = tube_rrt_star(environment);
        case 'fuzzy_adaptive_rrt_n'
            [path, derived_nodes] = fuzzy_adaptive_rrt_n(environment);
        otherwise
            error('Unknown algorithm: %s', algorithm_name);
    end
    
    % 保存试验数据
    save_trial_data(algorithm_name, path, derived_nodes);
    
    % 生成测试结果图
    plot_results(environment, path, derived_nodes);
    
    % 记录实验结束时间
    fprintf(fid, '%s - Experiment ended\n\n', datestr(now, 'yyyy-mm-dd HH:MM:SS'));
    
    % 关闭日志文件
    fclose(fid);
end

function create_logs_directory()
    % 创建 logs 目录（如果不存在）
    log_dir = 'logs';
    if ~exist(log_dir, 'dir')
        mkdir(log_dir);
    end
end

function plot_results(environment, path, derived_nodes)
    % 生成三种测试结果图

    % 提取动态障碍物的位置
    dynamic_obstacle_positions = arrayfun(@(obstacle) obstacle.position, environment.dynamic_obstacles, 'UniformOutput', false);
    dynamic_obstacle_positions = cell2mat(dynamic_obstacle_positions')';

    % 提取动态障碍物的位置
    dynamic_obstacle_positions = arrayfun(@(obstacle) obstacle.position, environment.dynamic_obstacles, 'UniformOutput', false);
    dynamic_obstacle_positions = cell2mat(dynamic_obstacle_positions')';

    % 图1：障碍物、衍生节点、最终路径
    figure;
    hold on;
    scatter3(dynamic_obstacle_positions(:,1), dynamic_obstacle_positions(:,2), dynamic_obstacle_positions(:,3), 'filled');
    scatter3(derived_nodes(:,1), derived_nodes(:,2), derived_nodes(:,3), 'r');
    if ~isempty(path)
        plot3(path(:,1), path(:,2), path(:,3), 'LineWidth', 2);
    end
    title('Obstacles, Derived Nodes, and Final Path');
    hold off;
    
    % 图2：障碍物、最终路径
    figure;
    hold on;
    scatter3(dynamic_obstacle_positions(:,1), dynamic_obstacle_positions(:,2), dynamic_obstacle_positions(:,3), 'filled');
    if ~isempty(path)
        plot3(path(:,1), path(:,2), path(:,3), 'LineWidth', 2);
    end
    title('Obstacles and Final Path');
    hold off;
    
    % 图3：动态机械臂、障碍物、机械臂运动过程和最终路径
    robot = importrobot('model.urdf'); % 使用提供的机械臂模型
    animate_with_obstacles(robot, path, dynamic_obstacle_positions);
end