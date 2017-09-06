function [ output_args ] = add_order( new_element )
%ADD_ORDER Summary of this function goes here
%   Detailed explanation goes here
    EEG = evalin('base','EEG');
    count = evalin('base','count');
    order = evalin('base','order');
    order = [order ; new_element];
    set(findobj('Tag','order_tag'), 'String', num2str(order'));  
    count = count + 1;
	assignin('base','order',order);
    assignin('base','count',count);
    set(findobj('Tag','feedback'), 'String', [num2str(count) , ' out of ', num2str(EEG.nbchan), ' channels selected.']);
end

