function [sum1, sum2] = sampleFunction(x)
% SAMPLE calculate sum and squares of x
%   sum1 = sum(x)
%   sum2 = sum(x squared)
%   To extract both outputs, the function must be called with [output1,
%   output2]
sum1 = sum(x);
sum2 = sum(x.^2);
end

