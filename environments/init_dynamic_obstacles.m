function dynamic_obstacles = init_dynamic_obstacles()
    % 初始化动态障碍物（形状和初始位置）
    % 输出：dynamic_obstacles - 动态障碍物的结构体数组

    % 定义障碍物参数
    numObstacles = 3;
    dynamic_obstacles(numObstacles) = struct();

    % 随机生成障碍物
    for i = 1:numObstacles
        type = randi([1, 3]);
        switch type
            case 1 % 立方体障碍物
                dynamic_obstacles(i).type = 'cube';
                dynamic_obstacles(i).size = rand(1, 3) * 0.5 + 0.1; % 尺寸
                dynamic_obstacles(i).position = rand(1, 3) * 10 - 5; % 随机位置
                dynamic_obstacles(i).velocity = (rand(1, 3) - 0.5) * 2 * 0.1; % 随机速度
            case 2 % 圆柱体障碍物
                dynamic_obstacles(i).type = 'cylinder';
                dynamic_obstacles(i).radius = rand * 0.5 + 0.1; % 半径
                dynamic_obstacles(i).height = rand * 1.5 + 0.1; % 高度
                dynamic_obstacles(i).position = rand(1, 3) * 10 - 5; % 随机位置
                dynamic_obstacles(i).velocity = (rand(1, 3) - 0.5) * 2 * 0.1; % 随机速度
            case 3 % 球体障碍物
                dynamic_obstacles(i).type = 'sphere';
                dynamic_obstacles(i).radius = rand * 0.5 + 0.1; % 半径
                dynamic_obstacles(i).position = rand(1, 3) * 10 - 5; % 随机位置
                dynamic_obstacles(i).velocity = (rand(1, 3) - 0.5) * 2 * 0.1; % 随机速度
        end
    end
end