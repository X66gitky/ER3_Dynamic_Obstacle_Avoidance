function plot_avg_comparison()
    % 对比多个算法的平均结果
    
    % 加载平均结果
    rrt_star_avg = load(fullfile('data', 'averaged_results', 'rrt_star_avg.mat'));
    informed_rrt_star_avg = load(fullfile('data', 'averaged_results', 'informed_rrt_star_avg.mat'));
    tube_rrt_star_avg = load(fullfile('data', 'averaged_results', 'tube_rrt_star_avg.mat'));
    fuzzy_adaptive_rrt_n_avg = load(fullfile('data', 'averaged_results', 'fuzzy_adaptive_rrt_n_avg.mat'));
    
    % 创建表格比较
    avg_results = table({'RRT*'; 'Informed RRT*'; 'Tube RRT*'; 'Fuzzy Adaptive RRT*N'}, ...
                        [rrt_star_avg.avg_path_length; informed_rrt_star_avg.avg_path_length; ...
                         tube_rrt_star_avg.avg_path_length; fuzzy_adaptive_rrt_n_avg.avg_path_length], ...
                        [rrt_star_avg.avg_time; informed_rrt_star_avg.avg_time; ...
                         tube_rrt_star_avg.avg_time; fuzzy_adaptive_rrt_n_avg.avg_time], ...
                        'VariableNames', {'Algorithm', 'AvgPathLength', 'AvgTime'});
    
    % 显示平均结果
    disp(avg_results);
    
    % 绘制比较图
    figure;
    subplot(1, 2, 1);
    bar(categorical(avg_results.Algorithm), avg_results.AvgPathLength);
    title('Average Path Length Comparison');
    xlabel('Algorithm');
    ylabel('Average Path Length');
    
    subplot(1, 2, 2);
    bar(categorical(avg_results.Algorithm), avg_results.AvgTime);
    title('Average Time Comparison');
    xlabel('Algorithm');
    ylabel('Average Time');
end