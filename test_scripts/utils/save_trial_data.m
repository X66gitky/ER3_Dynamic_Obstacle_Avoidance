function save_trial_data(algorithm_name, path, derived_nodes)
    % 保存单次试验数据到指定算法目录
    
    % 创建目录（如果不存在）
    output_dir = fullfile('data', 'raw_results', algorithm_name);
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end
    
    % 生成唯一的文件名
    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
    filename = fullfile(output_dir, sprintf('trial_%s.mat', timestamp));
    
    % 保存数据
    save(filename, 'path', 'derived_nodes');
end