function [ output] = findstateIndx_m( x,z )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if x  == 0 && z == 0
    output = 1;
    
elseif   x  == 0 && z == 1
    output = 2;
elseif   x  == 0 && z == 2
    output = 3;
elseif   x  == 1 && z == 0
    output = 4;
elseif   x  == 1 &&  z == 1
    output = 5;
elseif   x  == 1 &&  z == 2
    output = 6;

end
end