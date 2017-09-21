<img src="https://github.com/BIAPT/EEGapp/blob/master/EEG%20Pipeline/Documentation/LOGO_BG.jpg?"/>
<h1>What is EEGapp?</h1>
<p>EEGapp is a pipeline in the form of a GUI that automatizes the analysis of EEG data using new techniques that are not yet offered in other processing pipelines. Analysis techniques like <b>Phase Lag Index</b>, <b>directed Phase Lag Index</b>, <b>Phase Amplitude Coupling</b> or <b>Symbolic Transfer Entropy</b> are all bundled into MATLAB functions along with all the necessary surrogate data analysis already implemented.</p>
<h1>Features</h1>
<h4>Type of Analysis Techniques Included: </h4>
<ul>
<li>Spectrogram and Topographic Map</li>
<li>Phase Amplitude Coupling</li>
<li>Coherence</li>
<li>Phase Lag Index</li>
<li>directed Phase Lag Index</li>
<li>Symbolic Transfer Entropy</li>
<li>Graph Theory Analysis</li>
</ul>
<h4>Other Features: </h4>
<ul>
<li>Batch processing</li>
<li>Visual tool for channels reordering</li>
<li>Interactive plot for PLI and dPLI</li>
</ul>
<h1>Advantages</h1>
<ul>
<li>Easy to use interface</li>
<li>No coding required</li>
<li>Fully automated pipeline that can manage multiple EEG data</li>
<li>Surrogate data analysis already included when necessary</li>
</ul>
<h1>How to use</h1>
<h4>Installation:</h4>
<p> This pipeline is bundled as a MATLAB plug in. You only need to download the EEGapp installation package provided in this directory, double click on it and follow the instruction on the screen.</p>
<h4>Pre-processing:</h4>
<p>First you should import and clean your EEG data with the help of the freely available <b>eeglab</b> software. When this is done, save the EEG struct files that appear on your workspace while your dataset of choice is loaded. This struct file contain your EEG data and all the necessary information for EEGapp to run the analysis techniques.</p>
<h4>Analysis:</h4>
<p> Open EEGapp, load your EEG struct file(s) and choose a saving directory. Then select the analysis techniques you wish to perform and enter the values for all the variables that are required. When ready, click the "launch analysis" button and EEGapp will do the rest!</p>
<h1>Requierement</h1>
<ul>
<li>A working version of Matlab with the signal processing toolbox activated.</li>
<li>An up to date version of eeglab for the pre-processing steps.</li>
<li>A computer with reasonable memory space and processing speed.</li>
</ul>
<h1>Cite</h1>
<p> Please cite: "EEGapp, BIAPT lab, McGill University" when you use this software for analysis purposes.</p>
<p> If you decide to use the graph that can be generated in the graph theory analysis, please cite:
Xia M, Wang J, He Y (2013) BrainNet Viewer: A Network Visualization Tool for Human Brain Connectomics. PLoS ONE 8: e68910.</p>
<p>If you have feedback on this software please direct it to "stefanie.blain-moraes@mcgill.ca"</p>
