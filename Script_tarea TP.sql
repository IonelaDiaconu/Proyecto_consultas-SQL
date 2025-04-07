
-- 1. Crea el esquema de la BBDD.

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.

SELECT "title" AS "nombre de película","rating" AS "clasificación"
FROM "film"
WHERE "rating"='R';

--3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.

SELECT "actor_id","first_name","last_name"
FROM "actor"
WHERE "actor_id" BETWEEN'30' AND '40';

--4. Obtén las películas cuyo idioma coincide con el idioma original.

SELECT  "film_id", "title" AS "película", "original_language_id"
FROM "film";

SELECT f."title" AS "titulo_pelicula", l."name" AS "idioma"  
FROM "film" f  
JOIN "language" l ON f."language_id" = l."language_id"
WHERE f."language_id" = f."original_language_id";


--5. Ordena las películas por duración de forma ascendente.

SELECT "film_id", "title" AS "película", "length" AS "duración"
FROM "film"
ORDER BY "length" ASC;

--6.Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.

SELECT "actor_id", "first_name" AS "nombre","last_name" AS "apellido"
FROM "actor" 
WHERE "last_name"='ALLEN';

--7.Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.

SELECT "rating" AS "clasificación", COUNT ("film") AS "total_películas"
FROM "film"
GROUP BY "rating";

--8. Encuentra el título de todas las películas que son ‘PG13ʼ o tienen una duración mayor a 3 horas en la tabla film.

SELECT "film_id","title" AS "película","rating" AS "clasificación","length" AS "duración"
FROM "film"
WHERE "rating"='PG-13'
AND "length">'180';

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT ROUND (VARIANCE("replacement_cost"),2) AS "varianza_reemplazo",
	ROUND (STDDEV("replacement_cost"),2) AS "desviación_reemplazo"
FROM"film";

--10.Encuentra la mayor y menor duración de una película de nuestra BBDD

SELECT MAX ("length") AS "mayor_duración",
	MIN ("length")AS "menor_duración"
FROM "film";

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT "payment_id" AS"id_alquiler", "amount" AS"precio_alquiler"
FROM "payment"
ORDER BY "rental_id" DESC;

--12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC 17ʼ ni ‘Gʼ en cuanto a su clasificación.

SELECT "title" AS"titulo_pelicula", "rating" AS"clasificacion"
FROM "film" 
WHERE "rating"  NOT IN ('NC-17', 'G');

--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

SELECT "rating"AS"clasificacion", ROUND (AVG("length"),2) AS "promedio_duracion"
FROM "film"
GROUP BY "rating";

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

SELECT "title" AS "titulo_pelicula", "length" AS "duracion"
FROM "film"
WHERE "length" > 180;

--15. ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM("amount") AS "total_generado"
FROM "payment";

--16. Muestra los 10 clientes con mayor valor de id.

SELECT "customer_id" AS "valor_id", "first_name" AS  "nombre", "last_name" AS "apellido"
FROM "customer"
ORDER BY "customer_id"  DESC
LIMIT 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.

SELECT a."first_name" AS "nombre", a."last_name" AS"apellido", f."title" AS "titulo" 
FROM "actor" a
JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
JOIN "film" f ON fa."film_id" = f."film_id"
WHERE f."title" = 'EGG IGBY';

--18. Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT "title" AS "nombre_pelicula"
FROM "film";

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.

SELECT f."title" AS "titulo_pelicula", f. "length" AS "duracion" , c."name" AS"categoria"
FROM "film" f  
JOIN "film_category" fc ON f."film_id" = fc."film_id"  
JOIN "category" c ON fc."category_id" = c."category_id"  
WHERE c."name" = 'Comedy'  
AND f."length" > 180;

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

SELECT c."name" AS "categoria", ROUND (AVG(f."length"),2) AS "promedio_duracion"  
FROM "film" f  
JOIN "film_category" fc ON f."film_id" = fc."film_id"  
JOIN "category" c ON fc."category_id" = c."category_id"  
GROUP BY c."name"  
HAVING AVG(f."length") > 110;

--21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT ROUND (AVG(EXTRACT(DAY FROM AGE("return_date", "rental_date"))),2) AS "media_duracion_alquiler"  
FROM "rental";

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT CONCAT("first_name", ' ', "last_name") AS nombre_completo  
FROM actor;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT DATE("rental_date") AS "fecha", COUNT(*) AS "numero_alquileres"  
FROM "rental"  
GROUP BY DATE("rental_date")  
ORDER BY "numero_alquileres" DESC;

