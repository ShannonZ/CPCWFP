T1 = 500;
T2 = 100;
df = 10;
DW = 0.01;

NE = 2000;

Tp = 0.3;

Rcp = trotdeg(0,90);    % cp P90 
Rx = trotdeg(0,90);     % x  P90 
R_x = trotdeg(180,90);  % -x P90 
[A,B] = freeprecess(DW,T1,T2,df);

TD = floor((NE*2+0.5)*Tp/DW);
tau = Tp/2;
N1 = tau/DW;
N2 = Tp/DW;

M = zeros(3,TD);
m0 = [0;0;1];
Mflip = Rcp*m0;
M(:,1) = A*Mflip+B;
for k=2:N1
    M(:,k) = A*M(:,k-1)+B;
end

peak = zeros(2*NE,1,'like',1i);
for c = 1:NE
    cur = N1+1+(c-1)*N2*2;
    M(:,cur)=A*Rx*M(:,cur-1)+B;
    for k=1:N2-1
        M(:,cur+k) = A*M(:,cur+k-1)+B;
    end
    peak(2*(c-1)+1) = M(1,cur+round(k/2))+1i*M(2,cur+round(k/2));
    
    cur = cur+k+1;
    M(:,cur) = A*R_x*M(:,cur-1)+B;
    for k=1:N2-1
        M(:,cur+k) = A*M(:,cur+k-1)+B;
    end
    peak(2*c) = M(1,cur+round(k/2))+1i*M(2,cur+round(k/2));
end

time = (0:TD)*DW;
data = M(1,:)+1i*M(2,:);
plot(time,real(data),'r',time,imag(data),'b',time,M(3,:),'g--')

figure,plot(imag(peak))