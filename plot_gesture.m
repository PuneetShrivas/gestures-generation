function plot_gesture(gesture)
hold off
% plot(gesture.X_positions,gesture.Y_positions,'LineWidth',3)
ax=axes;
% gesture.pressure_variation=[1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1];
hold(ax, 'on')
for i=1:length(gesture.X_positions)-1
    p=plot(ax,gesture.X_positions(i:i+1),gesture.Y_positions(i:i+1),'LineWidth',2,'Color','#84b8e7');
    p.LineJoin="round";
    if gesture.pressure_variation(i)==1
        p.LineWidth=4;
        p.Color='#3d85c6';
    end
end
hold(ax,'off')
xlim([1 9])
ylim([1 21])
set(gca, 'YDir','reverse')
grid on
pbaspect([1 1 1])
daspect([1 1 1])
disp("angular_vel")
disp(gesture.angular_vel)
disp("t_render")
disp(gesture.t_render)
disp("data_density")
disp(gesture.data_density)
end