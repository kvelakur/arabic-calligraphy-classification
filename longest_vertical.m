function [len] = longest_vertical(code1) 
    two_len = longest_sequence(code1,2);
    six_len = longest_sequence(code1,6);
    len = max([two_len,six_len]);
end