% Takes a image matrix A, and outputs: 
% fm_codes - all Freeman chain codes of boundaries in the skeleton of the image 
% start_pos - starting position of each Freeman code
% boundaries - corresponding boundary 
function [fm_codes, start_pos, boundaries] = get_freeman_codes(A)
%sk = bwmorph(A,'skel',Inf);
%bounds = bwboundaries(sk,'noholes');
bounds = bwboundaries(A, 'noholes');
n = size(bounds,1);
fm_codes = cell(n,1);
boundaries = cell(n,1);
start_pos = zeros(n,2);

for ii = 1:n
    bound1 = cell2mat(bounds(ii));
    maxm = max(bound1(:,1));
    bounds1f = [bound1(:,2) (maxm-bound1(:,1))];
    boundaries(ii) = {bounds1f};
    cc2 = chaincode([bounds1f(:,2),bounds1f(:,1)]);
    start_pos(ii,:) = [cc2.x0 cc2.y0];
    fm_codes(ii) = {cc2.code};
end

end