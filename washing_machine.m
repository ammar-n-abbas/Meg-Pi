clear all
close all
clc

fis = mamfis('Name',"washing machine");

%%%%1st input/Quantity of clothes%%%%%
fis = addInput(fis,[0 50],'Name',"quantity");
fis = addMF(fis,"quantity","gaussmf",[10 0],'Name',"low");
fis = addMF(fis,"quantity","gaussmf",[8.5 25],'Name',"medium");
fis = addMF(fis,"quantity","gaussmf",[8.5 50],'Name',"high");

%%%2nd input/ level of dirt%%%
fis = addInput(fis,[0 100],'Name',"dirt");
fis = addMF(fis,"dirt","trapmf",[-36 -4 4 36],'Name',"low");
fis = addMF(fis,"dirt","trapmf",[14 46 54 86],'Name',"medium");
fis = addMF(fis,"dirt","trapmf",[64 96 104 136],'Name',"high");

%%%%%%%%1st output/washing speed%%%%
fis = addOutput(fis,[0 60],'Name',"speed");
fis = addMF(fis,"speed","trimf",[0 7.5 15],'Name',"short");
fis = addMF(fis,"speed","trimf",[15 25 35],'Name',"medium");
fis = addMF(fis,"speed","trimf",[30 45 60],'Name',"long");

% %%%%%2nd output/water inlet%%%%%%%%%5
fis = addOutput(fis,[0 60],'Name',"inlet");
fis = addMF(fis,"inlet","trimf",[0 5 15],'Name',"short");
fis = addMF(fis,"inlet","trimf",[5 20 35],'Name',"medium");
fis = addMF(fis,"inlet","trimf",[20 40 60],'Name',"long");

%%%%%%%%Rules%%%% 
 rule1 = "quantity==high | dirt==high => speed=long";
 rule2 = "quantity==medium & dirt==medium => speed=long";
 rule3 = "quantity==medium & dirt==low => speed=medium";
 rule4 = "quantity==low & dirt==medium => speed=medium";
 rule5 = "quantity==low & dirt==low => speed=short";
 rule6 = "quantity==high | dirt==high => inlet=long";
 rule7 = "quantity==medium & dirt==medium => inlet=long";
 rule8 = "quantity==medium & dirt==low => inlet=medium";
 rule9 = "quantity==low & dirt==medium => inlet=medium";
 rule10 = "quantity==low & dirt==low => inlet=short";
 
rules = [rule1 rule2 rule3 rule4 rule5 rule6 rule7 rule8 rule9 rule10];
fis= addRule(fis,rules);

%%%%%%plots%%%%%%%
subplot(3,2,1)
plotfis(fis)
subplot(3,2,2)
plotmf(fis,'input',1)
subplot(3,2,3)
plotmf(fis,'input',2)
subplot(3,2,4)
plotmf(fis,'output',1)
subplot(3,2,5)
plotmf(fis,'output',2)

input = [27 30];
output = evalfis(fis, input)
Motor1 = (output(:,1))
Motor2 = (output(:,2))

% fis.DefuzzificationMethod = "centroid";
% output1 = evalfis(fis,input)
% fis.DefuzzificationMethod = "mom";
% output2 = evalfis(fis,input)

% writeFIS(fis,"washng_machine","dialog")
% fis = readfis("washng_machine")

