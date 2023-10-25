/*SELECT sq.ID,sq.donor_name,sq.donor_type,sq.donor_mobile,sq.instal_amount,
	    sq.payable_amount,sq.donor_paid_amount,sq.duration_in_month,sq.duration_in_year	   
FROM(select dl.id,dl.donor_name,dl.donor_type, dl.donor_mobile, dl.created_date,dl.donor_amount AS instal_amount,		
		      (case when dl.donor_type = 1 then dl.donor_amount * FLOOR	(DATEDIFF(CURDATE(),dl.created_date)/30/12) 
				when dl.donor_type = 2 then dl.donor_amount * FLOOR (DATEDIFF(CURDATE(),dl.created_date)/30) ELSE 0  end) 
				AS payable_amount,dp.donor_paid_amount,				
			   FLOOR (DATEDIFF(CURDATE(),dl.created_date)/30) AS duration_in_month, 
			   FLOOR	(DATEDIFF(CURDATE(),dl.created_date)/30/12) AS duration_in_year 
	   from donor_list dl 
	   LEFT  JOIN (SELECT dp.donor_id,SUM(dp.donor_paid_amount) AS donor_paid_amount 
		  				from donor_payment dp
	               GROUP BY dp.donor_id
						) dp ON dl.id=dp.donor_id
	   WHERE dl.donor_type IN(1,2) 
) sq where ISNULL(sq.payable_amount)!=ISNULL(sq.donor_paid_amount) */

SELECT sq.ID,sq.donor_name,sq.donor_type,sq.donor_mobile,sq.instal_amount,
	    sq.payable_amount,sq.donor_paid_amount,sq.duration_in_month,sq.duration_in_year	   
FROM(select dl.id,dl.donor_name,dl.donor_type, dl.donor_mobile, dl.created_date,dl.donor_amount AS instal_amount,		
		      (case when dl.donor_type = 1 then dl.donor_amount * FLOOR	(DATEDIFF(CURDATE(),dl.created_date)/30/12) 
				when dl.donor_type = 2 then dl.donor_amount * FLOOR (DATEDIFF(CURDATE(),dl.created_date)/30) ELSE 0  end) 
				AS payable_amount,dp.donor_paid_amount,				
			   FLOOR (DATEDIFF(CURDATE(),dl.created_date)/30) AS duration_in_month, 
			   FLOOR	(DATEDIFF(CURDATE(),dl.created_date)/30/12) AS duration_in_year 
	   from donor_list dl 
	   LEFT  JOIN (SELECT dp.donor_id,SUM(dp.donor_paid_amount) AS donor_paid_amount 
		  				from donor_payment dp
	               GROUP BY dp.donor_id
						) dp ON dl.id=dp.donor_id
	   WHERE dl.donor_type IN(1,2) 
) sq

 where ISNULL(sq.payable_amount) <> ISNULL(sq.donor_paid_amount)