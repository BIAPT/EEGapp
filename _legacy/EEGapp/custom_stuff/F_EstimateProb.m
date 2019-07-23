function prob = F_EstimateProb(Integer)
SZ = size(Integer); % length(emb) by 1
% CountIndex = zeros(SZ(1),1);
Count = zeros(SZ(1), 1);

%%%%%%% Modified by Heonsoo %%%%%%%%%%
b=unique(Integer);
for i=1:length(b)
    INDEX=find(b(i)==Integer);
    Count(INDEX)=length(INDEX);
end
prob=Count./SZ(1);

%%%%%%%%%%%%%%% old one %%%%%%%%%%%%%%%%%%%%%%%%%%
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







