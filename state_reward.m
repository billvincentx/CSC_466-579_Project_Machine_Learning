function [ next_state, next_reward_f,next_reward_m] = state_reward( ym,yi,yt,Pi,Pm,ta,tb )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
if ym >= yt
    s_0 = 1;
else s_0 = 0;
end

if yi >= yt
    s_1 = 1;
else s_1 = 0;
end

if yi <= Pi*ta
    s_2 = 0;
elseif Pi*ta<yi < Pi*tb
    s_2 = 1;
else s_2 = 2;
end

%% rewards
if ym >= yt
    rm_i = 100;%ym/Pm;
else rm_i = -1;%-exp(-ym/yt);
end

if yi >= yt <= ym
    rf_i = 100;
elseif yi < yt <= ym
    rf_i = -1;
    
elseif yi < yt > ym
    rf_i = -1;
else
    rf_i = -1;
end


next_state = [s_0,s_1,s_2];
next_reward_f = rf_i;
next_reward_m = rm_i;

end

