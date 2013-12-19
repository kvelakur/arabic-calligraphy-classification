% function to extract features of a given image
% run testing.m to understand how this function works

function [features] = extract_features(A) 
A = fliplr(A);
[Am,An] = size(A);
[codes,start_pos,boundaries] = get_freeman_codes(A);

% filter out diacritics (dots, dashes, etc.)
[codes, start_pos, boundaries] = filter_short_codes(codes,start_pos,boundaries,5);

% normalized height, set to 60 px
normalized_height = Am;

% number of connected components
n = size(codes,1);
long_horz = zeros(n,1);
long_vert = zeros(n,1);
aspect_ratio = zeros(n,1);
circularity = zeros(n,1);
slant = zeros(n,1);
features = zeros(10,1);
for ii = 1:n    
    code1 = codes{ii};
        
    % longest horizontal stroke
    long_horz(ii) = longest_horizontal(code1)/normalized_height;
        
    % longest vertical stroke
    long_vert(ii) = longest_vertical(code1)/normalized_height;
        
    bounds1f = boundaries{ii};
    
    % calculating circularity, a measure of thickness of strokes
    areaa = polyarea(bounds1f(:,1),bounds1f(:,2));
    perimeter = sum(sqrt(sum((bounds1f - circshift(bounds1f,-1)).^2,2)));
    circularity(ii) = 4*pi*areaa/perimeter^2;
        
    % calculating estimated slant
    n1 = size(find(code1==1),1);
    n2 = size(find(code1==2),1);
    n3 = size(find(code1==3),1);
    slant(ii) = atan((n1+n2+n3)/(n1-n3));
    if slant(ii) < 0 
        slant(ii) = slant(ii) + pi;
    end
    slant(ii) = slant(ii)/(pi/2);
        
    % calculating aspect ratio
    xmin = min(bounds1f(:,1));
    xmax = max(bounds1f(:,1));
    ymin = min(bounds1f(:,2));
    ymax = max(bounds1f(:,2));
    aspect_ratio(ii) = (xmax-xmin+1)/(ymax-ymin+1);            

end
features(1) = mean(long_horz);
features(2) = var(long_horz);
features(3) = mean(long_vert);
features(4) = var(long_vert);
features(5) = mean(aspect_ratio);
features(6) = var(aspect_ratio);
features(7) = mean(circularity);
features(8) = var(circularity);
features(9) = mean(slant);
features(10) = var(slant);
end