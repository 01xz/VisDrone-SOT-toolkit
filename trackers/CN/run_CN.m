
% run_tracker.m

function results=run_CN(seq, rp, bSaveImage)
close all;
% clear all;

%parameters according to the paper
params.padding = 1.0;         			   % extra area surrounding the target
params.output_sigma_factor = 1/16;		   % spatial bandwidth (proportional to target)
params.sigma = 0.2;         			   % gaussian kernel bandwidth
params.lambda = 1e-2;					   % regularization (denoted "lambda" in the paper)
params.learning_rate = 0.075;			   % learning rate for appearance model update scheme (denoted "gamma" in the paper)
params.compression_learning_rate = 0.15;   % learning rate for the adaptive dimensionality reduction (denoted "mu" in the paper)
params.non_compressed_features = {'gray'}; % features that are not compressed, a cell with strings (possible choices: 'gray', 'cn')
params.compressed_features = {'cn'};       % features that are compressed, a cell with strings (possible choices: 'gray', 'cn')
params.num_compressed_dim = 2;             % the dimensionality of the compressed features

params.visualization = 0;

%ask the user for the video
% video_path = choose_video(base_path);
% if isempty(video_path), return, end  %user cancelled
% [img_files, pos, target_sz, ground_truth, video_path] = ...
% 	load_video_info(video_path);
params.init_pos = seq.init_rect(1,[2,1]) + floor(seq.init_rect(1,[4,3])/2);
params.wsize = floor(seq.init_rect(1,[4,3]));
params.img_files = seq.s_frames;
params.video_path = [];

[positions, fps] = color_tracker(params);
rects=positions;
disp(['fps: ' num2str(fps)])
results.type = 'rect';
results.res = rects;
results.fps = fps;
% % calculate precisions
% [distance_precision, PASCAL_precision, average_center_location_error] = ...
%     compute_performance_measures(positions, ground_truth);

% fprintf('Center Location Error: %.3g pixels\nDistance Precision: %.3g %%\nOverlap Precision: %.3g %%\nSpeed: %.3g fps\n', ...
%     average_center_location_error, 100*distance_precision, 100*PASCAL_precision, fps);
end
