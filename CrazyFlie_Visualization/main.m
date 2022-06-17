%%% https://github.com/inkyusa/SE3_TRJ_plot

close all
clear
data = load("tf_demo.csv");
L_length = length(data);

img_x = data(:,1);
img_y = data(:,2);
img_z = data(:,3);

pose = struct('x', data(:,1), 'y', data(:,2), 'z', data(:,3));
qu = struct('w', data(:, 7), 'x', data(:, 4), 'y', data(:, 5), 'z', data(:, 6));

L = 60;
scrsz = get(0,'ScreenSize');

fig=figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
title_handle = title('Crazyflie Trajectory Visualization');
itv=10;
rotation_spd=0.5;
%delay=0.0001;
az=15;
el=64;
view(az,el);
tx = [L,0.0,0.0];
ty = [0.0,L,0.0];
tz = [0.0,0.0,L];

grid on;
xlabel('x', 'fontsize',16);
ylabel('y', 'fontsize',16);
zlabel('z', 'fontsize',16);

count = 0;
for i = 1:itv:L_length
    R = qtor([qu.w, qu.x, qu.y, qu.z]);
    t_x_new = R*tx';
    t_y_new = R*ty';
    t_z_new = R*tz';

    origin=[pose.x(i),pose.y(i),pose.z(i)];
    tx_vec(1,1:3) = origin;
    tx_vec(2,:) = t_x_new + origin';
    ty_vec(1,1:3) = origin;
    ty_vec(2,:) = t_y_new + origin';
    tz_vec(1,1:3) = origin;
    tz_vec(2,:) = t_z_new + origin';
    hold on;

    p1=plot3(tx_vec(:,1), tx_vec(:,2), tx_vec(:,3));
    set(p1,'Color','Green','LineWidth',1);
    p1=plot3(ty_vec(:,1), ty_vec(:,2), ty_vec(:,3));
    set(p1,'Color','Blue','LineWidth',1);
    p1=plot3(tz_vec(:,1), tz_vec(:,2), tz_vec(:,3));
    set(p1,'Color','Red','LineWidth',1);
    plot3(img_x, img_y, img_z, 'b-', 'linewidth', 1.5);

    perc = count*itv/L_length*100;
    set(title_handle,'String',['Process = ',num2str(perc),'%'],'fontsize',16);
    count=count+1;   
    az=az+rotation_spd;
    view(az,el);
    drawnow;
    f = getframe(fig);

end

