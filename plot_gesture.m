function plot_gesture(gesture)
hold off
plot(gesture.X_positions,gesture.Y_positions,'LineWidth',3)
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