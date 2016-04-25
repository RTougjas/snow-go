CREATE VIEW v_menu_items AS
SELECT menuItem.ID AS menuItem_id, menuItem.name AS menuItem_name, price AS menuItem_price, category.ID AS category_id, category.name AS category_name, location.ID AS location_id, location.name AS location_name FROM
menuItem INNER JOIN
category ON menuItem.category = category.ID
INNER JOIN location
ON menuItem.location = location.ID;

CREATE VIEW v_categories AS 
SELECT category.ID AS category_id, category.name AS category_name, category.location AS location_id, location.name AS location_name, generalCategory.ID AS general_id, generalCategory.name AS general_name
FROM category INNER JOIN
location ON category.location = location.ID
INNER JOIN generalCategory
ON category.general = generalCategory.ID;

CREATE VIEW v_reservation_details AS
select reservation.id AS reservation_id, reservation.firstName as first_name, reservation.lastName AS last_name, reservation.phone AS phone, reservation.email AS email, reservation.updated AS updated, reservation.due AS aeg, reservation.notes AS notes, reservation.people AS people, reservation.location AS location, location.name AS location_name, location.aadress AS location_address,
reservationItems.ID AS reservationItem_id, reservationItems.menuItem AS reservation_menuItem, menuItem.name AS menuItem, menuItem.price AS menuItem_price, reservationItems.amount AS reservationItem_amount
FROM reservation INNER JOIN 
location ON reservation.location = location.ID INNER JOIN
reservationItems ON reservation.ID = reservationItems.reservation
INNER JOIN menuItem ON
menuItem.ID = reservationItems.menuItem;
