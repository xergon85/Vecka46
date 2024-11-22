USE [Sakila]
GO
/****** Object:  StoredProcedure [dbo].[RentMovie]    Script Date: 2024-11-22 18:32:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Christoffer
-- Create date: 2024-11-21
-- Description:	Rent film
-- =============================================
CREATE PROCEDURE [dbo].[RentMovie] 
	-- Add the parameters for the stored procedure here
	@RentalDate datetime null, 
	@InventoryId int = 0,
	@CustomerId int = 0
AS
BEGIN
	DECLARE @StaffId int = 1;
	DECLARE @RentalRate decimal(5,2)
	SET @RentalDate = ISNULL(@RentalDate, GETDATE())

	IF NOT EXISTS (SELECT 1 FROM inventory WHERE inventory_id = @InventoryId)
	BEGIN
		return;
	END;
	IF NOT EXISTS (SELECT 1 FROM customer WHERE customer_id = @CustomerId)
	BEGIN
		return;
	END;

	SELECT @RentalRate = film.rental_rate
	FROM inventory
	INNER JOIN film ON inventory.film_id = film.film_id
	WHERE inventory.inventory_id = @InventoryId;

	IF @RentalRate IS NULL
	BEGIN
		RETURN;
	END;

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRANSACTION
			-- Create rental row
			INSERT INTO rental 
				(rental_date, inventory_id, customer_id,  staff_id, last_update) 
			VALUES 
				(@RentalDate, @InventoryId, @CustomerId, @StaffId, GETDATE());
			-- Create payment
			INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date, last_update)
			VALUES (@CustomerId, @StaffId, SCOPE_IDENTITY(), @RentalRate, GETDATE(), GETDATE())
			COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
		END;
		THROW;
	END CATCH
END