--24. Encuentra las películas con una duración superior al promedio.

SELECT "title" AS "titulo_pelicula" , "length" AS"duracion"  
FROM "film"  
WHERE "length" > (SELECT AVG("length") FROM "film");

--25. Averigua el número de alquileres registrados por mes.

SELECT TO_CHAR("rental_date", 'YYYY-MM') AS "mes", COUNT(*) AS "numero_alquileres"  
FROM "rental"  
GROUP BY "mes"  
ORDER BY "mes";

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT  
    ROUND (AVG("amount"),2) AS"promedio",  
    ROUND (STDDEV("amount"),2) AS "desviacion_estandar",  
    ROUND (VARIANCE("amount"),2) AS "varianza"  
FROM "payment";

--27. ¿Qué películas se alquilan por encima del precio medio?

SELECT "title" AS "titulo_pelicula", "rental_rate" AS "precio_alquiler"  
FROM "film"  
WHERE "rental_rate" > (SELECT AVG("rental_rate") FROM "film");

--28. Muestra el id de los actores que hayan participado en más de 40 películas.

SELECT fa."actor_id" AS "id_actor"  
FROM "film_actor" fa  
GROUP BY fa."actor_id"  
HAVING COUNT(fa."film_id") > 40;

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT f."title" AS "titulo_pelicula", COUNT(i. "inventory_id") AS "cantidad disponible"      
FROM "film"f 
LEFT JOIN "inventory" i ON f."film_id" = i."film_id"
GROUP BY f. "title"
HAVING COUNT (i."inventory_id")>0;

--30. Obtener los actores y el número de películas en las que ha actuado.

SELECT a."actor_id", a."first_name" AS "nombre", a."last_name" AS "apellido", COUNT(fa."film_id") AS "numero_peliculas"  
FROM "actor" a  
JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"  
GROUP BY a."actor_id", a."first_name", a."last_name"
ORDER BY numero_peliculas ASC; 

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

SELECT f."title" AS "pelicula", 
       CONCAT(a."first_name", ' ', a."last_name") AS "actores"  
FROM "film" f  
LEFT JOIN "film_actor" fa ON f."film_id" = fa."film_id"  
LEFT JOIN "actor" a ON fa."actor_id" = a."actor_id";


--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

SELECT 
       CONCAT(a."first_name", ' ', a."last_name") AS "actor" , f."title" AS "pelicula" 
FROM "actor" a  
LEFT JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"  
LEFT JOIN "film" f ON fa."film_id" = f."film_id";

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT f."film_id" AS "id_pelicula",
       f."title" AS "titulo_pelicula",
       r."rental_id" "id_alquiler",
       r."rental_date" AS "fecha_alquiler",
       r."customer_id" AS "id_cliente"
FROM "film" f
LEFT JOIN "inventory" i ON f."film_id" = i."film_id"
LEFT JOIN "rental" r ON i."inventory_id" = r."inventory_id";

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT c."customer_id",
        CONCAT(c."first_name", ' ', c."last_name") AS "cliente"
FROM "customer" c  
JOIN "payment" p ON c."customer_id" = p."customer_id"  
GROUP BY c."customer_id", c."first_name", c."last_name"   
LIMIT 5;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT "actor_id", "first_name" AS "nombre", "last_name" AS "apellido"  
FROM "actor"
WHERE "first_name"='JOHNNY';

--36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.

SELECT "actor_id", "first_name" AS "Nombre", "last_name" AS "Apellido"  
FROM "actor"; 

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT 
    MIN("actor_id") AS "actor_mas_bajo", 
    MAX("actor_id") AS "actor_mas_alto"  
FROM "actor";

--38. Cuenta cuántos actores hay en la tabla “actorˮ.

SELECT COUNT(*) AS "total_actores"  
FROM "actor";

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT "actor_id", "first_name" AS "Nombre", "last_name" AS "Apellido"  
FROM "actor"
ORDER BY "Apellido" ASC; 

--40. Selecciona las primeras 5 películas de la tabla “filmˮ.

SELECT "title" as "titulo_pelicula"
FROM "film"
LIMIT 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

SELECT "first_name" AS "nombre", 
       COUNT(*) AS "cantidad"  
FROM "actor"  
GROUP BY "first_name"  
ORDER BY "cantidad" DESC  
LIMIT 1;

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

