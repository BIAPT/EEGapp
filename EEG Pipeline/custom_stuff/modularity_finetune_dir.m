function [Ci Q]=modularity_finetune_dir(W,Ci,gamma)
%MODULARITY_FINETUNE_DIR        Refinement of optimal community structure and modularity
%
%   Ci     = modularity_finetune_dir(W,Ci0);
%   [Ci Q] = modularity_finetune_dir(W,Ci0,gamma);
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
%   Input:      W,      directed (weighted or binary) connection matrix
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

Knm_o=zeros(n,n);                               %node-to-module out-degree
Knm_i=zeros(n,n);                               %node-to-module in-degree
for m=1:max(Ci)                                 %loop over modules
    Knm_o(:,m)=sum(W(:,Ci==m),2);
    Knm_i(:,m)=sum(W(Ci==m,:),1);
end
K_o=sum(Knm_o,2);                               %node out-degree
K_i=sum(Knm_i,2);                               %node out-degree
Km_o=sum(Knm_o,1);                              %module out-degree
Km_i=sum(Knm_i,1);                              %module out-degree

flag=true;                                      %flag for within-hierarchy search
while flag;
    flag=false;
    
    for u=randperm(n)                           %loop over all nodes in random order
        ma = Ci(u);                             %current module of u
        dQ_o=(Knm_o(u,:)-Knm_o(u,ma)+W(u,u)) - gamma*K_o(u).*(Km_i-Km_i(ma)+K_i(u))/s;
        dQ_i=(Knm_i(u,:)-Knm_i(u,ma)+W(u,u)) - gamma*K_i(u).*(Km_o-Km_o(ma)+K_o(u))/s;
        dQ = (dQ_o+dQ_i)/2;                     %algorithm condition
        dQ(ma)=0;
        
        [max_dQ mb] = max(dQ);                  %maximal increase in modularity and corresponding module
        if max_dQ>1e-10;                        %if maximal increase is positive
            flag=true;
            Ci(u) = mb;                         %reassign module
            
            Knm_o(:,mb)=Knm_o(:,mb)+W(u,:).';   %change node-to-module out-degrees
            Knm_o(:,ma)=Knm_o(:,ma)-W(u,:).';
            Knm_i(:,mb)=Knm_i(:,mb)+W(:,u);     %change node-to-module in-degrees
            Knm_i(:,ma)=Knm_i(:,ma)-W(:,u);
            Km_o(mb)=Km_o(mb)+K_o(u);           %change module out-degrees
            Km_o(ma)=Km_o(ma)-K_o(u);
            Km_i(mb)=Km_i(mb)+K_i(u);           %change module in-degrees
            Km_i(ma)=Km_i(ma)-K_i(u);
        end
    end
end

[dum,dum,Ci]=unique(Ci);                        %module assignments

if nargin>1
    m=max(Ci);                                  %new number of modules
    w=zeros(m);                                 %new weighted matrix
    for u=1:m
        for v=1:m
            w(u,v)=sum(sum(W(Ci==u,Ci==v)));    %pool weights of nodes in same module
        end
    end
    W=w;
    
    Q=trace(W)/s-gamma*sum(sum((W/s)^2));       %compute modularity, check this
end
