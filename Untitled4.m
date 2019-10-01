M = 3;   % ORDER
L = 3;   % DEGREE
RES = [55 55];
THETA = linspace(0,2*pi,RES(1));
PHI = linspace(0,  pi,RES(2));
[THETA,PHI]= meshgrid(THETA,PHI);
LMN=legendre(L,cos(PHI));
if L~=0
  LMN=squeeze(LMN(M+1,:,:));
end
a = ((2*L+1)/(4*pi));
b = factorial(L-M)/factorial(L+M);
C = sqrt(a*b);
YMN = C*LMN.*exp(1i*M*THETA);
[XM,YM,ZM]=sph2cart(THETA,PHI-pi/2,abs(YMN).^2);

figure;
surf(XM,YM,ZM); 
axis equal off;
light;
lighting gouraud 
camzoom(1.2);