SELECT "rental_id" AS "id_alquiler",
	CONCAT(c."first_name", ' ', c."last_name") AS "cliente"
FROM "rental" r 
LEFT JOIN "customer" c ON r."customer_id" = c."customer_id" ;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

SELECT c."customer_id", 
       CONCAT(c."first_name", ' ', c."last_name") AS "cliente",
       r."rental_id" AS "id_alquiler" 
FROM "customer" c  
LEFT JOIN "rental" r ON c."customer_id" = r."customer_id"  
ORDER BY c."customer_id";

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

SELECT f."title" AS "pelicula", 
       c."name" AS "categoria"  
FROM "film" f  
CROSS JOIN "category" c;

--La consulta no aporta valor dado que una película no pertenece a todas las categorías, sino solo a una o varias.

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.

SELECT DISTINCT a."actor_id" AS "id_actor", 
       CONCAT(a."first_name", ' ', a."last_name") AS "cliente",
       c."name" AS "categoria"
FROM "actor" a  
JOIN "film_actor" fa ON a.actor_id = fa."actor_id"  
JOIN "film" f ON fa."film_id" = f."film_id"  
JOIN "film_category" fc ON f."film_id" = fc."film_id"  
JOIN "category" c ON fc."category_id" = c."category_id"  
WHERE c."name" = 'Action';

--46. Encuentra todos los actores que no han participado en películas.

SELECT a."actor_id", 
      CONCAT(a."first_name", ' ', a."last_name") AS "actor" 
FROM "actor" a  
LEFT JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"  
WHERE fa."film_id" = 0;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

SELECT CONCAT(a."first_name", ' ', a."last_name") AS "actor", 
       COUNT(fa."film_id") AS "cantidad_peliculas"  
FROM "actor" a  
JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"  
GROUP BY a."actor_id", a."first_name", a."last_name"
ORDER BY "cantidad_peliculas" ASC;

--48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.

CREATE OR REPLACE VIEW "actor_num_peliculas" AS
SELECT CONCAT(a."first_name", ' ', a."last_name") AS "actor",  
       COUNT(fa."film_id") AS "cantidad_peliculas"  
FROM "actor" a  
JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"  
GROUP BY a."actor_id", a."first_name", a."last_name"
ORDER BY "cantidad_peliculas" ASC;

--49. Calcula el número total de alquileres realizados por cada cliente.

SELECT c."customer_id", 
       CONCAT(c."first_name", ' ', c."last_name") AS "cliente",
       COUNT(r."rental_id") AS "total_alquileres"  
FROM "customer" c  
JOIN "rental" r ON c."customer_id" = r."customer_id"  
GROUP BY c."customer_id", c."first_name", c."last_name"  
ORDER BY "total_alquileres" asc;

--50. Calcula la duración total de las películas en la categoría 'Action'.

SELECT SUM(f."length") AS "duracion_total" 
FROM "film" f  
JOIN "film_category" fc ON f."film_id" = fc."film_id"  
JOIN "category" c ON fc."category_id" = c."category_id"  
WHERE c."name" = 'Action';

--51. Crea una tabla temporal llamada cliente_rentas_temporal para almacenar el total de alquileres por cliente.

DROP TABLE IF EXISTS "cliente_rentas_temporal";
CREATE TEMPORARY TABLE "cliente_rentas_temporal" AS
SELECT c."customer_id", 
       COUNT(r."rental_id") AS "total_alquileres"
FROM "customer" c  
JOIN "rental" r ON c."customer_id" = r."customer_id"
GROUP BY c."customer_id";

--52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.

CREATE TEMP TABLE "peliculas_alquiladas" AS
SELECT f."film_id", f."title", COUNT(r."rental_id") AS total_alquileres
FROM "film" f
JOIN "inventory" i ON f."film_id" = i."film_id"
JOIN "rental" r ON i."inventory_id" = r."inventory_id"
GROUP BY f."film_id", f."title"
HAVING COUNT(r."rental_id") >= 10;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

SELECT f."title" as "titulo_pelicula", 
		CONCAT(c."first_name", ' ', c."last_name") AS "cliente"
FROM "customer" c
JOIN "rental" r ON c."customer_id" = r."customer_id"
JOIN "inventory" i ON r."inventory_id" = i."inventory_id"
JOIN "film" f ON i."film_id" = f."film_id"
WHERE c."first_name" = 'TAMMY' 
  AND c."last_name" = 'SANDERS'
  AND r."return_date" IS NULL
