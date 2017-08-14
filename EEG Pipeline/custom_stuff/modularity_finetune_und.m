function [Ci Q]=modularity_finetune_und(W,Ci,gamma)
%MODULARITY_FINETUNE_UND        Refinement of optimal community structure and modularity
%
%   Ci     = modularity_finetune_und(W,Ci0);
%   [Ci Q] = modularity_finetune_und(W,Ci0,gamma);
%
%   The optimal community structure is a subdivision of the network into
%   nonoverlapping groups of nodes in a way that maximizes the number of
%   within-group edges, and minimizes the number of between-group edges. 
%   The modularity is a statistic that quantifies the degree to which the
%   network may be subdivided into such clearly delineated groups. 
%
%   This algorithm is inspired by the Kernighan-Lin fine-tuning algorithm
%   and is designed to refine a previously detected community structure.
%
%   Input:      W,      undirected (weighted or binary) connection matrix
%
%               Ci0,    initial community affiliation vector (optional)
%
%               gamma,  modularity resolution parameter (optional)
%                           gamma>1     detects smaller modules
%                           0<=gamma<1  detects larger modules
%                           gamma=1     (default) leads to the 'classic' modularity function
%
%
%   Output:     Ci,     refined community affiliation vector
%               Q,      modularity
%
%   Note: Ci and Q may vary from run to run, due to heuristics in the
%   algorithm. Consequently, it may be worth to compare multiple runs.
%
%   References:
%   Sun et al. (2008)  Europhysics Lett 86, 28004.
%
%
%   Mika Rubinov, U Cambridge, 2013

%   Modification History:
%   May 2013: Original


W=double(W);                                    %convert from logical
n=length(W);                                    %number of nodes
if ~exist('gamma','var')
    gamma = 1;
end
if ~exist('Ci','var')
    Ci = 1:n;
else
    [dum,dum,Ci] = unique(Ci(:).');             %align module indices
end

s=sum(W(:));                                    %weight of edges

Knm=zeros(n,n);                                 %node-to-module degree
for m=1:max(Ci)                                 %loop over modules
    Knm(:,m)=sum(W(:,Ci==m),2);
end
K=sum(Knm,2);                                   %node degree
Km=sum(Knm,1);                                  %module degree

flag=true;                                      %flag for within-hierarchy search
while flag;
    flag=false;
    
    for u=randperm(n)                           %loop over all nodes in random order
        ma = Ci(u);                             %current module of u
        dQ=(Knm(u,:)-Knm(u,ma)+W(u,u)) - gamma*K(u).*(Km-Km(ma)+K(u))/s;
        dQ(ma)=0;                               %(line above) algorithm condition
        
        [max_dQ mb] = max(dQ);                  %maximal increase in modularity and corresponding module
        if max_dQ>1e-10;                        %if maximal increase is positive
            flag=true;
            Ci(u) = mb;                         %reassign module
            
            Knm(:,mb)=Knm(:,mb)+W(:,u);         %change node-to-module degrees
            Knm(:,ma)=Knm(:,ma)-W(:,u);
            Km(mb)=Km(mb)+K(u);                 %change module degrees
            Km(ma)=Km(ma)-K(u);
        end
    end
end

[dum,dum,Ci]=unique(Ci);                        %module assignments

if nargin>1
    m=max(Ci);                                	%number of modules
    w=zeros(m);                                 %new weighted matrix
    for u=1:m
        for v=u:m
            wm=sum(sum(W(Ci==u,Ci==v)));       %pool weights of nodes in same module
            w(u,v)=wm;
            w(v,u)=wm;
        end
    end
    W=w;
    Q=trace(W)/s-gamma*sum(sum((W/s)^2));       %compute modularity
end
