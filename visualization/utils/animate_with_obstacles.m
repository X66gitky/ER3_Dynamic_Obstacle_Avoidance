function animate_with_obstacles(robot, path, obstacles)
    % 带动态障碍物的路径动画
    % robot: 机械臂模型
    % path: 路径数据
    % obstacles: 障碍物数据
    
    figure;
    hold on;
    scatter3(obstacles(:, 1), obstacles(:, 2), obstacles(:, 3), 'k', 'filled');
    plot3(path(:, 1), path(:, 2), path(:, 3), 'r-', 'LineWidth', 2);
    
    for i = 1:size(path, 1)
        show(robot, path(i, :), 'PreservePlot', false);
        pause(0.1); % 动画效果
    end
    
    title('Robot Motion with Obstacles');
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    grid on;
    hold off;
end