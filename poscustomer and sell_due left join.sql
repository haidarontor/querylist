/*SELECT * From poscustomer 

LEFT JOIN sell_due
ON poscustomer.id = sell_due.customer_id 
 WHERE id =113 AND bus_id=98 */

SELECT pc.*, sum(sd.due_amount) AS due_total
FROM poscustomer pc
LEFT JOIN sell_due sd ON pc.id = sd.customer_id
WHERE pc.id = 113 AND pc.bus_id = 98;
