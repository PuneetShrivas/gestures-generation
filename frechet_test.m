
%Extracting gesture cells A & B from worksheet
result = GetGoogleSpreadsheet('1m2zBMtQ5n1pnKJZ5ZDGf6NTqNyQY7dyw-C5n1Mx8jP8');
cell_A = result(3:22,2:9);
mat_A = str2double(cell_A);
cell_B = result(3:22,14:21);
mat_B = str2double(cell_B);
cell_C = result(3:22,26:33);
mat_C = str2double(cell_C);
save('matA.mat','mat_A');
save('matB.mat','mat_B');
save('matC.mat','mat_C');
% curve A
end_curve = 0; i=1;
X1 =[];
Y1 =[];
while end_curve==0
    [row,col]=find(mat_A==i);
    if isempty(row) && isempty(col)
        end_curve=1;
        disp('curve_A end')
        break;
    end
    X1(end+1)=col;
    Y1(end+1)=row;
    i=i+1;
end    

% curve B
end_curve = 0; j=1;
X2 =[];
Y2 =[];
while end_curve==0
    [row,col]=find(mat_B==j);
    if isempty(row) && isempty(col)
        end_curve=1;
        disp('curve_B end')
        break;
    end
    X2(end+1)=col;
    Y2(end+1)=row;
    j=j+1;
end   

% curve C
end_curve = 0; k=1;
X3 =[];
Y3 =[];
while end_curve==0
    [row,col]=find(mat_C==k);
    if isempty(row) && isempty(col)
        end_curve=1;
        disp('curve_C end')
        break;
    end
    X3(end+1)=col;
    Y3(end+1)=row;
    k=k+1;
end   
curve_one = [X1.' Y1.'];
save('curve_one.mat','curve_one');
% save('Y1.mat','Y1');


% %curve 1
% t1=0:1:50;
% X1=(2*cos(t1/5)+3-t1.^2/200)/2;
% Y1=2*sin(t1/5)+3;
% 
% %curve 2
% X2=(2*cos(t1/4)+2-t1.^2/200)/2;
% Y2=2*sin(t1/5)+3;
% 
% %curve 3
% X3=(2*cos(t1/4)+2-t1.^2/200)/2;
% Y3=2*sin(t1/4+2)+3;


f12=frechet(X1',Y1',X2',Y2');
f13=frechet(X1',Y1',X3',Y3');
f23=frechet(X2',Y2',X3',Y3');
f11=frechet(X1',Y1',X1',Y1');
f22=frechet(X2',Y2',X2',Y2');
f33=frechet(X3',Y3',X3',Y3');
disp([f12 f13 f23])

figure;
% subplot(2,1,1)
hold on
plot(X1,Y1,'r','linewidth',2)
plot(X2,Y2,'g','linewidth',2)
plot(X3,Y3,'b','linewidth',2)
set(gca, 'YDir','reverse')
legend('curve 1','curve 2','curve 3','location','eastoutside')
xlabel('X')
ylabel('Y')
axis equal tight
box on
title(['Three gestures to compare'])
legend

box off
% subplot(2,1,2)
imagesc([[f11,f12,f13];[f12,f22,f23];[f13,f23,f33]])
xlabel('curve')
ylabel('curve')
cb1=colorbar('peer',gca);
set(get(cb1,'Ylabel'),'String','Frechet Distance')
axis equal tight
