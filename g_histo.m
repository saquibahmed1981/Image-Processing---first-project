function bg_g = g_histo(g_mat, w, h)
% Function to calculate the background pixel value in a given green channel matrix
% Input arguments:
% - g_mat: Green channel matrix
% - w: Width of the image
% - h: Height of the image
% Output:
% - bg_g: Background pixel value

% Find unique values in the green channel matrix and store them in g_vec
g_vec = unique(g_mat);
g_vec = g_vec';
n = size(g_vec, 2);

% Initialize an array to count the occurrences of each unique value
x = zeros(1, n);

r = 1;
c = 1;

% Iterate through the image pixels
while r <= w
    while c <= h
        % Find the index of the current pixel value in g_vec
        index = find(g_vec == g_mat(r, c));
        
        % Increment the count for the corresponding index in x
        x(1, index) = x(1, index) + 1;
        
        % Move to the next column
        c = c + 1;
    end
    
    % Move to the next row and reset the column index
    r = r + 1;
    c = 1;
end

% Find the peaks in the x array (histogram)
pks = findpeaks(x);
pks = sort(pks, 'descend');

% The highest peak corresponds to the background
back_ = pks(1, 1);

% Find the index of the background pixel value in g_vec
indx_back = find(x == back_);

% Retrieve the background pixel value as bg_g
bg_g = double(g_vec(1, indx_back));
end
