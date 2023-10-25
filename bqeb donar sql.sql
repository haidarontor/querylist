 total paid donar 
 
 SELECT
    dl.id,
    dl.donor_name,
    dl.donor_type,
    dl.donor_mobile,
    dl.created_date,
    dl.donor_amount AS instal_amount,
    (CASE
        WHEN dl.donor_type = 1 THEN dl.donor_amount * 1
        WHEN dl.donor_type = 2 THEN dl.donor_amount * 12
        ELSE 0
    END) AS payable_amount,
    dp.donor_paid_amount,
    DATEDIFF(CURDATE(), dl.created_date) / 30 AS duration_in_month
FROM donor_list dl
LEFT JOIN (
    SELECT donor_id, SUM(donor_paid_amount) AS donor_paid_amount
    FROM donor_payment
    GROUP BY donor_id
) dp ON dl.id = dp.donor_id
WHERE dl.donor_type IN (1, 2)
AND dp.donor_paid_amount = (
    CASE
        WHEN dl.donor_type = 1 THEN dl.donor_amount * 1
        WHEN dl.donor_type = 2 THEN dl.donor_amount * 12
        ELSE 0
    END
);


total due donar
SELECT sq.ID,sq.donor_name,sq.donor_type,sq.donor_mobile,sq.instal_amount,
	   sq.payable_amount,sq.donor_paid_amount,sq.duration_in_month
FROM(
		select dl.id,dl.donor_name,dl.donor_type, dl.donor_mobile, dl.created_date,dl.donor_amount AS instal_amount,
		      (case when dl.donor_type = 1 then dl.donor_amount*1 when dl.donor_type = 2 then dl.donor_amount * 12 ELSE 0  end) AS payable_amount,
				dp.donor_paid_amount, DATEDIFF(CURDATE(),dl.created_date)/30 AS duration_in_month              
		      from donor_list dl 
		   LEFT  JOIN (SELECT dp.donor_id,SUM(dp.donor_paid_amount) AS donor_paid_amount 
			  					from donor_payment dp
		                  GROUP BY dp.donor_id) dp ON dl.id=dp.donor_id
		   WHERE dl.donor_type IN(1,2) 
   ) sq where ISNULL(sq.payable_amount)!=ISNULL(sq.donor_paid_amount)