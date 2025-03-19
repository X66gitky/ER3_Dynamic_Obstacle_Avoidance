function aggregate_metrics(algorithm_name)
    % 计算单个算法的平均结果（非多算法混合）
    
    % 获取算法目录中的所有试验文件
    input_dir = fullfile('data', 'raw_results', algorithm_name);
    files = dir(fullfile(input_dir, '*.mat'));
    
    % 初始化指标
    total_time = 0;
    total_path_length = 0;
    num_trials = length(files);
    
    % 遍历所有试验文件
    for i = 1:num_trials
        data = load(fullfile(input_dir, files(i).name));
        
        % 计算单次试验的时间和路径长度
        path_length = sum(sqrt(sum(diff(data.path).^2, 2)));
        trial_time = length(data.derived_nodes);
        
        % 累加到总指标中
        total_path_length = total_path_length + path_length;
        total_time = total_time + trial_time;
    end
    
    % 计算平均指标
    avg_path_length = total_path_length / num_trials;
    avg_time = total_time / num_trials;
    
    % 保存平均指标
    output_file = fullfile('data', 'averaged_results', sprintf('%s_avg.mat', algorithm_name));
    save(output_file, 'avg_path_length', 'avg_time');
end