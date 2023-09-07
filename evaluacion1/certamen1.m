%% 2
clear all; clc
% Baje un año de datos de vientos de algún lugar de Chile que NO haya 
% analizado anteriormente. Muestre un mapa del lugar seleccionado.
% Convierta los valores a m/s

% leo los datos de la pag
% https://agrometeorologia.cl/#
% donde elijo la estación de los Vilos
datos = xlsread('agrometeorologia-20230616152911.xlsx');

%aca tenemos los datos de viento cada una hora durante un año
%para comodidad los datos son:
%desde el 1 de octubre del 2022 a las 00:00
%hasta el 30 de septiembre a las 23:00
%para de esta forma tener un año de dato es decir 8760 filas
% la primera columna corresponde a la velocidad en km/h
% la segunda columna corresponde a Dirección de Viento º
% la tercera columna corresponde a Velocidad de Viento % de datos
% la cuarta columna corresponde a Dirección de Viento % de datos
%pero para esta tarea importaran la primera columna con la velocidad en
%km/h y la tercera columna con la direccion de viento en grados
%por lo que guardamos los datos con los datos relevantes
datos = [datos(:,1),datos(:,2)];
%vh esta en km/h lo paso a m/s divide el valor de velocidad entre 3.6
vh = datos(:,1)./3.6;
dh = datos(:,2);
%además de forma manual extraemos las fechas (solo la primera columna) de
%nuestro xlsx en formato string para luego convertirlo en formato fechas de
%matlab
load('TiempoUTC4.mat')%hecho manualmente
fecha_matlab = datetime(TiempoUTC4, 'InputFormat', 'dd-MM-yyyy HH:mm');

%% (a) Dibuje una rosa de los vientos para el periodo octubre a marzo y otra 
%para el periodo abril a septiembre.

%octubre a marzo 
%vemos fecha de octubre a marzo desde la fecha_matlab  
%asi obtenemos la posicion de las filas que nos interesan 

%hasta 4368 que es la posicion del ultimo dia de marzo 
wind_rose(dh(1:4368),vh(1:4368));

%de abril a septiembre 
wind_rose(dh(4369:end),vh(4369:end));


%% b haga un histograma  de las magnitudes de la velocidad


% Crear histograma con intervalo visible y color personalizado
figure()
histogram(vh, 'FaceColor', 'm');
% Personalizar el histograma
title('Histograma de las Magnitudes de Velocidad'); % Título del gráfico
xlabel('Valores m/s'); % Etiqueta del eje x
ylabel('Frecuencia'); % Etiqueta del eje y
grid on 
axis tight

%% c diagrama tipo chascón 

% Haga un diagrama de vector progresivo de los vientos durante todo el ano.
%hacemos un diagrama de vector progresivo
%como hacemos esto en matlab 
%tenemos que descomponer la velocidad en x y en y 
%el angulo que tenemos esta en grados y tiene que estar en radianes

vo = vh;
vx = - vo.*sind(dh); 
vy = - vo.*cosd(dh);

%despues lo sumamos la suma reiterativa tiene funcion en matlab y se llama
%cumsum(vx) suma de los elementos anteriores

x = cumsum(vx)*3600; %multiplico por 3600 para así tener distancia
y = cumsum(vy)*3600;

%multiplico por 3600 para asi tener distancia por que el vector progresivo
%nos dice hacia donde se mueven los vientos 

figure()
plot(x,y,'r','linewidth',2)
title('Diagrama de vector progresivo')
xlim([-7e6 0])
ylim([-7e6 0])
xlabel('Metros')
ylabel('Metros')
grid on 

%%

% d) Calcule los par´ametros necesarios y muestre gr´aficamente la 
% distribuci´on de Weibull para los datos sin normalizar y para los valores
% normalizados. Muestre sus c´alculos. Compare los par´ametros obtenidos 
% por su ajuste con los que entrega el siguiente c´odigo


%% c Muestre graficamente la distribucion de Weibull para esos datos.

%su formula es 
%p(x) =  k/c * [x/c]^(k-1)*e^-(x/c)^k

