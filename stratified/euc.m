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

%direct rect


i=imread('tiles.jpg');
[x,y,in]=impixel(i) %considering a square all sides are 1 2 3 4 in clock wise direction%
a=[x(1) y(1) 1];
b=[x(2) y(2) 1];
c=[x(4) y(4) 1];
d=[x(3) y(3) 1];
e=[x(5) y(5) 1];
f=[x(6) y(6) 1];
g=[x(8) y(8) 1];
h=[x(7) y(7) 1];
l1=cross(a,b);
m1=cross(a,c);
l2=cross(a,d);
m2=cross(b,c);
l3=cross(b,d);
m3=cross(c,d);
l4=cross(e,f);
m4=cross(e,g);
l5=cross(f,h);
m5=cross(g,h);
%la to lclb to ld %
A1 = [m1(1)*l1(1) (m1(1)*l1(2)+m1(2)*l1(1))/2 m1(2)*l1(2) (m1(1)*l1(3)+m1(3)*l1(1))/2 (m1(2)*l1(3)+m1(3)*l1(2))/2 m1(3)*l1(3)];
A2 = [m2(1)*l2(1) (m2(1)*l2(2)+m2(2)*l2(1))/2 m2(2)*l2(2) (m2(1)*l2(3)+m2(3)*l2(1))/2 (m2(2)*l2(3)+m2(3)*l2(2))/2 m2(3)*l2(3)];
A3 = [m3(1)*l3(1) (m3(1)*l3(2)+m3(2)*l3(1))/2 m3(2)*l3(2) (m3(1)*l3(3)+m3(3)*l3(1))/2 (m3(2)*l3(3)+m3(3)*l3(2))/2 m3(3)*l3(3)];
A4 = [m4(1)*l4(1) (m4(1)*l4(2)+m4(2)*l4(1))/2 m4(2)*l4(2) (m4(1)*l4(3)+m4(3)*l4(1))/2 (m4(2)*l4(3)+m4(3)*l4(2))/2 m4(3)*l4(3)];
A5 = [m5(1)*l5(1) (m5(1)*l5(2)+m5(2)*l5(1))/2 m5(2)*l5(2) (m5(1)*l5(3)+m5(3)*l5(1))/2 (m5(2)*l5(3)+m5(3)*l5(2))/2 m5(3)*l5(3)];


a = [A1; A2; A3; A4; A5];

ss=null(a); 
c=[ss(1) ss(2)/2 ss(4)/2 ss(2)/2 ss(3) ss(5)/2 ss(4)/2 ss(5)/2 ss(6)]
H=inv(H);
jkl=rgb2gray(i);
[m,n]=size(jkl);
w=H*[n;m;1];%coorwinatrs ot thr rwgrs ot imagr
r=H*[1;m;1];
t=H*[n;1;1];
v=H*[1;1;1]
w=w/w(3);
r=r/r(3);
t=t/t(3);
v=v/v(3);
minx=min([w(1),r(1),t(1),v(1)]);
miny=min([w(2),r(2),t(2),v(2)]);
maxx=max([w(1),r(1),t(1),v(1)]);
maxy=max([w(2),r(2),t(2),v(2)]);
hor=maxx-minx
vrr=maxy-miny
image=zeros(vrr,hor);
for i1=1:m,
    for j1=1:n,
        d=H*[j1;i1;1];
        d=d/d(3);
        if ceil(d(1)-2*minx)>0,
            if ceil(d(2)-2*miny)>0, 
                image(ceil(d(2)-2*miny),ceil(d(1)-2*minx))=jkl(i1,j1);
            end
        end
    end
end
figure
imshow(image)
%imagr=uint8(image);
%imwritr(imagr,'c:\2','jpg');
