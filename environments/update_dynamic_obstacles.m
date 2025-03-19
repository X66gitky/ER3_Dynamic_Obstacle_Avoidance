function dynamic_obstacles = update_dynamic_obstacles(dynamic_obstacles, dt)
    % 动态更新障碍物位置
    % 输入：
    %   dynamic_obstacles - 动态障碍物的结构体数组
    %   dt - 时间步长
    % 输出：
    %   dynamic_obstacles - 更新后的动态障碍物结构体数组

    for i = 1:length(dynamic_obstacles)
        % 更新位置
        dynamic_obstacles(i).position = dynamic_obstacles(i).position + dynamic_obstacles(i).velocity * dt;
    end
end


%% 用于动态更新障碍物的位置。
