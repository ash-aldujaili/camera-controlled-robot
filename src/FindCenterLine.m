function FindCenterLine(im)
%% get the center line of the track
BW=(im);
BW=1-BW;
BW1=bwmorph(BW,'thin',inf);
BW2=bwmorph(BW1,'spur',inf);
figure,imshow(BW2);
end

