function Robot_Race(TrackCoordinates)

%% Dlink
Path = 'http://192.168.0.103/cgi-bin/video.jpg';
start_line =true;
% 3 for lab
% arduino settings
 r=arduino('COM3');
r.pinMode(10,'output');
r.pinMode(11,'output');
r.pinMode(12,'output');
r.pinMode(13,'output');
%% Initialiaizing
lap=0; 
curr_r=23;
curr_c=24;
disp_r=1;
disp_c=1;
path_r=0;
path_c=0;
curr_position=[3 3];
pre_position=[1 1];
%% Specifiying which colours to detect
PINK=[250 86 156];
YELLOW=[243 242 81];
GREEN=[115 179 90];
BLUE=[81 86 108];
light=[118 174 255];
red=[200 70 74];
darkblue=[ 93 106 144];
orange=[255 101 67];

pause;
while (1) 

 % curr_position(2) = input('Enter curr_r');
% curr_position(1) = input('Enter curr_c');
% pre_position(2) = input('Enter pre_r');
% pre_position(1) = input('Enter pre_c');

    %% Start acquisition
% Dlink
images=zeros(240,320);
im=imread(Path);
%% Detecting the colours
c1=colorseg('EUCLIDEAN',im,90,PINK);
c2=colorseg('EUCLIDEAN',im,90,YELLOW);
blob1=bwlargestblob(c1,4);
blob2=bwlargestblob(c2,4);
final1=imfill(blob1,'holes');
final2=imfill(blob2,'holes');
cog1=regionprops(final1,'centroid');
cog2=regionprops(final2,'centroid');
size_cog1=size(cog1);
size_cog2=size(cog2);

if (size_cog1(1) ~= 0) 
    curr_position=uint32(cog1.Centroid);
     images(curr_position(2),curr_position(1))=255;
end
 if (size_cog2(1) ~= 0) 
    pre_position=uint32(cog2.Centroid);
   images(pre_position(2),pre_position(1))=255;
 end

%% Identifying the current robot position
%images(curr_position(2),curr_position(1))=255;
%images(pre_position(2),pre_position(1))=255;
curr_r=double(curr_position(2));
curr_c=double(curr_position(1));
previous_r=double(pre_position(2));
previous_c=double(pre_position(1));

% %% Robot Path Evaluation -- track1
% if ( curr_r>=1 && curr_r<76 && curr_c<= 234 && curr_c>= 196 && start_line)
%    lap=lap+1;
%    disp('Lap finished');
%    disp(lap);
%   
%  start_line=false;
% else
%     start_line=true;
%  end
% if (lap==2)
%    break;
% end


% %% Robot Path Evaluation -- track2
% if ( curr_r>=1 && curr_r<76 && curr_c>= 234 && curr_c<= 320 && start_line)
%    lap=lap+1;
%    disp('Lap done');
%    %disp(lap);
%   
%     start_line=false;
% else
%     start_line=true;
%     %disp('Lap done');
% end

% if (lap == 2)
%     disp('Lap finished'); 
%    break;
% end

%% Calculate robot and track vectors:
[robot_vector,track_vector]=CalcDisp(previous_r,previous_c,curr_r,curr_c,TrackCoordinates);
%% Communication with Adruino:

translate_pwm(robot_vector,track_vector,r);
%pause(0.1);

% Path points appended
% path_r=[path_r,previous_r];
 %path_c=[path_c,previous_c];
    
imshow(images);

drawnow;
%pause;
end

%% stop motion
halt_motion(r);



% delete(r);
end

