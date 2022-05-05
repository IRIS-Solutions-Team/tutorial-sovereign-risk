%% Simulate demand shocks


%% Simulate crisis scenarios with fiscal reaction 


%% Clear workspace 

close all
clear

load mat/createModel.mat m


%% Design a simulation scenario

d0 = steadydb(m, 1:40);
T = 8;
d1 = d0;
d1.shock_yh_gap(1:T) = -0.075;


%% Simulate the scenario

s1 = simulate( ...
    m, d1, 1:40, ...
    "method", "stacked", ...
    "prependInput", true ...    
);

smc1 = databank.minusControl(m, s1, d0);


%% Chart simulation results

ch = databank.Chartpack();
ch.Range = 0:40;
ch.Round = 8;
ch.CaptionFromComment = true;
ch.Highlight = 0 : T;

ch < ["100*(y_gap-1)", "100*(yg_gap-1)", "100*(yh_gap-1)"];
ch < ["400*r", "100*(roc_cpi^4-1)", "100*(cpi-1)", "400*q", "100*z", "100*(e-1)"];
ch < ["100*nga_to_4ny", "100*vg_to_ny", "shock_yh_gap"];

draw(ch, databank.merge("horzcat", smc1, smc2));

