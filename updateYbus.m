function Yn = updateYbus(Y,i,j,z)
%updateYbus adds a new line to an existing Ybus
%   Yn = updateYbus(Y,i,j,z)
%   Yn is the new Ybus
%   Y is the old Ybus
%   i,j are the nodes the the line is connecting
%   z is the impedance of the line

Yn = Y;
if i == 0 || j==0
    if i==0
        Yn(j,j) = Y(j,j) + 1./z;
    else
        Yn(i,i) = Y(i,i) + 1./z;
    end
else
    y = 1./z;
    Yn(i,j) = Y(i,j) - y;
    Yn(j,i) = Y(j,i) - y;
    Yn(i,i) = Y(i,i) + y;
    Yn(j,j) = Y(j,j) + y;
end
end