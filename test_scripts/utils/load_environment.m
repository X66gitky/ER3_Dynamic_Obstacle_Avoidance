function [robot, obstacles] = load_environment()
    % 加载固定环境配置（三个障碍物）
    
    % 加载机械臂模型
    robot = importrobot('models/model.urdf');
    robot.DataFormat = 'row';

    % 加载静态障碍物
    load('environments/three_obstacles.mat', 'obstacles');
end