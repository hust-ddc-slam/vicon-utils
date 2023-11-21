
% This code try to plot vicon raw data and a slam's result to estimate initial time diff.

clc;clear;close all;
% Load data from text files

gt_data = load('../../data/gt/phone-gt.txt');
method_data = load('../../data/slam-result/phone/pointlio.txt');

% remove t0 data.
t0 = gt_data(1,1);
gt_data(:,1) = gt_data(:,1) - t0;
method_data(:,1) = method_data(:,1)-t0;

% Assuming the columns are: ts, x, y, z, qx, qy, qz, qw
% Extract translation components
gt_translation = gt_data(:, 2:4);
method_translation = method_data(:, 2:4);

% Extract quaternion components and convert them to Euler angles (roll, pitch, yaw)
gt_quat = gt_data(:, 5:8);
method_quat = method_data(:, 5:8);

% You may need to write or find a quaternion to Euler conversion function
% The function might look like this: euler = quat2euler(quat)
gt_euler = quat2eul(gt_quat);
method_euler = quat2eul(method_quat);

% Plot translation components
figure(1);
subplot(3,1,1);
plot(gt_data(:,1), gt_translation(:,1), 'r', method_data(:,1), method_translation(:,1), 'b');
title('X Translation');
legend('GT', 'Method');

subplot(3,1,2);
plot(gt_data(:,1), gt_translation(:,2), 'r', method_data(:,1), method_translation(:,2), 'b');
title('Y Translation');
legend('GT', 'Method');

subplot(3,1,3);
plot(gt_data(:,1), gt_translation(:,3), 'r', method_data(:,1), method_translation(:,3), 'b');
title('Z Translation');
legend('GT', 'Method');

% Plot rotation components
figure(2);
subplot(3,1,1);
plot(gt_data(:,1), gt_euler(:,1), 'r', method_data(:,1), method_euler(:,1), 'b');
title('Roll');
legend('GT', 'Method');

subplot(3,1,2);
plot(gt_data(:,1), gt_euler(:,2), 'r', method_data(:,1), method_euler(:,2), 'b');
title('Pitch');
legend('GT', 'Method');

subplot(3,1,3);
plot(gt_data(:,1), gt_euler(:,3), 'r', method_data(:,1), method_euler(:,3), 'b');
title('Yaw');
legend('GT', 'Method');
