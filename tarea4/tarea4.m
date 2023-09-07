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
% 
% 3. Una casa de Concepci´on tiene el techo en forma de Λ (o sea, es ‘de dos
% aguas’), en que el ´angulo interno (total, medido por debajo del techo) es de
% 100º. Haga un gr´afico que muestre el ´angulo de incidencia de la radiaci´on
% solar directa sobre el techo para el d´ıa de su cumplea˜nos:
% (a) si la casa est´a orientada en direcci´on norte-sur, y
% (b) si la casa est´a orientada en direcci´on este-oeste.
% Su gr´afico deber´ıa mostrar cuatro curvas (dos techos, y dos casos
  
clear all; clc 

%el dia de mi cumpleaños todo el dia, para que me varie el angulo que me
%piden

year=2023;
mes=3; %mayo
dia=23;
hora=8;
minuto=15;


location.longitude=-73.037327;
location.latitude=-36.830616; %estructura
location.altitude=25; %25 msnm

[zenith,azimuth]=sun_position(year,mes,dia,hora,minuto,location);

%ahora tenemos el zenith 
% es 76.6159

%calculamos AM 

am = 1/cosd(zenith)+0.50572*((96.07995-zenith)^-1.6364);

Fam = ((0.7)^am)^0.678;

%ahora calculamos la irradiancia 

%irradiancia I = Fam * Ics * sen(elevacion) * Fts
%Fts = 1+0.034(cosyprima)
%yprima= 2*pi*(j-1)/365.25
%con j dia juliano en el caso de 23 de marzo corresponde al dia 82

Ics= 1361;
elevacion=90-zenith;
yprima= (2*pi*(82-1))/365.25; %no se si es en rad o grados 
Fts=1+0.034*(cosd(yprima));


I= Fam*Ics*sind(elevacion)*Fts;

%% 1 
%saco vectores unitarios 
%n con respecto al terreno
%con un azimuth de de 30 y elevacion de 45
%estos son dados

%primer caso
azimuth_terreno=0; %dados
elevacion_terreno=40;%dado
n = [sind(azimuth_terreno)*sind(elevacion_terreno), cosd(azimuth_terreno)*cosd(elevacion_terreno),cosd(elevacion_terreno)];


%ahora saco vector unitario solar para esto usamos los valores de la
%funcion 
%pq son los angulos solares

s = [sind(azimuth)*cosd(elevacion), cosd(azimuth)*cos(elevacion), sind(elevacion)];

%calculamos angulo de incidencia
%angulo que se forma entre n y s 
tetha=acosd(dot(s,n));

%saco la radiancia directa 
I_inclinada_directa=(I*cosd(tetha))/sind(elevacion);



%ahora para todo el dia 

clear all; clc 

%el dia de mi cumpleaños todo el dia, para que me varie el angulo que me
%piden

year=2023;
mes=3; %mayo
dia=23;
hora=1:24;
minuto=15;


location.longitude=-73.037327;
location.latitude=-36.830616; %estructura
location.altitude=25; %25 msnm

for i=1:24
[zenith(i),azimuth(i)]=sun_position(year,mes,dia,hora(i),minuto,location);
end

%ahora tenemos el zenith 
% es 76.6159

%calculamos AM 

am = 1./cosd(zenith)+0.50572*((96.07995-zenith).^-1.6364);

Fam = ((0.7).^am).^0.678;

%ahora calculamos la irradiancia 

%irradiancia I = Fam * Ics * sen(elevacion) * Fts
%Fts = 1+0.034(cosyprima)
%yprima= 2*pi*(j-1)/365.25
%con j dia juliano en el caso de 23 de marzo corresponde al dia 82

Ics= 1361;
elevacion=90-zenith;
yprima= (2*pi*(82-1))/365.25; %no se si es en rad o grados 
Fts=1+0.034*(cosd(yprima));


I= Fam.*Ics.*sind(elevacion)*Fts;

%% 1 
%saco vectores unitarios 
%n con respecto al terreno
%con un azimuth de de 30 y elevacion de 45
%estos son dados

%primer caso
azimuth_terreno=0; %dados
elevacion_terreno=40;%dado
n = [sind(azimuth_terreno)*sind(elevacion_terreno), cosd(azimuth_terreno)*cosd(elevacion_terreno),cosd(elevacion_terreno)];
x = repmat(n, 24, 1);

%ahora saco vector unitario solar para esto usamos los valores de la
%funcion 
%pq son los angulos solares

s = [sind(azimuth).*cosd(elevacion), cosd(azimuth).*cos(elevacion), sind(elevacion)];
s =reshape(s,24,3);

%calculamos angulo de incidencia
%angulo que se forma entre n y s 
tetha=acosd(dot(s,n));

%saco la radiancia directa 
I_inclinada_directa=(I.*cosd(tetha))./sind(elevacion);





