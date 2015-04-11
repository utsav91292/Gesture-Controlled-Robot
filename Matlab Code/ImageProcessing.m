% For setting up serial port 
% As we are controlling our robot via RF
s = serial('COM14');
s.DataTerminalReady='Off';

redThresh=0.23; % Threshold for red detection 
greenThresh = 0.1; % Threshold for green detection 
blueThresh = 0.2; % Threshold for blue detection 
vidDevice = videoinput('winvideo',1,'YUY2_1280x720');
set(vidDevice, 'ReturnedColorSpace', 'RGB');
triggerconfig(vidDevice,'manual');
set(vidDevice,'framesPerTrigger',1);
set(vidDevice,'TriggerRepeat',Inf);
start(vidDevice);
trigger(vidDevice);

% vidInfo = imaqhwinfo(vidDevice); % Acquire input video property
% 
% hblob = vision.BlobAnalysis('AreaOutputPort', false, ... % Set blob analysis handling
%                                 'CentroidOutputPort', true, ... 
%                                 'BoundingBoxOutputPort', true', ...
%                                 'MinimumBlobArea', 1000, ...
%                                 'MaximumBlobArea', 3000, ...
%                                 'MaximumCount', 1);
                                    
 while(1)
     
    trigger(vidDevice);    
    rgbFrame= getdata(vidDevice); % Acquire single frame
    rgbFrame = flipdim(rgbFrame,2); % obtain the mirror image for displaying
    
    diffFrameRed = imsubtract(rgbFrame(:,:,1), rgb2gray(rgbFrame)); % Get red component of the image
    diffFrameRed = medfilt2(diffFrameRed, [10 10]); % Filter out the noise by using median filter
    binFrameRed = im2bw(diffFrameRed, redThresh); % Convert the image into binary image with the red objects as white
    
    diffFrameGreen = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame)); % Get green component of the image
    diffFrameGreen = medfilt2(diffFrameGreen, [3 3]); % Filter out the noise by using median filter
    binFrameGreen = im2bw(diffFrameGreen, greenThresh); % Convert the image into binary image with the green objects as white
    
    diffFrameBlue = imsubtract(rgbFrame(:,:,3), rgb2gray(rgbFrame)); % Get blue component of the image
    diffFrameBlue = medfilt2(diffFrameBlue, [3 3]); % Filter out the noise by using median filter
    binFrameBlue = im2bw(diffFrameBlue, blueThresh); % Convert the image into binary image with the blue objects as white
    
    %%%%%%%%%%%%%%%%%%%%%%Red Centroid%%%%%%%%%%%%%%%%%%%%%%%%%%%
     count=0;
     count1=0;
     x1=0;
     y1=0;
     xc=0;
     yc=0;
     x=0;
     y=0;
%      m;
%      n;
%     [m,n]=size(rgbFrame);
    for i=1:1:720
       count=0;
        for j=1:1:1280

            if  binFrameRed(i,j)==1
                count=count+1;
            end
            if count>count1
                   count1=count;
                   y1=j;
            end                        
        end
   
    end
    

     count=0;
     count2=0;
 
%     [m,n]=size(rgbFrame);
    for i=1:1:1280
      count=0;
        for j=1:1:720
            if  binFrameRed(j,i)==1
                count=count+1;
            end
            if count>count2
            count2=count;
            x1=j;
            end                        
        end  
    end
         
    xc=(count1/2);
    yc=(count2/2);
    x1;
    y1;
    yr=ceil(x1-xc);
    xr=ceil(y1-yc);
      
    if xr<0
        xr=(-xr);
    end
    
    if yr<0
        yr=(-yr);
    end
pixel_a=yr;
pixel_b=xr;
if xr>5 && yr>5
color_a=[0 -1 0 0 1 1 0 0];
color_b=[-1 0 1 1 0 0 -1 -1];  
    for p=1:8
     pixel_a = pixel_a+color_a(p);
     pixel_b = pixel_b+color_b(p);
   
       rgbFrame(pixel_a,pixel_b,1)=255;
        rgbFrame(pixel_a,pixel_b,2)=255;
        rgbFrame(pixel_a,pixel_b,3)=255;
    end
