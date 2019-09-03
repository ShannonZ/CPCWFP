function R = trotdeg(az,phi)
% Rotate by a angle phi, 
%        about a transverse axis defined by y=x*tan(az)
az = deg2rad(az);
phi = deg2rad(-phi);

R = [1-2*sin(az)^2*sin(phi/2)^2, sin(2*az)*sin(phi/2)^2,  -sin(phi)*sin(az);
     sin(2*az)*sin(phi/2)^2, 1-2*cos(az)^2*sin(phi/2)^2, sin(phi)*cos(az);
     sin(phi)*sin(az), -sin(phi)*cos(az), cos(phi)];
 
 R(abs(R)<10*eps) = 0;