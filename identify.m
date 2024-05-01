% Prompt the user to select an image file
[file, path] = uigetfile({'*.*'});

% Construct the full file name by combining the path and selected file name
fn = strcat(path, file);

% Read the selected image
Y = imread(fn);

% Get the dimensions (width and height) of the image
w = size(Y, 1);
h = size(Y, 2);

% Find the background pixel value in the green channel using a custom function
bg_g = g_histo(Y(:,:,2), w, h); % Find background g pixel value

% Initialize row and column indices
r = 1;
c = 1;

% Iterate through the image pixels
while r <= w
    while c <= h
        % Get the green channel intensity value at the current pixel
        g = double(Y(r, c, 2));
        
        % Calculate the ratio of the current pixel intensity to the background intensity
        ratio = g / bg_g;
        
        % Apply color mapping based on the calculated ratio (thresholding)
        if (ratio >= 0.327 && ratio <= 0.49)
            % Few-layers (Red color)
            Y(r, c, 1) = 3;
            Y(r, c, 2) = 75;
            Y(r, c, 3) = 3;
        end
        
        if (ratio >= 0.489 && ratio <= 0.897)
            % Bilayer (Green color)
            Y(r, c, 1) = 0;
            Y(r, c, 2) = 255;
            Y(r, c, 3) = 0;
        end
        
        if (ratio >= 0.777 && ratio <= 0.953)
            % Monolayer (Light Green color)
            Y(r, c, 1) = 144;
            Y(r, c, 2) = 238;
            Y(r, c, 3) = 144;
        end
        
        % Move to the next column
        c = c + 1;
    end
    
    % Move to the next row and reset the column index
    r = r + 1;
    c = 1;
end

% Display the modified image
imshow(Y)
