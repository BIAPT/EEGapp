function [ x_labels,y_labels,x_ticks,y_ticks] = load_plot_data(filename)
%LOAD_PLOT_DATA Summary of this function goes here
%   Detailed explanation goes here
[folder, name, ext] = fileparts(which('load_plot_data'))
open([folder ,'/../Custom Plots/' filename]);
set(gcf,'CreateFcn','set(gcf,''Visible'',''off'')');  
h = gcf;
a=findobj(h,'type','axe');
x_labels=get(a,'XTickLabel');
y_labels=get(a,'YTickLabel');
x_ticks=get(a,'XTick');
y_ticks=get(a,'YTick');
set(gcf,'CreateFcn','set(gcf,''Visible'',''on'')');
close(h)
end

