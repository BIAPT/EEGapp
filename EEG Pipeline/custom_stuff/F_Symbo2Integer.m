function [P1, P2, P3, P4] = F_Symbo2Integer(E1, E2, E3,SymbolLen)

% make them SYMBOL (e.g. 123, 312)
Integer1 = F_Symb2Int(E1);
Integer2 = F_Symb2Int(E2);
Integer3 = F_Symb2Int(E3);

% Target Future: X(n+1)
% Target Present: X(n)
% Source Present: Y(n)

INT1 = Integer1.*10^(SymbolLen*2) + Integer2.*10^(SymbolLen*1) + Integer3; % {X(n+1),X(n),Y(n)}
INT2 = Integer2.*10^(SymbolLen*1) + Integer3; % {X(n),Y(n)}
INT3 = Integer1.*10^(SymbolLen*2) + Integer2.*10^(SymbolLen*1); % {X(n+1),X(n), 000}
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



% function Integer = F_Symb2Int(E)
% 
% [V I] = sort(E');
% I = I';
% SZ = size(E);
% 
% Integer = zeros(SZ(1), 1);
% for i = 1 : SZ(2)
%     Integer = Integer + I(:,i)*10^(SZ(2)-i)';
% end
% 
% function prob = F_EstimateProb(Integer)
% SZ = size(Integer);
% CountIndex = zeros(SZ(1),1);
% Count = zeros(SZ(1), 1);
% for i = 1 : SZ(1)
%     if CountIndex(i) == 0;
%         INDEX = find(Integer(i) == Integer);    
%         Count(INDEX) = length(INDEX);
%         CountIndex(INDEX) = 1;
%     else
%     end
%     clear INDEX


% end
% prob=Count./SZ(1);