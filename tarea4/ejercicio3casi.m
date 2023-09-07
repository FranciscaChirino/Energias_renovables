clear all; clc 

%el dia de mi cumpleaños todo el dia, para que me varie el angulo que me
%piden

year=2023;
mes=3; %mayo
dia=23;
hora=[8:17];
minuto=15;


location.longitude=-73;
location.latitude=-37; %estructura
location.altitude=25; %25 msnm

for i=1:10
[zenith(i),azimuth(i)]=sun_position(year,mes,dia,hora(i),minuto,location);

elevacion(i)=90-zenith(i);

end

%% 1
%saco vectores unitarios 
%n con respecto al terreno
%con un azimuth de de 30 y elevacion de 45
%estos son dados

%primer caso
azimuth_terreno=90; %dados
elevacion_terreno=40;%dado
n = [sind(azimuth_terreno)*sind(elevacion_terreno), cosd(azimuth_terreno)*sind(elevacion_terreno),cosd(elevacion_terreno)];


%ahora saco vector unitario solar para esto usamos los valores de la
%funcion 
%pq son los angulos solares

for i=1:10
s(i,:) = [sind(azimuth(i))*cosd(elevacion(i)), cosd(azimuth(i))*cosd(elevacion(i)), sind(elevacion(i))];
end

%calculamos angulo de incidencia
%angulo que se forma entre n y s

for i=1:10
tetha_90(i,:)=acosd(dot(s(i,:),n));
end


%segundo caso
azimuth_terreno=180; %dados
elevacion_terreno=40;%dado
n = [sind(azimuth_terreno)*sind(elevacion_terreno), cosd(azimuth_terreno)*sind(elevacion_terreno),cosd(elevacion_terreno)];


%ahora saco vector unitario solar para esto usamos los valores de la
%funcion 
%pq son los angulos solares

for i=1:10
s(i,:) = [sind(azimuth(i))*cosd(elevacion(i)), cosd(azimuth(i))*cosd(elevacion(i)), sind(elevacion(i))];
end

%calculamos angulo de incidencia
%angulo que se forma entre n y s

for i=1:10
tetha_180(i,:)=acosd(dot(s(i,:),n));
end

%tercer caso
azimuth_terreno=270; %dados
elevacion_terreno=40;%dado
n = [sind(azimuth_terreno)*sind(elevacion_terreno), cosd(azimuth_terreno)*sind(elevacion_terreno),cosd(elevacion_terreno)];


%ahora saco vector unitario solar para esto usamos los valores de la
%funcion 
%pq son los angulos solares

for i=1:10
s(i,:) = [sind(azimuth(i))*cosd(elevacion(i)), cosd(azimuth(i))*cosd(elevacion(i)), sind(elevacion(i))];
end

%calculamos angulo de incidencia
%angulo que se forma entre n y s

for i=1:10
tetha_270(i,:)=acosd(dot(s(i,:),n));
end


%cuarto  caso
azimuth_terreno=0; %dados
elevacion_terreno=40;%dado
n = [sind(azimuth_terreno)*sind(elevacion_terreno), cosd(azimuth_terreno)*sind(elevacion_terreno),cosd(elevacion_terreno)];


%ahora saco vector unitario solar para esto usamos los valores de la
%funcion 
%pq son los angulos solares

for i=1:10
s(i,:) = [sind(azimuth(i))*cosd(elevacion(i)), cosd(azimuth(i))*cosd(elevacion(i)), sind(elevacion(i))];
end

%calculamos angulo de incidencia
%angulo que se forma entre n y s

for i=1:10
tetha_0(i,:)=acosd(dot(s(i,:),n));
end



%% ahora caso Norte-Sur es decir tetha 0 y 180
figure()
plot(hora, tetha_0, 'c', 'linewidth', 3)
hold on
plot(hora, tetha_180, 'm', 'linewidth', 3)
legend('Ladera hacia el Norte', 'Ladera hacia el Sur')
xlabel('Hora')
ylabel('Grados°')
title('Casa orientada Norte-Sur')
grid on 
axis tight

% Especificar valores y etiquetas del eje x
xticks(hora)
xticklabels(hora)

% Ajustar los márgenes del eje x
xlim([8 17])



%% ahora caso este-oeste tetha 90 y 270

figure()
plot(hora,tetha_90,'linewidth',3)
hold on
plot(hora,tetha_270,'linewidth',3)
legend('Ladera hacia el Este','Ladera hacia el Oeste')
xlabel('Hora')
ylabel('Grados°')
title('Casa orientada Oeste-Este')
grid on
axis tight
% Especificar valores y etiquetas del eje x
xticks(hora)
xticklabels(hora)
% Ajustar los márgenes del eje x
xlim([8 17])






