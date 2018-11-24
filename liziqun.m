a=[95 4 60 32 23 72 80 62 65 46];%物品的体积
c=[55 10 47 5 4 50 8 61 85 87];%物品的价值
b=269;%背包的重量限制
%
%
%初始化程序:
Dim=10;%粒子的维数
xSize=20;%种群数
MaxIt=30;%最大迭代次数
c1=0.7;
c2=0.7;%定义加速因子
w=0.8;%定义惯性因子
%
A=repmat(a,xSize,1);%将a扩展成一个30*10的矩阵
C=repmat(c,xSize,1);%将c扩展成一个30*10的矩阵
x=round(rand(xSize,Dim));%随机取一个30*10的0/1矩阵作为粒子的初始位置
v=rand(xSize,Dim);%粒子的初始速度
xbest=zeros(xSize,Dim);%单个粒子的初始最佳位置
fxbest=zeros(xSize,1);%xbest的适应度
gbest=zeros(1,Dim);%粒子群的初始最佳位置
fgbest=0;%gbest的适应度
%
%
%粒子群最优位置和单个粒子最优位置的选定
%迭代循环算法:
iter=0;
while iter<MaxIt
iter=iter+1;
fx=sum((C.*x)');%计算粒子群的适应度,即背包内物品的价值
sx=sum((A.*x)');%限制函数,背包内物品的体积
for i=1:xSize
if sx(i)>269
fx(i)=0;%当被包内物品的体积超过限制时,将期适应度设置为1
end
end
for i=1:xSize
if fxbest(i)<fx(i)
fxbest(i)=fx(i);
xbest(i,:)=x(i,:);
end%当粒子的适应度fx(i)大于其最佳适应度时fxbest(i),用其替代原来粒子的最佳适应度,并记下此解
end
if fgbest<max(fxbest)
[fgbest,g]=max(fxbest);
gbest=xbest(g,:);%当存在粒子的最佳适应度fxbest(i)大于种群的最佳适应度时,用其替代原来种群的最佳适应度,并记下此解
end
for i=1:xSize
if x(i,:)==gbest
x(i,:)=round(rand(1,Dim));%为防止算法陷入局部最优，若某个粒子的位置等于种群最佳位置，将对该粒子的位置重新初始化赋值
end
end
R1=rand(xSize,Dim);
R2=rand(xSize,Dim);
v=v*w+c1*R1.*(xbest-x)+c2*R2.*(repmat(gbest,xSize,1)-x);%用速度迭代公式产生新的速度
x=x+v;%更新粒子群的位置
for i=1:xSize
for j=1:Dim
if x(i,j)<0.5
x(i,j)=0;
else x(i,j)=1;
end
end
end%由于粒子的位置只有(0,1)两种状态,此处以0.5为分界点对函数值进行调整
end
fgbest
sgbest=sum((a.*gbest)')
