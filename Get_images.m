clear all;
vid = videoinput('kinect',1);
vid2 = videoinput('kinect',2);
% Get the source properties for the depth device.
srcDepth = getselectedsource(vid2);
% Set the frames per trigger for both devices to 1.
vid.FramesPerTrigger = 1;
vid2.FramesPerTrigger = 1;
% Set the trigger repeat for both devices to 200, in order to acquire 201 frames from both the color sensor and the depth sensor.
vid.TriggerRepeat = 1000000;
vid2.TriggerRepeat = 1000000;
% Configure the camera for manual triggering for both sensors.
triggerconfig([vid vid2],'manual');
% Start both video objects.
start([vid vid2]);
% Trigger the devices, then get the acquired data.

DlgH=figure;
H = uicontrol('Style', 'PushButton', ...
                    'String', 'Break', ...
                    'Callback', 'delete(gcbf)');
imgColor=[];
imgDepth=[];
while(ishandle(H))
    % Trigger both objects.
    trigger([vid vid2])
    % Get the acquired frames and metadata.
    imgColor=cat(5,imgColor,getdata(vid));
    imgDepth=cat(5,imgDepth,getdata(vid2));
end
stop(vid);
stop(vid2);
delete(vid);
delete(vid2);

    