function static_obstacles = init_static_obstacles()
    % 初始化静态障碍物（形状和初始位置）
    % 输出：static_obstacles - 静态障碍物的结构体数组

    % 定义障碍物参数
    numObstacles = 3;
    static_obstacles(numObstacles) = struct();

    % 随机生成障碍物
    for i = 1:numObstacles
        type = randi([1, 3]);
        switch type
            case 1 % 立方体障碍物
                static_obstacles(i).type = 'cube';
                static_obstacles(i).size = rand(1, 3) * 0.5 + 0.1; % 尺寸
                static_obstacles(i).position = rand(1, 3) * 10 - 5; % 随机位置
            case 2 % 圆柱体障碍物
                static_obstacles(i).type = 'cylinder';
                static_obstacles(i).radius = rand * 0.5 + 0.1; % 半径
                static_obstacles(i).height = rand * 1.5 + 0.1; % 高度
                static_obstacles(i).position = rand(1, 3) * 10 - 5; % 随机位置
            case 3 % 球体障碍物
                static_obstacles(i).type = 'sphere';
                static_obstacles(i).radius = rand * 0.5 + 0.1; % 半径
                static_obstacles(i).position = rand(1, 3) * 10 - 5; % 随机位置
        end
    end
end

%% 用于初始化静态障碍物的形状和初始位置。
