% Get a list of all image files in the directory
imageDir = 'C:\Users\begat\OneDrive\Documents\MATLAB';
arcFiles = dir(fullfile(imageDir, '*.jpeg'));

% Loop over each image file
for g = 1:length(arcFiles)
    % Read in the image
    imagePath = fullfile(arcFiles(g).folder, arcFiles(g).name);
    originalImage = imread(imagePath);

    % Perform some image manipulation (e.g., convert to grayscale)
    processedImage = rgb2gray(originalImage);

    % Save the processed image to a file with a unique name
    imwrite(processedImage, sprintf('C:\\Users\\begat\\OneDrive\\Documents\\MATLAB\\processedImage_%d.jpg', g));
    
    % Convert the processed image to base64
    base64String = matlab.net.base64encode(processedImage(:)');

    % Construct the POST data
    postData = struct('base64String', base64String);

    % Send POST request to Flask API
    apiUrl = 'http://localhost:5000/process_image';
    options = weboptions('MediaType', 'application/json', 'RequestMethod', 'post');
    response = webwrite(apiUrl, postData, options);

    % Convert the response to a structure if it's a JSON string
    if ischar(response)
        response = jsondecode(response);
    end

    % If the server returned a success message
    if isfield(response, 'message')
        disp(['Response from server for ', arcFiles(g).name, ': ', response.message]);
    end

    % If the server returned an error message
    if isfield(response, 'error')
        disp(['Response from server for ', arcFiles(g).name, ': ', response.error]);
    end
end