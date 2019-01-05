function [Z,N] = Zbus(branches, shunts)
%Zbus creates the Zbus matrix with direct method
%   [Z,N] = Zbus(branches, shunts):
%   Z is Zbus
%   N is node names
%   branches are lines connecting 2 nodes
%   shunts are lines connecting nodes to ground(ref)

%% new bus to ref
N = shunts(:,1);
Z = zeros(numel(N));
for i = 1:length(shunts)
    Z(i,i) = shunts(i,2);
end
%% new bus to existing
all_nodes = unique(branches(:,1:2));
last_node=length(N);
added_branches=[];
while last_node < length(all_nodes)
    for i = 1:length(branches)
        if ~ismember(i,added_branches)
            if ismember(branches(i,1),N) && ~ismember(branches(i,2),N)
                added_branches(end+1) = i;
                j=find(branches(i,1)==N,1,'first');
                last_node=last_node+1;
                N(last_node)=branches(i,2);
                Z = [Z Z(:,j);Z(j,:) Z(j,j)+branches(i,3)];
            elseif ismember(branches(i,2),N) && ~ismember(branches(i,1),N)
                added_branches(end+1) = i;
                j=find(branches(i,2)==N,1,'first');
                last_node=last_node+1;
                N(last_node)=branches(i,1);
                Z = [Z Z(:,j);Z(j,:) Z(j,j)+branches(i,3)];
            end
        end
    end
end
%% existing to existing
branches(added_branches,:)=[];
for branch = branches.'
    i = find(branch(1)==N,1,'first');
    j = find(branch(2)==N,1,'first');
    a=Z(:,i)-Z(:,j);
    b=Z(i,:)-Z(j,:);
    y=1./(branch(3)+Z(i,i)-2*Z(i,j)+Z(j,j));
    Z=Z-y*a*b;
end
%% sort nodes
for i =1:length(N)
    if i ~= N(i)
        j=N(i);
        N([i,j])=N([j,i]);
        Z([i,j],:)=Z([j,i],:);
        Z(:,[i,j])=Z(:,[j,i]);
    end
end