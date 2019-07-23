function [Ci Q]=modularity_louvain_und(W,gamma)
%MODULARITY_LOUVAIN_UND     Optimal community structure and modularity
%
%   Ci = modularity_louvain_und(W);
%   [Ci Q] = modularity_louvain_und(W);
%   [Ci_h Q_h] = modularity_louvain_und(W,gamma);
%
%   The optimal community structure is a subdivision of the network into
%   nonoverlapping groups of nodes in a way that maximizes the number of
%   within-group edges, and minimizes the number of between-group edges.
%   The modularity is a statistic that quantifies the degree to which the
%   network may be subdivided into such clearly delineated groups.
%
%   The Louvain algorithm is a fast and accurate community detection
%   algorithm (as of writing). The algorithm may also be used to detect
%   hierarchical community structure.
%
%   Input:      W       undirected (weighted or binary) connection matrix.
%               gamma,  modularity resolution parameter (optional)
%                           gamma>1     detects smaller modules
%                           0<=gamma<1  detects larger modules
%                           gamma=1     (default) leads to the 'classic' modularity function
%
%   Outputs:    Ci,     community structure
%               Q,      modularity
%
%   Note: Ci and Q may vary from run to run, due to heuristics in the
%   algorithm. Consequently, it may be worth to compare multiple runs.
%
%   Reference: Blondel et al. (2008)  J. Stat. Mech. P10008.
%              Reichardt and Bornholdt (2006) Phys Rev E 74:016110.
%
%   Mika Rubinov, UNSW, 2010

%   Modification History:
%   Feb 2010: Original
%   Jun 2010: Fix infinite loops: replace >/< 0 with >/< 1e-10
%   May 2013: Include gamma resolution parameter

if ~exist('gamma','var')
    gamma = 1;
end

W=double(W);                                    %convert from logical
N=length(W);                                    %number of nodes
s=sum(W(:));                                    %weight of edges

h=2;                                            %hierarchy index
n=N;                                            %number of nodes in hierarchy
Ci={[],1:n};                                    %hierarchical module assignments
Q={-1,0};                                       %hierarchical modularity values
while Q{h}-Q{h-1}>1e-10
    K=sum(W);                                   %node degree
    Km=K;                                       %module degree
    Knm=W;                                      %node-to-module degree
    
    M=1:n;                                      %initial module assignments
    
    flag=true;                                  %flag for within-hierarchy search
    while flag; 
        flag=false;
        
        for u=randperm(n)                       %loop over all nodes in random order
            ma = M(u);                          %current module of u
            dQ=(Knm(u,:)-Knm(u,ma)+W(u,u)) - gamma*K(u).*(Km-Km(ma)+K(u))/s;
            dQ(ma)=0;                           %(line above) algorithm condition
            
            [max_dQ mb] = max(dQ);              %maximal increase in modularity and corresponding module
            if max_dQ>1e-10;                    %if maximal increase is positive
                flag=true;
                M(u) = mb;                      %reassign module
                
                Knm(:,mb)=Knm(:,mb)+W(:,u);     %change node-to-module degrees
                Knm(:,ma)=Knm(:,ma)-W(:,u);
                Km(mb)=Km(mb)+K(u);             %change module degrees
                Km(ma)=Km(ma)-K(u);
            end
        end
    end
    
    h=h+1;
    Ci{h}=zeros(1,N);
    [dum,dum,M]=unique(M);                      %new module assignments
    for u=1:n                                   %loop through initial module assignments
        Ci{h}(Ci{h-1}==u)=M(u);                 %assign new modules
    end
    
    n=max(M);                                   %new number of modules
    w=zeros(n);                                 %new weighted matrix
    for u=1:n
        for v=u:n
            wm=sum(sum(W(M==u,M==v)));          %pool weights of nodes in same module
            w(u,v)=wm;
            w(v,u)=wm;
        end
    end
    W=w;
    
    Q{h}=trace(W)/s-gamma*sum(sum((W/s)^2));          %compute modularity
end

Ci=Ci{end};
Q=Q{end};
