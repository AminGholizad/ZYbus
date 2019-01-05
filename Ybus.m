function [Y,N] = Ybus(branches, shunts)
%Ybus reates the Ybus matrix
%	[Y, N] = Ybus(branches, shunts)
%   Y is Ybus
%   N is node names
%   branches are lines connecting 2 nodes
%   shunts are lines connecting nodes to ground(ref)

N=unique(branches(:,1:2));
Y=zeros(length(N));
for i=1:length(N)
    y1 = 0;
    for branch = branches.'
        if branch(1)==i
            j = branch(2);
            y = 1./branch(3);
            y1 = y1 + y;
            Y(i,j) = Y(i,j) - y;
        elseif branch(2)==i
            j = branch(1);
            y = 1./branch(3);
            y1 = y1 + y;
            Y(i,j) = Y(i,j) - y;
        end
    end
    Y(i,i)= y1 + sum(1./shunts(shunts(:,1)==i,2));
end

