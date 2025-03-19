function plot_algorithm_trials(algorithm_name)
    % 绘制单个算法的多次试验波动图
    
    % 获取算法目录中的所有试验文件
    input_dir = fullfile('data', 'raw_results', algorithm_name);
    files = dir(fullfile(input_dir, '*.mat'));
    
    % 初始化图形
    figure;
    hold on;
    
    % 遍历所有试验文件
    for i = 1:length(files)
        data = load(fullfile(input_dir, files(i).name));
        
        % 绘制路径
        plot3(data.path(:, 1), data.path(:, 2), data.path(:, 3));
    end
    
    title(sprintf('Algorithm Trials: %s', algorithm_name));
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    grid on;
    hold off;
end