function [robot_vector,track_vector]=CalcDisp(previous_r,previous_c,curr_r,curr_c,TrackCoordinates)

%% Calculate distance
distance_from_track=sqrt((curr_r-TrackCoordinates(:,2)).^2+(curr_c-TrackCoordinates(:,1)).^2);
[C,I]=min(distance_from_track); % Find the nearest point of track
%% Track Vector
% check if it's the end of the track

if (I==length(TrackCoordinates(:,2)))
    r_track= TrackCoordinates(1,2)-previous_r;
    c_track= TrackCoordinates(1,1)-previous_c;
    %images(TrackCoordinates(1,2),TrackCoordinates(1,1))=255;
    %disp('Track nearest coordinates');
    % TrackCoordinates(1,2)
    %TrackCoordinates(1,1)
else
    r_track= TrackCoordinates(I+1,2)-previous_r;
    c_track= TrackCoordinates(I+1,1)-previous_c;
   % images(TrackCoordinates(I,2),TrackCoordinates(I+1,1))=255;
    %disp('Track nearest coordinates');
    %TrackCoordinates(I+1,2);
    %TrackCoordinates(I+1,1);
end

%% Robot Vector

r_robot=curr_r -previous_r;
c_robot=curr_c -previous_c;


%% Robot and track vectors
robot_vector=[-r_robot ,c_robot];
track_vector=[-r_track ,c_track];

%next_robot_vector=track_vector-robot_vector;

%disp_r=next_robot_vector(1);
%disp_c=next_robot_vector(2);


    
end
