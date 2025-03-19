% visualize_environment.m
% 初始化环境并加载机械臂模型

% 清除之前的图形窗口和变量
clear;
clc;
close all;

% 加载环境
is_dynamic = true;
environment = init_environment(is_dynamic);

% 创建一个新图形窗口
figure;
hold on;

% 绘制动态障碍物
for i = 1:numel(environment.dynamic_obstacles)
    obstacle = environment.dynamic_obstacles(i);
    switch obstacle.type
        case 'cube'
            draw_cube(obstacle.position, obstacle.size);
        case 'cylinder'
            draw_cylinder(obstacle.position, obstacle.radius, obstacle.height);
        case 'sphere'
            [X, Y, Z] = sphere(20);
            X = X * obstacle.radius + obstacle.position(1);
            Y = Y * obstacle.radius + obstacle.position(2);
            Z = Z * obstacle.radius + obstacle.position(3);
            surf(X, Y, Z, 'FaceAlpha', 0.5);
    end
end

% 加载和绘制机械臂模型
robot = importrobot('model.urdf'); % 使用提供的机械臂模型
showdetails(robot); % 显示连杆间父子关系
show(robot, 'Frames', 'on', 'Visuals', 'on'); % 显示机械臂

% 设置图形属性
title('Environment with Dynamic Obstacles and Robotic Arm');
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
axis equal;
view(3); % 设置为三维视图
rotate3d on; % 启用旋转

hold off;

% 辅助函数绘制立方体
function draw_cube(position, size)
    % 获取立方体的顶点坐标
    vertices = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1; 1 1 1; 0 1 1] .* size + position - size / 2;
    faces = [1 2 3 4; 2 6 7 3; 4 3 7 8; 1 5 8 4; 1 2 6 5; 5 6 7 8];
    patch('Vertices', vertices, 'Faces', faces, 'FaceColor', 'red', 'FaceAlpha', 0.5);
end

% 辅助函数绘制圆柱体
function draw_cylinder(position, radius, height)
    [X, Y, Z] = cylinder(radius);
    Z = Z * height + position(3) - height / 2;
    surf(X + position(1), Y + position(2), Z, 'FaceAlpha', 0.5);
end