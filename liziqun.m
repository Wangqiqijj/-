a=[95 4 60 32 23 72 80 62 65 46];%��Ʒ�����
c=[55 10 47 5 4 50 8 61 85 87];%��Ʒ�ļ�ֵ
b=269;%��������������
%
%
%��ʼ������:
Dim=10;%���ӵ�ά��
xSize=20;%��Ⱥ��
MaxIt=30;%����������
c1=0.7;
c2=0.7;%�����������
w=0.8;%�����������
%
A=repmat(a,xSize,1);%��a��չ��һ��30*10�ľ���
C=repmat(c,xSize,1);%��c��չ��һ��30*10�ľ���
x=round(rand(xSize,Dim));%���ȡһ��30*10��0/1������Ϊ���ӵĳ�ʼλ��
v=rand(xSize,Dim);%���ӵĳ�ʼ�ٶ�
xbest=zeros(xSize,Dim);%�������ӵĳ�ʼ���λ��
fxbest=zeros(xSize,1);%xbest����Ӧ��
gbest=zeros(1,Dim);%����Ⱥ�ĳ�ʼ���λ��
fgbest=0;%gbest����Ӧ��
%
%
%����Ⱥ����λ�ú͵�����������λ�õ�ѡ��
%����ѭ���㷨:
iter=0;
while iter<MaxIt
iter=iter+1;
fx=sum((C.*x)');%��������Ⱥ����Ӧ��,����������Ʒ�ļ�ֵ
sx=sum((A.*x)');%���ƺ���,��������Ʒ�����
for i=1:xSize
if sx(i)>269
fx(i)=0;%����������Ʒ�������������ʱ,������Ӧ������Ϊ1
end
end
for i=1:xSize
if fxbest(i)<fx(i)
fxbest(i)=fx(i);
xbest(i,:)=x(i,:);
end%�����ӵ���Ӧ��fx(i)�����������Ӧ��ʱfxbest(i),�������ԭ�����ӵ������Ӧ��,�����´˽�
end
if fgbest<max(fxbest)
[fgbest,g]=max(fxbest);
gbest=xbest(g,:);%���������ӵ������Ӧ��fxbest(i)������Ⱥ�������Ӧ��ʱ,�������ԭ����Ⱥ�������Ӧ��,�����´˽�
end
for i=1:xSize
if x(i,:)==gbest
x(i,:)=round(rand(1,Dim));%Ϊ��ֹ�㷨����ֲ����ţ���ĳ�����ӵ�λ�õ�����Ⱥ���λ�ã����Ը����ӵ�λ�����³�ʼ����ֵ
end
end
R1=rand(xSize,Dim);
R2=rand(xSize,Dim);
v=v*w+c1*R1.*(xbest-x)+c2*R2.*(repmat(gbest,xSize,1)-x);%���ٶȵ�����ʽ�����µ��ٶ�
x=x+v;%��������Ⱥ��λ��
for i=1:xSize
for j=1:Dim
if x(i,j)<0.5
x(i,j)=0;
else x(i,j)=1;
end
end
end%�������ӵ�λ��ֻ��(0,1)����״̬,�˴���0.5Ϊ�ֽ��Ժ���ֵ���е���
end
fgbest
sgbest=sum((a.*gbest)')
