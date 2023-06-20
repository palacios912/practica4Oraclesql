drop table fabricante
describe articulo

create table articulo (
    codigo number (4) primary key,
    descripcion varchar2(40 ) not null,
    precio number(10,2),
    fabricante_codigo number(6) not null
);
select * from articulo;
create table fabricante (
codigo number (6) generated always as identity primary key,
razon_social varchar2(50) not null
);



select * from articulo order by codigo;
--apartir del codigo 30 hay claves repetidas con las mismas caracteristicas. se las eliminó en la carga de datos del excel

-- 3. Actualizar los precios de los artículos que tengan un precio entre $12500 y $ 38000 a $ 56000
update articulo
set precio = 56000
where precio between 12500 and 38000;
commit;

-- 4. Listar los datos artículos cuyos precios sean menores de $15000.
select * from articulo 
where  precio < 15000;

-- 5.Eliminar todos los artículos con precios mayores a $ 2.000.000 y del fabricante con código 4
delete from articulo 
where precio > 2000000 and fabricante_codigo = 4;


--6 Listar todos los artículos con una descripción que contenga la palabra “ropa”.

select * from articulo
where descripcion like '%ROPA%';

-- 7 Listar los fabricantes cuya razón social comience con “FR”

select * from articulo
where upper(razon_social) like 'FR%';


--8 Aumentar los precios de todos los artículos en un 5%

update articulo
set precio = precio * 1.05;

--9. Realizar un aumento de un 15% en aquellos productos que sean de los fabricantes con códigos 2 y 3.
update articulo
set precio = precio *1.15
where fabricante_codigo = 2 or fabricante_codigo = 3;

--10. Indicar cual es el mayor precio que tiene cada fabricante.

select fabricante_codigo, max(precio) as precio
from articulo
group by fabricante_codigo;

-- 11 Obtener los nombres de los fabricantes que ofrezcan productos con precio medio mayor a $8500.

select razon_social, avg(precio) as precio
from articulo 
left join fabricante on fabricante_codigo=fabricante.codigo 
group by razon_social 
having avg(precio)>8500;

-- 12 Mostrar el promedio de precios de todos los artículos de cada uno de los fabricantes.

select razon_social, avg(precio) 
from articulo 
left join fabricante on  fabricante_codigo = fabricante.codigo 
group by razon_social;

-- 13 Obtener el precio medio de los productos de cada fabricante mostrando el nombre del fabricante.

select f.razon_social, avg(precio) 
from articulo a
left join fabricante f on a.fabricante_codigo  = f.codigo 
group by razon_social;

-- 14 Mostrar cuál es la cantidad de proveedores, fabricantes, que tiene la empresa.

select count(codigo) as cantidad_fabricantes
from fabricante;

-- 15 Se necesita saber cuántos productos provee cada fabricante.

select f.razon_social, count (a.fabricante_codigo) as articulos
from articulo a 
left join fabricante f on a.fabricante_codigo = f.codigo 
group by f.razon_social;

-- 16 Listar nombres y precios de los artículos más caros de cada fabricante con el nombre de éste.

select f.razon_social, MAX(a.precio) as precio
from articulo a
left join fabricante f on a.fabricante_codigo = f.codigo 
group by f.razon_social;

-- 17 Listar la Razón Social de los Fabricantes que no nos proveen  artículos actualmente.

select f.razon_social
from fabricante f 
left join articulo a on a.fabricante_codigo = f.codigo
where a.fabricante_codigo IS NULL;

-- 18 Listar los Fabricantes que nos proveen más de tres artículos.

select  fabricante.razon_social, count(fabricante_codigo) as cantidad
from fabricante
left join articulo a on a.fabricante_codigo = fabricante.codigo 
group by fabricante.razon_social
having count(a.codigo)>3;

-- 19 Obtener los nombres de los productos que nos proveen el  fabricante ‘Kerflex’

select articulo.descripcion
from articulo 
left join fabricante on fabricante.codigo = articulo.fabricante_codigo
where fabricante.razon_social = 'Kerflex';






