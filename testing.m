% function demonstrating how feature extraction happens
% hit enter after each iteration to proceed

clear
A = imread('andalus_274.tif');
A = normalize_image(A);
A = fliplr(A);
[Am,An] = size(A);
[codes,start_pos,boundaries] = get_freeman_codes(A);
[codes, start_pos, boundaries] = filter_short_codes(codes,start_pos,boundaries,25);
%imshow(A); 
normalized_height = size(A,1);

n = size(codes,1);
long_horz = zeros(n,1);
long_vert = zeros(n,1);
aspect_ratio = zeros(n,1);
circularity = zeros(n,1);
slant = zeros(n,1);
features = zeros(10,1);
for ii = 1:n    
    disp(ii)
    code1 = codes{ii};
    disp(strcat(['start position = ', num2str(start_pos(ii,:))]))
    disp(strcat(['freeman code = ', num2str(code1')]))
        
    long_horz(ii) = longest_horizontal(code1)/normalized_height;
    disp(strcat(['longest horizontal = ', num2str(long_horz(ii))]))
        
    long_vert(ii) = longest_vertical(code1)/normalized_height;
    disp(strcat(['freeman code = ', num2str(long_vert(ii))]))
        
    bounds1f = boundaries{ii};

    areaa = polyarea(bounds1f(:,1),bounds1f(:,2));
    disp(strcat(['area = ', num2str(polyarea(bounds1f(:,1),bounds1f(:,2)))]))    
    perimeter = sum(sqrt(sum((bounds1f - circshift(bounds1f,-1)).^2,2)));
    circularity(ii) = 4*pi*areaa/perimeter^2;
    disp(strcat(['circularity = ', num2str(circularity(ii))]))   
        
    n1 = size(find(code1==1),1);
    n2 = size(find(code1==2),1);
    n3 = size(find(code1==3),1);
    slant(ii) = atan((n1+n2+n3)/(n1-n3));
    if slant(ii) < 0 
        slant(ii) = slant(ii) + pi;
    end
    slant(ii) = slant(ii)/(pi/2);
    disp(strcat(['slant = ', num2str(slant(ii))]))   
        
    xmin = min(bounds1f(:,1));
    xmax = max(bounds1f(:,1));
    ymin = min(bounds1f(:,2));
    ymax = max(bounds1f(:,2));
    aspect_ratio(ii) = (xmax-xmin+1)/(ymax-ymin+1);
    disp(strcat(['aspect ratio = ', num2str(aspect_ratio(ii))]))   
            
    subplot(2,1,1)
    plot(bounds1f(:,1), bounds1f(:,2), '*')
    
    axis equal;
    subplot(2,1,2)
    imshow(A); 
    hold on
    plot([xmin;xmin], [1;Am],'w');
    plot([xmax;xmax],[1;Am],'w');    
    pause
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


