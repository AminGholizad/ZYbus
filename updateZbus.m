function Zn = updateZbus(Z,i,j,z)
%updateZbus adds a new line to an existing Zbus
%   Zn = updateZbus(Z,i,j,z)
%   Zn is the new Zbus
%   Z is the old Zbus
%   i,j are the nodes the the line is connecting
%   z is the impedance of the line
if i > length(Z) || j > length(Z) %add the new bus
    if i == 0 || j == 0
        Zn = [Z, zeros(length(Z),1);zeros(1,length(Z)), z];
    else
        if i>length(Z)
            Zn = [Z Z(:,j);Z(j,:) Z(j,j)+z];
        else
            Zn = [Z Z(:,i);Z(i,:) Z(i,i)+z];
        end
    end
else %add new link to the existing buses
    if i == 0 || j == 0
        if i == 0
            y=1./(z+Z(j,j));
            Zn=Z-Z(:,j)*y*Z(j,:);
        else
            y=1./(z+Z(i,i));
            Zn=Z-Z(:,i)*y*Z(i,:);
        end
    else
        a=Z(:,i)-Z(:,j);
        b=Z(i,:)-Z(j,:);
        y=1./(z+Z(i,i)-2*Z(i,j)+Z(j,j));
        Zn=Z-y*a*b;
    end
end
