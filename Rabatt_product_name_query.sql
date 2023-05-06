SELECT 
    c.first_name + ' ' + c.last_name AS customer_name,
    ii.quantity,
    ii.price,
    d.discount_value AS discount_applied,
    (ii.quantity * ii.price) - d.discount_value AS total,
    pg.product_group_name
FROM 
    Invoice_Element AS ii
    JOIN Invoice AS i ON ii.invoice_id = i.invoice_id
    JOIN Customer AS c ON i.customer_id = c.customer_id
    LEFT JOIN Discount AS d ON ii.discount_id = d.discount_id
    JOIN Item AS it ON ii.item_id = it.item_id
    JOIN Product_Group AS pg ON it.product_group_id = pg.product_group_id;