end    
    
  
%%

%%%%%%%%%%%%%%%%%%%%%%Green Centroid%%%%%%%%%%%%%%%%%%%%%%%%%%%
     count=0;
  count1=0;
     x1=0;
     y1=0;
     xc=0;
     yc=0;
     x=0;
     y=0;
%      m;
%      n;
%   [m,n]=size(rgbFrame);
    for i=1:1:720
       count=0;
        for j=1:1:1280

            if  binFrameGreen(i,j)==1
                count=count+1;
            end
            if count>count1
                   count1=count;
                   y1=j;
            end                        
        end     
    end
    
     count=0;
    count2=0;    
  
    
    for i=1:1:1280
      count=0;
        for j=1:1:720

            if  binFrameGreen(j,i)==1
                count=count+1;
            end
            if count>count2
            count2=count;
            x1=j;
            end                        
        end 
    end
    
    
   
    xc=(count1/2);
    yc=(count2/2);
    x1;
    y1;
    yg=ceil(x1-xc);
    xg=ceil(y1-yc);
  
    
    if xg<0
        xg=(-xg);
    end
    
    if yg<0
        yg=(-yg);
    end
pixel_a=yg;
pixel_b=xg;
if xg>5 && yg>5
color_a=[0 -1 0 0 1 1 0 0];
color_b=[-1 0 1 1 0 0 -1 -1];  
    for p=1:8
     pixel_a = pixel_a+color_a(p);
     pixel_b = pixel_b+color_b(p);
   
       rgbFrame(pixel_a,pixel_b,1)=255;
        rgbFrame(pixel_a,pixel_b,2)=255;
        rgbFrame(pixel_a,pixel_b,3)=255;
    end
end    
     

  
%%
    
%%%%%%%%%%%%%%%%%%%%%%Blue Centroid%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    count=0;
 count1=0;
     x1=0;
     y1=0;
     xc=0;
     yc=0;
     x=0;
     y=0;
%      m;
%      n;
    [m,n]=size(rgbFrame);
    for i=1:1:720
       count=0;
        for j=1:1:1280

            if  binFrameBlue(i,j)==1
                count=count+1;
            end
            if count>count1
                   count1=count;
                   y1=j;
            end                        
        end    
    end
    

    count=0;
    count2=0;
    
   
  
    
    for i=1:1:1280
      count=0;
        for j=1:1:720
            if  binFrameBlue(j,i)==1
                count=count+1;
            end
            if count>count2
            count2=count;
            x1=j;
            end                        
        end 
    end
       
   
    xc=(count1/2);
    yc=(count2/2);
    x1;
    y1;
    yb=ceil(x1-xc);
    xb=ceil(y1-yc);
      
    if xb<0
        xb=(-xb);
    end
    if yb<0
        yb=(-yb);
    end
pixel_a=yb;
pixel_b=xb;
if xb>5 && yb>5
color_a=[0 -1 0 0 1 1 0 0];
color_b=[-1 0 1 1 0 0 -1 -1];  
    for p=1:8
     pixel_a = pixel_a+color_a(p);
     pixel_b = pixel_b+color_b(p);
   
       rgbFrame(pixel_a,pixel_b,1)=255;
        rgbFrame(pixel_a,pixel_b,2)=255;
        rgbFrame(pixel_a,pixel_b,3)=255;
    end
end 



%%

%%%%%%%%%%%%%%%%%%%%%%RG,GB,BR Distance%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ra1=xr-xg;
Ra2=yr-yg;

Rb1=xg-xb;
Rb2=yg-yb;

Rc1=xr-xb;
Rc2=yr-yb;

a=sqrt((Ra1*Ra1)+(Ra2*Ra2)) ; % distance B/W red And green
b=sqrt((Rb1*Rb1)+(Rb2*Rb2))  ;% distance B/W green And blue
c=sqrt((Rc1*Rc1)+(Rc2*Rc2)) ; % distance B/W red And blue

