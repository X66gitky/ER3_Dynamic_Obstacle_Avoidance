function environment = init_environment(is_dynamic)
    % 初始化障碍物（形状、轨迹）
    environment.static_obstacles = init_static_obstacles();
    if is_dynamic
        environment.dynamic_obstacles = init_dynamic_obstacles();
    else
        environment.dynamic_obstacles = [];
    end
end