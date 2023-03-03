function [output] = oct2bin(inputNum)
%OCT2BIN 此处显示有关此函数的摘要


switch inputNum
    case 0
        output = [0 0 0];
    case 1
        output = [0 0 1];
    case 2
        output = [0 1 0];
    case 3
        output = [0 1 1];
    case 4
        output = [1 0 0];
    case 5
        output = [1 0 1];
    case 6
        output = [1 1 0];    
    case 7
        output = [1 1 1];
end
end