ORDER BY f."title" ASC;

--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.

SELECT DISTINCT CONCAT(a."first_name", ' ', a."last_name") AS "actor"
FROM "actor" a
JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
JOIN "film_category" fc ON fa."film_id" = fc."film_id"
JOIN "category" c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Sci-Fi'
ORDER BY "actor";

--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

WITH fecha_spartacus AS (
    SELECT MIN(r."rental_date") AS "primer_alquiler"
    FROM "film" f
    JOIN "inventory" i ON f."film_id" = i."film_id"
    JOIN "rental" r ON i."inventory_id" = r."inventory_id"
    WHERE f."title" = 'SPARTACUS CHEAPER')
SELECT DISTINCT a."first_name", a."last_name"
FROM "actor" a
JOIN "film_actor" fa ON a."actor_id" = fa."actor_id"
JOIN "film" f ON fa."film_id" = f."film_id"
JOIN "inventory" i ON f."film_id" = i."film_id"
JOIN "rental" r ON i."inventory_id" = r."inventory_id"
WHERE r."rental_date" > (SELECT "primer_alquiler" FROM fecha_spartacus);

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.

SELECT a."first_name" as  "nombre", a."last_name" as "apellido"
FROM "actor" a
WHERE NOT EXISTS (
    SELECT 1
    FROM "film_actor" fa
    JOIN "film_category" fc ON fa."film_id" = fc."film_id"
    JOIN "category" c ON fc."category_id" = c."category_id"
    WHERE fa."actor_id" = a."actor_id"
    AND c."name" = 'Music'
)
ORDER BY a."last_name", a."first_name";

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

SELECT DISTINCT f."title" as "titulo_pelicula"
FROM "film" f
JOIN "inventory" i ON f."film_id" = i."film_id"
JOIN "rental" r ON i."inventory_id" = r."inventory_id"
WHERE r."return_date" IS NOT NULL
  AND r."rental_date" IS NOT NULL
  AND r."return_date" - r."rental_date" > INTERVAL '8 days'
ORDER BY f."title";


--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.

SELECT f."title" AS "titulo_pelicula"
FROM "film" f
JOIN "film_category" fc ON f."film_id" = fc."film_id"
JOIN "category" c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Animation'
ORDER BY f."title";

--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.

SELECT  f."title" AS "titulo_pelicula"
FROM "film" f
WHERE f."length" = (SELECT "length" FROM "film" WHERE "title" = 'DANCING FEVER')
ORDER BY f."title";

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

SELECT c."first_name" as "nombre", c."last_name" as"apellido"
FROM "customer" c
JOIN "rental" r ON c."customer_id" = r."customer_id"
JOIN "inventory" i ON r."inventory_id" = i."inventory_id"
JOIN "film" f ON i."film_id" = f."film_id"
GROUP BY c."customer_id"
HAVING COUNT(DISTINCT f."film_id") >= 7
ORDER BY c."last_name", c."first_name";

--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT c."name" AS "categoria", COUNT(r."rental_id") AS "total_alquileres"
FROM "category" c
JOIN "film_category" fc ON c."category_id" = fc."category_id"
JOIN "film" f ON fc."film_id" = f."film_id"
JOIN "inventory" i ON f."film_id" = i."film_id"
JOIN "rental" r ON i."inventory_id" = r."inventory_id"
GROUP BY c."name"
ORDER BY "total_alquileres";

--62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT c."name" AS "categoria", COUNT(f."film_id") AS "peliculas_estrenadas_2006"
FROM "category" c
JOIN "film_category" fc ON c."category_id" = fc."category_id"
JOIN "film" f ON fc."film_id" = f."film_id"
WHERE f."release_year" = '2006'
GROUP BY c. "name",  f."release_year"
ORDER BY "peliculas_estrenadas_2006" asc;

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT concat (s."first_name",' ', s."last_name") as "trabajador", t."store_id" as "tienda"
FROM "staff" s
CROSS JOIN "store" t;

--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas

SELECT c."customer_id" as "id_cliente", c."first_name" as "nombre_cliente", c."last_name" as "apellido_cliente", 
	COUNT(DISTINCT r."rental_id") AS "total_alquileres"
FROM "customer" c
JOIN "rental" r ON c."customer_id" = r."customer_id"
JOIN "inventory" i ON r."inventory_id" = i."inventory_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
ORDER BY "total_alquileres" ASC;













