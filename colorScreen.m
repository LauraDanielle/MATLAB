function colorScreen(foreground,background,vector,tolerance)
img1 = imread(foreground);
img2 = imread(background);

redLayer = img1(:,:,1);
greenLayer = img1(:,:,2);
blueLayer = img1(:,:,3);

red = img2(:,:,1);
green = img2(:,:,2);
blue = img2(:,:,3);

mask1 = (redLayer>=(uint8(vector(1)-tolerance)) & redLayer<=(uint8(vector(1)+tolerance)));
mask2 = (greenLayer>=(uint8(vector(2)-tolerance)) & greenLayer<=(uint8(vector(2)+tolerance)));
mask3 = (blueLayer>=(uint8(vector(3)-tolerance)) & blueLayer<=(uint8(vector(3)+tolerance)));

mnew1 = (red>=(uint8(vector(1)-tolerance)) & red<=(uint8(vector(1)+tolerance)));
mnew2 = (green>=(uint8(vector(2)-tolerance)) & green<=(uint8(vector(2)+tolerance)));
mnew3 = (blue>=(uint8(vector(3)-tolerance)) & blue<=(uint8(vector(3)+tolerance)));

red(mnew1) = redLayer(mnew1);
green(mnew2) = greenLayer(mnew2);
blue(mnew3) = blueLayer(mnew3);

concat = cat(3,red,green,blue);

new_name = sprintf('%s_new%s', foreground(1:end-4), foreground(end-3:end));
imwrite(concat,new_name);

end
% Function Name: colorScreen
% Inputs  (3): - (char) a filename of a foreground image
%              - (char) a filename of a background image
%              - (double) a vector of length three of RGB values to replace
%              - (double) a tolerance for what is considered a match
% Outputs (0):
% Output files (1): - (.png) a new image made from combining the foreground
%                            and background images
%
% Function Description:
%   Given two images, write a function called "colorScreen" that replaces
%   all the pixels in the first image (foreground) that match a given RGB
%   value with the corresponding pixels in the second image (background).
%   The 4th input gives you a a tolerance for what is considered a "match"
%   with the given RBG value. As in: if your tolerance is 2, and the R
%   value from the given RGB is 200, any R value for a pixel that is
%   between 198 and 202 (including 198 and 202!) would be cosidered a
%   match. The new image should be written to a file whose name is the name
%   of the first (foreground) image with '_new' appended before the
%   extension. For example, if  the following is called:
%
%               colorScreen('img1.bmp','img2.bmp', [2 253 2], 2);
%
%   A new image file called 'img1_new.bmp' should be created that looks
%   like 'img1.bmp', but with all of the pixels whose RBG values are in the
%   inclusive range of [0, 251, 0] to [4, 255, 4] should be replaced with
%   their corresponding pixels in img2.bmp.
%
% Notes:
%   - You do not have to use a for loop in this problem. For loops are a
%     very slow and inefficent due to the size of the images that must be
%     looped though. Consider logical indexing instead.
%   - The two input images will always be the same size.
%   - The pixel range will never cause the pixel values to be above 255 or
%     below 0
%
% Test Cases:
%   Use the included solution file to compare your own code's output to the
%   solution output for the following test cases. Any solution code
%   output files will have a '.soln' concatenated before the extension in
%   the filename.
%
%   colorScreen('smith.bmp','Superman.bmp',[252, 242, 3], 3);
%
%   colorScreen('lion.bmp','tiger.bmp',[253, 127, 38], 2);
%
%