function env = update_obstacles(env, dt)
    % 动态更新障碍物位置
    % 输入：
    %   env - 包含障碍物信息的结构体
    %   dt - 时间步长
    % 输出：
    %   env - 更新后的环境信息结构体

    if env.is_dynamic
        env.obstacles = update_dynamic_obstacles(env.obstacles, dt);
    end
end

%% 用于动态更新障碍物的位置。每个时间步调用一次，更新所有动态障碍物的位置。
