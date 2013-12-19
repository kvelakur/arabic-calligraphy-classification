function [len] = longest_sequence(code,search_element)
indexes = code==search_element;
indexes = [0; indexes; 0];
st = strfind(indexes',[0 1])+1;
ed = strfind(indexes',[1 0]);
len = max(ed-st)+1+1;
if isempty(len)
    len=0;
end
end