%con x la velocidad normalizada 

%ordenamos los datos
d_ord=sort(vh);

%normalizamos los datos ordenados 
x=d_ord./(nanmean(d_ord));

%calculamos k y c
%la k se calcula con los datos normalizados 
k = (nanstd(x)./nanmean(x))^-1.086;

% c se calcula con la funcion gamma

c = 1/gamma(1+1/k);

p = (k/c).*(x/c).^(k-1).*exp(-(x./c).^k); 

figure()
plot(x,p,'c','linewidth',2)
title('Distribución de Weibull normalizada')
%ylim([0 1])
ylabel('probabilidad')
xlabel('Velocidad del viento [m/s] normalizada]')
grid on 
axis tight


%no normalizada
%no normalizado
media = nanmean(vh);
x2 = sort(vh);
velocidad2 =nanstd(vh);
k= ((0.9874) /( velocidad2 / media )) ^1.0983;
c = media / gamma (1 + 1/ k );
p2 =( k/ c) *(( x2 ./ c) .^( k -1) ) .* exp ( -( x2 ./( c )) .^ k);

figure()
plot(x2,p2,'m','linewidth',2)
title('Distribución de Weibull NO normalizada')
%ylim([0 1])
ylabel('probabilidad')
xlabel('Velocidad del viento [m/s] NO normalizada')
grid on 
axis tight

%% d

%revisar la distribucion de weibull por que no da 
%el oscar lo hizo asi 
%2e %tiempo v
t2 = (exp(-(3/mean(vh))*gamma(1+(1/k)))^k) - (exp(-(12/mean(vh))*gamma(1+(1/k)))^k);
%este t2 esta en decimal, hay que multiplicarlo por 100
t2porcentaje=t2*100;



%% 3
clear all
clc

% produccion de energia 
%datos obtenidos de coordinador electrico nacional 
%https://www.coordinador.cl/

[datos, texto, alldata] = xlsread('CEN-hist_cap_inst_por_tecnologia.xlsx',2);

fechas=datos(:,1);
hidrico=datos(:,2);
carbon=datos(:,3);
diesel=datos(:,4);
gas_natural=datos(:,5);
eolico=datos(:,6);
solar=datos(:,7);
termosolar=datos(:,8);
geotermico=datos(:,9);

datoss=[hidrico,eolico,solar,termosolar,geotermico,carbon,diesel,gas_natural];

%sumo el total de energía renovable
total_reno= hidrico+eolico+solar+termosolar+geotermico;


% porcentajes total de energía renovable
porcentaje_total = (total_reno ./ nansum(datoss,2)) * 100;


% porcentajes
porcentajes = (datoss ./ nansum(datoss, 2)) * 100;


%  Participación relativa por fuente de generación [%]

colors = {'b','c','y',[0.4660, 0.6740, 0.1880],'r','k','g',[0.2 0.2 0.2]};
figure()
b= bar(fechas,porcentajes, 'stacked');
for i = 1:numel(b)
    b(i).FaceColor = colors{i};
end
hold on 
plot(fechas,porcentaje_total, 'm-', 'LineWidth', 3)
grid on 
axis tight
legend('hidrica','carbón','diesel','gas natural','eolico','solar','termosolar','geotermico','total renovable')
xlabel('Años')
ylabel('Porcentaje')
title(' Participación relativa por fuente de generación [%]')
% Etiqueta con porcentaje total
text(fechas, porcentaje_total, num2str(porcentaje_total, '%.1f%%'), 'Color', 'm', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')



%volumen de energia generada por fuente 


colors = {'b','k','g',[0.2 0.2 0.2],'c','y',[0.4660, 0.6740, 0.1880],'r'};
figure()
b= bar(fechas,datos(:,2:9), 'stacked');
for i = 1:numel(b)
    b(i).FaceColor = colors{i};
end
grid on 
axis tight
legend('hidrica','carbón','diesel','gas natural','eolico','solar','termosolar','geotermico')
xlabel('Años')
ylabel('[MW]')
title('Volumen de energia generada por fuente')




