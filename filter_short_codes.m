% filters codes having less than minimum threshold area
function [significant_fm_codes, significant_start_pos, significant_boundaries] = filter_short_codes(fm_codes,start_pos,boundaries,thresh_area)
n = size(boundaries,1);
significant_boundaries = cell(n,1);
significant_start_pos = zeros(n,2);
significant_fm_codes = cell(n,1);

jj = 0;
for ii=1:n
    codeii = boundaries{ii};
    areaa = polyarea(codeii(:,1),codeii(:,2));
    if areaa >= thresh_area
        jj = jj+1;        
        significant_fm_codes(jj) = fm_codes(ii);
        significant_start_pos(jj,:) = start_pos(ii,:);
        significant_boundaries(jj) = boundaries(ii);
    end
end
significant_boundaries = significant_boundaries(1:jj);
significant_fm_codes = significant_fm_codes(1:jj);
significant_start_pos = significant_start_pos(1:jj,:);
end