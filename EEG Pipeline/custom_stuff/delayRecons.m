function y=delayRecons(data, v, m)
% data should be 2-d matrix
% output is 3-d matrix

MaxEpoch=length(data);
ch=size(data,2);

y=zeros(MaxEpoch-v*(m-1),m,ch);
for c=1:ch
    for j=1:m
        y(:, j, c)=data(1+(j-1)*v:end-(m-j)*v, c);
    end
end

