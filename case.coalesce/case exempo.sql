SELECT v.venda_bruta
	,CASE 
		WHEN v.venda_bruta < 100
			THEN 'MENOR QUE 100'
		WHEN v.venda_bruta BETWEEN 101 AND 200
			THEN 'ENTRE 101 E 200'
		ELSE 'MAIOR QUE 200'
		END RESULTADO
FROM venda v;
