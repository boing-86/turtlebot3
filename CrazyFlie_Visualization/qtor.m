%%% https://github.com/PyojinKim/ios_logger/blob/master/Visualization/q2r.m

function R = qtor( q )

%   OUTPUT:
%   R = rotation matrix (3x3) defined as [inertial frame] = R * [body frame] (R = R_gb)
%
%   INPUT:
%   quatVector: quaternion vector composed of [qw qx qy qz]

% quaternion to dcm

q = q/norm(q);


a = q(1);
b = q(2);
c = q(3);
d = q(4);

R=[ a*a+b*b-c*c-d*d,     2*(b*c-a*d),     2*(b*d+a*c);
    2*(b*c+a*d), a*a-b*b+c*c-d*d,     2*(c*d-a*b);
    2*(b*d-a*c),     2*(c*d+a*b), a*a-b*b-c*c+d*d; ];

end
