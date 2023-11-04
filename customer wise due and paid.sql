   SELECT pc.id as customerId,pc.customername,pc.customermobile,pc.customeremail,sdp.paid_due AS total_paid_due,sd.due_amount AS total_due_amount,(sd.due_amount-sdp.paid_due) AS totl_Payable_d_amt
   FROM poscustomer pc 
   LEFT JOIN (SELECT sdp.customer_id,SUM(sdp.paid_due) as paid_due FROM sell_due_paid sdp
					GROUP BY sdp.customer_id
				)sdp ON pc.id = sdp.customer_id 
	LEFT JOIN (SELECT sd.customer_id,SUM(sd.due_amount) AS due_amount FROM sell_due sd )sd ON pc.id = sd.customer_id
	WHERE pc.id = 113 AND pc.bus_id =  98