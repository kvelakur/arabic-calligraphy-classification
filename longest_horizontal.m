function [len] = longest_horizontal(code1) 
    four_len = longest_sequence(code1,4);
    zero_len = longest_sequence(code1,0);
    len = max([four_len,zero_len]);
end