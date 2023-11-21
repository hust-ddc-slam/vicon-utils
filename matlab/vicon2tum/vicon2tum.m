
clc;clear;close all;

input_filename = '../../data/raw-vicon/phone-vicon.csv';
output_filename = '../../data/gt/phone-gt.txt';
Vicon_Frequency = 200;

t0 = 1700132524.80066 - 4.93;	% first vicon time in UNIX. Need to synchronize with Lidar

ex_T = [1.8, 1.0, -0.26];		% extrinsics from VICON's body frame to odom frame (if needed)

data = readmatrix(input_filename, 'NumHeaderLines', 5); % 跳过前5行header和空行
N = size(data, 1);

% Too many poses from VICON may lead to alignment issues, so just downsamle.
Ds_step = 20;
Ds_N = floor(N/Ds_step);
Ds_Frequency = Vicon_Frequency / Ds_step;

output = zeros(Ds_N, 8);
for s = 1:Ds_N
	i = s * Ds_step;
    ts = data(i, 1) / Vicon_Frequency;		% TODO: 同步后第一个的ts应该看怎么处理合适。
    tx = data(i, 6)/1000;
    ty = data(i, 7)/1000;
    tz = data(i, 8)/1000;

    r = data(i, 3:5)';
	r = deg2rad(r);
	R = Helical2Rotation(r, norm(r));
	q = rotm2quat(R);
	% quat: qw,qx,qy,qz
	% TUM formrat: ts x y z qx qy qz qw
    output(s, :) = [ts+t0, tx+ex_T(1), ty+ex_T(2), tz+ex_T(3), q(2:4), q(1)];
end

% 将输出数据保存到新的CSV文件
writematrix(output, output_filename, 'Delimiter', ' ');
disp("==> DONE. ");
