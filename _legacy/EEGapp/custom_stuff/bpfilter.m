function data2=bpfilter(Lf, Hf, fs,data)
%% filtering
data2=zeros(size(data,1), size(data,2));
[b,a]=butter(1, [Lf/(fs/2) Hf/(fs/2)]);
data2=filtfilt(b,a,data);

