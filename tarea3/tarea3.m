%% 
%Determine las dimensiones de una turbina Pelton simple que desarrolle
%160 kW bajo cargas de 81 m y 5 m. Calcule, ademas, la velocidad angular
%optima para cada caso






%% 
%Ingrese al Explorador Climatico del CR2

%http://explorador.cr2.cl

%y obtenga un año de datos de caudales para algun rıo o arroyo de la region
%del Maule, del Biobio o de la Araucania (solo un rio o arroyo) cuyo nombre
%comience con la inicial del apellido suyo:

%(a) Para su rio o arroyo, grafique los caudales diarios y los caudales clasificados.

% Convertir a objeto de fecha y hora de Matlab
load('EC_series.mat')
fecha_matlab = datetime(time, 'ConvertFrom', 'datenum'); 

%saco solo el año 2019 eso lo hago manualmente 
ano2019=fecha_matlab(4274:4638);
value2019=value(4274:4638);
tiempo=datevec(time);
%el caudal está en m3/s

%grafico los caudales diarios 

figure()
plot(ano2019,value2019,'m','linewidth',2)
title('Caudales Diarios rio Calle-Calle 2019')
grid on 
axis tight
xlabel('Año')
ylabel('Caudal m3/s')

%Ahora hago el caudal clasificado 
%ordeno de mayor a menor 
caudalordenado=sort(value2019,'descend');

figure()
plot(caudalordenado,'m','linewidth',2)
title('Caudal Clasificado rio Calle-Calle 2019')
grid on 
axis tight
xlabel('Datos')
ylabel('Caudal m3/s')


%(b) Determine el caudal que podria usarse para obtener energia hidromotriz, indicando el tipo de secci´on sobre la que trabaja (estimar ´area,
%perimetro mojado, radio hidraulico y espejo de agua). Ademas estime un
%caudal ecologico ¿que opina sobre este caudal?

%primero voy a calcular el caudal ecologico 
%para calcular el caudal ecologico 

%El caudal ecologico es el caudal minimo que debe circular como minimo por
%el rio en todo momento del año
%Habitualmente se define como el 10 % del caudal promedio durante varios
%años

%le saco la media a los datos de value 
caudal=mean(value2019)*0.1; %esto es caudal ecologico
prom=ones(365,1)*caudal;


%caudal clasificado-ecologico 
figure()
plot(caudalordenado-prom,'m','linewidth',2)
hold on 
plot(caudalordenado,'r','linewidth',2)
title('Caudal de equipamiento vs caudal Clasificado Rio Calle-Calle 2019')
legend('Caudal de equipamiento','Caudal Clasificado')
grid on 
axis tight
xlabel('Año')
ylabel('Caudal m3/s')

%el caudal de equipamiento que escogeré del grafico anterior
%es 531.893 m3/s

%ahora calcularemos los diferentes cosas, perimetro mojado etc
%para eso usaremos la formula 

%Q = v*A

%donde Q es el caudal de equipamiento 


%caudal ecologico 

figure()
plot(ano2019,(value2019-prom),'m','linewidth',2)
hold on 
plot(value2019,'r','linewidth',2)
title('Caudal Ecologico v/s Caudal Natural rio Calle-Calle 2019')
legend('Caudal Ecologico','Caudal Natural')
grid on 
axis tight
xlabel('Año')
ylabel('Caudal m3/s')



%(c) Usando Google Earth o cualquier otra forma para calcular la pendiente,
%calcule la potencia hidromotriz que se podría obtener del rıo y recomiende
%una turbina para esa potencia. Asuma valores razonables para todas los
%parametros que usted necesite y que no conozca (sus valores deben ser
%realistas).


%la pendiente que sacamos es de 20 m segun google earth 
%lo hacemos con la formula 

%Π = 8, 2Q_0*H
%H= 10 [m]
%promedio 401
potencia= 8.2*(mean(value2019))*10

%% ejercicio a eleccion 
%comparar caudales diarios de villarica vs valdivia 
%villarica 2017
ano2017=fecha_matlab(30333:30697);
value2017villa=value(30333:30697);

%valdivia 2017
value2017calle=value(3544:3908);

figure()
subplot(2,2,1)
plot(ano2017,value2017calle,'m','linewidth',2)
title('Caudal Calle Calle año 2017')
xlabel('Tiempo')
ylabel('m^3/s')
grid on 
axis tight
subplot(2,2,2)
plot(ano2017,value2017villa,'m','linewidth',2)
title('Caudal Rio Tolten Villarica año 2017')
xlabel('Tiempo')
ylabel('m^3/s')
grid on 
axis tight
subplot(2,2,[3,4])
hold on 
plot(ano2017,value2017calle,'g','linewidth',2)
plot(ano2017,value2017villa,'r','linewidth',2)
title('Caudal Calle Calle vs Tolten año 2017')
xlabel('Tiempo')
ylabel('m^3/s')
grid on 
axis tight
legend('Calle Calle','Villarica')







