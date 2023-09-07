%% ejercicio 1

clc
clear all


year=2023;
mes=1:12; %mayo
dia=[31 28 31 30 31 30 31 31 30 31 30 31];
hora=1:24;
minuto=23;

%location hay que ingresarla con estructura 

%vemos una app para ver lon lat y altura a la que estamos 
%necesitamos 4 decimales 
%por ej google maps
%location nombre de la estructura

%debe ser en ingles
location.longitude=-70;
location.latitude=-34; %estructura
location.altitude=5; %5 msnm

%para todo el año modifico la funcion para que me de los angulos para cada
%hora durante un año, es decir tengo 8760 datos

c=0;
    for j=1:12
    for k=1:dia(j)
    for i=1:24
 c=c+1;
        [zenith(c),azimuth(c)]=sun_position(year,mes(j),k,hora(i),minuto,location);

    end
    end
    end
    
    
    
    
azimuth=azimuth';
zenith=zenith';


%elevacion= 90-zenith
elevacion=90-zenith;

%para que me quede en el eje x las fechas 
% Definir el año
year = 2023;

% Crear un vector de fechas para todas las horas del año
start_date = datetime(year, 1, 1, 0, 0, 0);  % Fecha de inicio: 1 de enero del año especificado a las 00:00:00
end_date = datetime(year, 12, 31, 23, 0, 0);  % Fecha de fin: 31 de diciembre del año especificado a las 23:00:00
dates_vector = start_date : hours(1) : end_date;  % Vector de fechas con incremento horario



figure()
plot(dates_vector,elevacion,'m')
grid on 
axis tight
title('Ángulo de elevacion durante un año cada hora')
xlabel('Fecha')
ylabel('grados')

figure()
plot(dates_vector,azimuth,'c')
grid on
axis tight 
title('Ángulo de Azimuth durante un año cada hora')
xlabel('Fecha')
ylabel('grados')

%% 2

%calculamos AM masa atmosferica
clear all
clc

year=2023;
mes=1:12; 
dia=[31 28 31 30 31 30 31 31 30 31 30 31];
hora=12; %vamos de 7 a 17 y asi obtener solo los dias con son para no tener complejos
minuto=23;

location.longitude=-70;
location.latitude=-34; %estructura
location.altitude=5; %5 msnm


c=0;
    for j=1:12
    for k=1:dia(j)
    
 c=c+1;
        [zenith(c),azimuth(c)]=sun_position(year,mes(j),k,hora,minuto,location);

    
    end
    end
    
    
%sacamos un promedio cada 10 horas para asi obtener un promedio diario
 
am = 1./cosd(zenith)+0.50572*((96.07995-zenith).^-1.6364);
  
Fam = ((0.7).^am).^0.678;



%sacamos el promedio diario para asi poder trabajar despues con los dias
%julianos  
  
  
elevacion=90-zenith;

%calculo la radiancia
  
%ahora calculamos la irradiancia 

%irradiancia I = Fam * Ics * sen(elevacion) * Fts
%Fts = 1+0.034(cosyprima)
%yprima= 2*pi*(j-1)/365.25
%con j dia juliano en el caso de 29 de mayo corresponde al dia 148

juliano=[1:365];
Ics= 1361;
elevacion=90-zenith;
yprima= (2*pi*(juliano-1))/365.25; %no se si es en rad o grados 
Fts=1+0.034*(cosd(yprima));


I= Fam.*Ics.*sind(elevacion).*Fts;


% Definir el año
year = 2023;

% Crear un vector de fechas para todo el año
start_date = datetime(year, 1, 1);  % Fecha de inicio: 1 de enero del año especificado
end_date = datetime(year, 12, 31);  % Fecha de fin: 31 de diciembre del año especificado
dates_vector = start_date : days(1) : end_date;  % Vector de fechas con incremento diario



figure()
plot(dates_vector,I,'m','linewidth',2)
grid on
axis tight
title('Radiancia máxima durante todo el año para la zona de estudio')
xlabel('Fechas')
ylabel('W/m^2')


%% 3 

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


%% EJERCICIO A ELECCION 

clear all; clc 

%el dia de mi cumpleaños todo el dia, para que me varie el angulo que me
%piden

year=2023;
mes=3; %mayo
dia=23;
hora=[8:17];
minuto=15;


location.longitude=-73;
location.latitude=37; %estructura
location.altitude=25; %25 msnm

for i=1:10
[zenith(i),azimuth(i)]=sun_position(year,mes,dia,hora(i),minuto,location);

elevacion(i)=90-zenith(i);

end

%% 1


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





