function [P1, P2, P3, P4] = f_Integer2prob(Integer1, Integer2, Integer3)

% Integer1: Target Future: X(n+1)
% Integer2: Target Present: X(n)
% Integer3: Source Present: Y(n)
% Integer1= Int_future(:,c1);Integer2= Int_past(:,c1);Integer3= Int_past(:,c2);

SymbolLen=max(ceil(log10(Integer1+.1)));
SymbolLen=max(SymbolLen, max(ceil(log10(Integer2+.1))));
SymbolLen=max(SymbolLen, max(ceil(log10(Integer3+.1))));


INT1 = Integer1.*10^(SymbolLen*2) + Integer2.*10^(SymbolLen*1) + Integer3; % {X(n+1),X(n),Y(n)}
INT2 = Integer2.*10^(SymbolLen*1) + Integer3; % {X(n),Y(n)}
% INT3 = Integer1.*10^(SymbolLen*2) + Integer2.*10^(SymbolLen*1); % {X(n+1),X(n)}
INT3 = Integer1.*10^(SymbolLen*1) + Integer2; % {X(n+1),X(n), 000}
INT4 = Integer2; % {X(n)}


P1 = F_EstimateProb(INT1); % P[X(n+1),X(n),Y(n)]
P2 = F_EstimateProb(INT2); % P[X(n),Y(n)]
P3 = F_EstimateProb(INT3); % P[X(n+1),X(n),???]
P4 = F_EstimateProb(INT4); % P[X(n)]
[~, U_Index]= unique(INT1); % length(U_Index)=Total number of trasition
P1 = P1(U_Index);
P2 = P2(U_Index);
P3 = P3(U_Index);
P4 = P4(U_Index);