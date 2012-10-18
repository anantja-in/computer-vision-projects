i=imread('tiles.jpg'); 
[x,y,in]=impixel(i) %selection of 4 corners of a square% 

a=[x(1) y(1) 1]; 
b=[x(2) y(2) 1]; %cross product of two points give the a b c parametres of line%
c=[x(4) y(4) 1];
d=[x(3) y(3) 1];

lh1=cross(a,b);
lh2=cross(c,d);
lv1=cross(a,c);
lv2=cross(b,d);
[g o]=size(i)
g=1:g

k=(-lh1(3)-lh1(2)*g)/lh1(1);
k1=(-lh2(3)-lh2(2)*g)/lh2(1);
k3=(-lv1(3)-lv1(2)*g)/lv1(1);
k4=(-lv2(3)-lv2(2)*g)/lv2(1);
figure,imshow(i); hold on ; line(k,g); line(k1,g);line(k3,g);line(k4,g);hold off

vph=cross(lh1,lh2);
vpv=cross(lv1,lv2);
lvan=cross(vph,vpv); %cross product of two points give the a b c parametres of line%
lvani=lvan/lvan(3);
H=[1 0 0; 0 1 0 ;lvani];
hinv=[1 0 -lvani(1) ; 0 1 -lvani(2); 0 0 1];
jkl=rgb2gray(i);
[m,n]=size(jkl);

d=H*[n;m;1];%coordinates of the edges of image
e=H*[1;m;1];
f=H*[n;1;1];
d=d/d(3);
e=e/e(3);
f=f/f(3);
hor=max([d(1),e(1),f(1)]);
ver=max([d(2),e(2),f(2)]);
image=zeros(ver,hor);

for i1=1:m
for j1=1:n
d=H*[j1;i1;1];
d=d/d(3);
image(ceil(d(2)),ceil(d(1)))=jkl(i1,j1);
end
end

image=uint8(image);
figure, imshow(image);
figure,imshow(image); hold on ; line(k,g); line(k1,g);line(k3,g);line(k4,g);
hold off

direct rect