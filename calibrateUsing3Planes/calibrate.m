% Calibration using three chessboard planes

im = imread('n1.JPG');
imshow(im);

%Plane 1
bl = [825 667 1];
br = [1212 745 1];
tl = [820 225 1];
tr = [1227 268 1];

x2 = transpose([bl;br;tl;tr]);
x1 = transpose([1 1 1; 5 1 1; 1 5 1; 5 5 1]);

Hxy = homography2d(x1,x2);

%Plane 2
bl = [346 791 1];
br = [668 674 1];
tl = [323 286 1];
tr = [659 227 1];

x2 = transpose([bl;br;tl;tr]);
x1 = transpose([5 1 1; 1 1 1; 5 5 1; 1 5 1]);

Hyz = homography2d(x1,x2);

%Plane 3
bl = [445 923 1];
br = [863 1042 1];
tl = [759 801 1];
tr = [1149 891 1];

x2 = transpose([bl;br;tl;tr]);
x1 = transpose([5 1 1; 5 5 1; 1 1 1; 1 5 1]);
Hzx = homography2d(x1,x2);

cp1 = Hxy*transpose([1,i,0]); %cp1=cp1./cp1(3);
cp2 = Hxy*transpose([1,-i,0]); %cp2=cp2./cp2(3);
cp3 = Hyz*transpose([1,i,0]); %cp3=cp3./cp3(3);
cp4 = Hyz*transpose([1,-i,0]); %cp4=cp4./cp4(3);
cp5 = Hzx*transpose([1,i,0]); %cp5=cp5./cp5(3);
cp6 = Hzx*transpose([1,-i,0]); %cp6=cp6./cp6(3);

A1 = [cp1(1)*(cp1(1)) cp1(1)*(cp1(2)) cp1(2)*cp1(2) cp1(1)*(cp1(3)) cp1(2)*(cp1(3)) cp1(3)*(cp1(3))];
A2 = [cp2(1)*(cp2(1)) cp2(1)*(cp2(2)) cp2(2)*cp2(2) cp2(1)*(cp2(3)) cp2(2)*(cp2(3)) cp2(3)*(cp2(3))];
A3 = [cp3(1)*(cp3(1)) cp3(1)*(cp3(2)) cp3(2)*cp3(2) cp3(1)*(cp3(3)) cp3(2)*(cp3(3)) cp3(3)*(cp3(3))];
A4 = [cp4(1)*(cp4(1)) cp4(1)*(cp4(2)) cp4(2)*cp4(2) cp4(1)*(cp4(3)) cp4(2)*(cp4(3)) cp4(3)*(cp4(3))];
A5 = [cp5(1)*(cp5(1)) cp5(1)*(cp5(2)) cp5(2)*cp5(2) cp5(1)*(cp5(3)) cp5(2)*(cp5(3)) cp5(3)*(cp5(3))];
A6 = [cp6(1)*(cp6(1)) cp6(1)*(cp6(2)) cp6(2)*cp6(2) cp6(1)*(cp6(3)) cp6(2)*(cp6(3)) cp6(3)*(cp6(3))];

A = [A1; A2; A3; A4; A5; A6];
[U,D,V] = svd(A); % 'Economy' decomposition for speed

w = [0 0 0; 0 0 0; 0 0 0];
w(1,1) = V(1,6)/2;
w(1,2) = V(2,6)/2;
w(1,3) = V(4,6)/2;
w(2,2) = V(3,6)/2;
w(3,3) = V(6,6)/2;
w(2,3) = V(5,6)/2;

w = w+transpose(w);
w = inv(w)

c = chol(real(w));
c = c./c(3,3)