%%

%%%%%%%%%%%%%%Finding Ratio for removing effect of depth%%%%%%%%%%

 A=a/b
 B=b/c
 C=a/c
% if  (A>0.7) && (A<10) && (B>0.7) && (B<10) && (C>0.7) && (C<10)
% disp('STOP') %all three nearer
% % imshow('stop.jpg')
% 
% elseif ((A>0.7) &&(A<0.85)) && (B>0.55) && (B<0.77) && (C>0.34  && C<0.55)
%     disp('back') %broad fingers and thumb
% % elseif (A<0.40) && (A>0.25) && B<0.9 && B>0.75 && C>0.2 && C<0.3
% %     disp('stop') thumb on ring finger
% % imshow('back.jpg')
% 
% elseif (A>0.15) && (A<0.46) && (B>0.7) && (B<1) && (C>0.13) && (C<0.34)
% disp('forward') %all three stick together
% % imshow('forward.jpg')
% 
% 
% elseif (A>0.05) && (A<0.24) && (B>0.82) && (B<1.1) && (C>0.1) && (C<0.25)
% disp('LEFT') %thumb away from both fingers and both fingers stick together
% % imshow('left.jpg')
% 
% elseif (A>0.15) && (A<0.35) && (B>0.9) && (B<1.5) && (C>0.15) && (C<0.35)
% disp('right')
% % imshow('right.jpg')
% 
% else
% %     imshow('seatbelt.jpg')
% % else
% %     disp('stop')
% end


% if  (A>0.52) && (A<10) && (B>0.52) && (B<10) && (C>0.52) && (C<10)
% disp('STOP') %all three nearer
% imshow('stop.jpg')
% 
% 
% elseif (A>0.22) && (A<0.46) && (B>0.7) && (B<.9) && (C>0.16) && (C<0.34)
% disp('forward') %all three stick together
% imshow('forward.jpg')
% 
% elseif ((A>0.46) &&(A<0.8)) && (B>0.55) && (B<0.77) && (C>0.34  && C<0.55)
%     disp('right') %broad fingers and thumb
% % elseif (A<0.40) && (A>0.25) && B<0.9 && B>0.75 && C>0.2 && C<0.3
% %     disp('stop') thumb on ring finger
% imshow('right.jpg')
% 
% elseif (A>0.05) && (A<0.22) && (B>0.82) && (B<0.95) && (C>0.1) && (C<0.2)
% disp('LEFT') %thumb away from both fingers and both fingers stick together
% imshow('left.jpg')
% % else
% %     disp('stop')
% end
if  (A>0.4) && (A<7) && (B>0.75) && (B<20) && (C>0.35) && (C<20)
disp('STOP') %all three nearer
a= 's';

% imshow('stop.jpg')

elseif (A>0.1) && (A<0.3) && (B>0.78) && (B<0.95) && (C>0.1) && (C<0.22)
disp('LEFT') %thumb away from both fingers and both fingers stick together
% imshow('left.jpg')
a= 'l';

elseif (A>0.15) && (A<0.4) && (B>0.7) && (B<0.8) && (C>0.17) && (C<0.3)
disp('forward') %all three stick together
% imshow('forward.jpg')
a= 'f';

elseif (A>0.5) &&(A<0.9) && (B>0.5) && (B<0.8) && (C>0.3)  && (C<0.6) 
    disp('right') %broad fingers and thumb
a= 'r';

else
   a= 's';
   disp('STOP')
% elseif (A<0.40) && (A>0.25) && B<0.9 && B>0.75 && C>0.2 && C<0.3
%     disp('stop') thumb on ring finger
% imshow('right.jpg')
% else
%     disp('stop')
end

% Opening serial port and writing content to serial port
fopen(s)
fwrite(s,a);
fclose(s);

% imshow(binFrameGreen);
% imshow(binFrameRed);
% imshow(binFrameBlue);

% imshow(rgbFrame);
% impixelinfo
 end 
