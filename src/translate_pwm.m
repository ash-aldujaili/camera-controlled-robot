function translate_pwm(robot_vector,track_vector,r)



%% Calculate angle of rotation
[theta_t,rho_t]=cart2pol(track_vector(2),track_vector(1));
[theta_r,rho_r]=cart2pol(robot_vector(2),robot_vector(1));
if (theta_r < 0 )
    theta_r=2*pi+theta_r;
end
if (theta_t< 0)
    theta_t=2*pi+theta_t;
end
%display(theta_t);
%display(theta_r);
theta= theta_t-theta_r;
if (theta > pi)
    theta=theta-2*pi;
end
if (theta <-pi)
    theta=theta+2*pi;
end
%disp('angle');
%display(theta*180/pi);
%display(robot_vector);
%display(track_vector);

%%Left/Right
if(theta>0.60)
  move_left(r);
 % disp('high');
%  pause(0.2);
  pause(0.2);
  halt_motion(r);
  % disp('move left');
    %pause(theta*0.1);
    %move_forward(r);
    %pause(0.1);
    %pause(0.3);
 %   halt_motion(r);
elseif (theta < -0.60)
   %    disp('move right');
    move_right(r);
    pause(0.2);
  halt_motion(r);
  %  disp('high');
   % pause(0.2);
    %pause(theta*0.1)
    %move_forward(r);
    %pause(0.1);
   % pause(0.3);
  %  halt_motion(r);
    else
    %im  disp('move forward');
      move_forward(r);
      pause(0.23);
      halt_motion(r);
   %   disp('high');
    %  pause(0.7);
    %halt_motion(r);
end


%%Forward/backward


end
