

function [s_0,s_1,s_2] = findstate(state_idx)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if state_idx  == 1 
    s_0 = 0;s_1 = 0; s_2 = 0;
elseif   state_idx  == 2 
     s_0 = 0;s_1 = 0; s_2 = 1;
elseif   state_idx  == 3 
    s_0 = 0;s_1 = 0; s_2 = 2;
elseif   state_idx  == 4
    s_0 = 1;s_1 = 0; s_2 = 0;
elseif   state_idx  == 5 
    s_0 = 1;s_1 = 0; s_2 = 1;
elseif   state_idx  == 6 
    s_0 = 1;s_1 = 0; s_2 = 2;
elseif   state_idx  == 7 
    s_0 = 0;s_1 = 1; s_2 = 0;
elseif   state_idx  == 8 
    s_0 = 0;s_1 = 1; s_2 = 1;
elseif   state_idx  == 9 
    s_0 = 0;s_1 = 1; s_2 = 2;
elseif   state_idx  == 10 
    s_0 = 1;s_1 = 1; s_2 = 0;
elseif   state_idx  == 11 
    s_0 = 1;s_1 = 1; s_2 = 1;
elseif   state_idx  == 12 
    s_0 = 1;s_1 = 1; s_2 = 2;
end
end
