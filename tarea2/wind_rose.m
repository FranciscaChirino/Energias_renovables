function wind_rose(wind_direction,wind_speed)
%WIND_ROSE Plot a wind rose
%   this plots a wind rose
figure
pax = polaraxes;
polarhistogram(deg2rad(wind_direction(wind_speed<10)),deg2rad(0:10:360),'displayname','8 - 10 m/s')
hold on
polarhistogram(deg2rad(wind_direction(wind_speed<8)),deg2rad(0:10:360),'FaceColor','red','displayname','6 - 8 m/s')
polarhistogram(deg2rad(wind_direction(wind_speed<6)),deg2rad(0:10:360),'FaceColor','yellow','displayname','4 - 6 m/s')
polarhistogram(deg2rad(wind_direction(wind_speed<4)),deg2rad(0:10:360),'FaceColor','green','displayname','2 - 4 m/s')
polarhistogram(deg2rad(wind_direction(wind_speed<2)),deg2rad(0:10:360),'FaceColor','blue','displayname','0 - 2 m/s')
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
legend('Show')
title('Wind Rose')

indx=find(wind_speed==0);
calm=(length(indx)./length(wind_speed)).*100;

annotation('textbox',[.7 .6 .1 .2],'String',['Porcentaje de calma: ', num2str(calm)],'EdgeColor','none');

end