Q1: Who is the senior most employee based on job title? 
  
SELECT * 
FROM employee
ORDER BY levels DESC 
LIMIT 1

Q2: Country with most invoices?
  
SELECT COUNT (*) as c, billing_country 
FROM invoice
GROUP BY billing_country 
ORDER BY c DESC
LIMIT 1

Q3:Top 3 values of Total Invoice? 
  
SELECT total
FROM invoice 
ORDER BY total DESC
LIMIT 3

Q4: Which city has best customer? Query to return highest sum of invoice total (City name and sum of invoice totals)
  
SELECT SUM(total) as invoice_total, billing_city
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 1

Q5: Who is the best cutomer/ customer spent most money?
  
SELECT customer.customer_id, customer.first_name, customer.last_name,
SUM(invoice.total) as total
FROM customer 
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC 
LIMIT 1


Q6: Write query to fetch email, first name, last name and genre of all rock music listeners and order list alphabetically 
  
SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
   SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

Q7: Artist who has written most rock music songs (Top 10 List)
  
SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name='Rock'
GROUP BY artist.artist_id 
ORDER by number_of_songs DESC
LIMIT 10;


Q8: Return track names where song length is greater than average song length
  
SELECT name,milliseconds
FROM track
WHERE milliseconds > (
   SELECT AVG(milliseconds) AS avg_track_length
   FROM track)
ORDER BY milliseconds DESC;

Q9: How much spent my customers on artist? Return customer name, artist name and total spent.
  
WITH best_selling_artist AS (
     SELECT artist.artist_id AS artist_id, artist.name AS artist_name,
	 SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
     FROM invoice_line
     JOIN track ON track.track_id = invoice_line.track_id
	 JOIN album ON album.album_id = track.album_id
	 JOIN artist ON artist.artist_id = album.artist_id
	 GROUP BY 1
	 ORDER BY 3 DESC
	 LIMIT 1
)















