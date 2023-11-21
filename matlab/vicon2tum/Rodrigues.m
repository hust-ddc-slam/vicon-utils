
% Convert rotation vector to 3x3 rotation matrix

function R = Rodrigues(rvec)
    [row, col] = size(rvec);
    assert(row == 3);     % must input 3*1 vector
    theta=norm(rvec);
    rvec=rvec./theta;
    I=eye(3);
    K=[0 -rvec(3) rvec(2);
         rvec(3)  0  -rvec(1);
         -rvec(2) rvec(1) 0];
    R1 = cos(theta)*I + (1-cos(theta))*rvec*rvec' + sin(theta)*K;
	% R2 = I+sin(theta)*K + (1-cos(theta))*K*K;		R1=R2;
	R = R1;
return 
