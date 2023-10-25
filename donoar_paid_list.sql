 SELECT
                dl.id,
                dl.donor_name,
                dl.donor_type,
                dl.donor_mobile,
                dl.created_date,
                dl.donor_amount AS instal_amount,
                (CASE
                    WHEN dl.donor_type = 1 THEN dl.donor_amount * FLOOR	(DATEDIFF(CURDATE(),dl.created_date)/30/12)
                    WHEN dl.donor_type = 2 THEN dl.donor_amount *  FLOOR (DATEDIFF(CURDATE(),dl.created_date)/30)
                    ELSE 0
                END) AS payable_amount,
                dp.donor_paid_amount,
                FLOOR (DATEDIFF(CURDATE(),dl.created_date)/30) AS duration_in_month, 
			  		 FLOOR	(DATEDIFF(CURDATE(),dl.created_date)/30/12) AS duration_in_year
     
            FROM donor_list dl
            LEFT JOIN (
                SELECT donor_id, SUM(donor_paid_amount) AS donor_paid_amount
                FROM donor_payment
                GROUP BY donor_id
            ) dp ON dl.id = dp.donor_id
            WHERE dl.donor_type IN (1, 2)
            AND dp.donor_paid_amount = (
                CASE
                    WHEN dl.donor_type = 1 THEN dl.donor_amount * FLOOR	(DATEDIFF(CURDATE(),dl.created_date)/30/12)
                    WHEN dl.donor_type = 2 THEN dl.donor_amount *FLOOR (DATEDIFF(CURDATE(),dl.created_date)/30)
                    ELSE 0
                END
            )