function average_network_properties

for i = 1:9
    [char_plength(i,:), node_str(i,:), E(i,:), modularity(i,:)] = graph_network_properties(i);
end

avg_plength = mean(char_plength);
std_plength = std(char_plength);

avg_node_str = mean(node_str);
std_node_str = std(node_str);

avg_E = mean(E);
std_E = std(E);

avg_modularity = mean(modularity);
std_modularity = std(modularity);

figure; errorbar(avg_plength, std_plength);
figure; errorbar(avg_node_str, std_node_str);
figure; errorbar(avg_E, std_E);
figure; errorbar(avg_modularity, std_modularity);
