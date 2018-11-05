require "test_helper"

describe CustomersController do
  # describe "index" do
  # it "should get index" do
  #   # Act
  #   get customers_path
  #
  #   # Assert
  #   must_respond_with :success
  # end
  ############################
  #   describe "create" do
  # it "can create a customer with valid data" do
  #   # Arrange
  #   customer_data = {
  #     customer: {
  #       name: "new test customer",
  #       author_id: Author.first.id
  #     }
  #   }
  #
  #   # Assumptions
  #   test_customer = Customer.new(customer_data[:customer])
  #   test_customer.must_be :valid?, "Customer data was invalid. Please come fix this test"
  #
  #   # Act
  #   expect {
  #     post customers_path, params: customer_data
  #   }.must_change('Customer.count', +1)
  #
  #   # Assert
  #   must_redirect_to customer_path(Customer.last)
  # end
  #
  # it "does not create a new customer w/ invalid data" do
  #     # Arrange
  #     customer_data = {
  #       customer: {
  #         title: Customer.first.title,
  #         author_id: Author.first.id
  #       }
  #     }
  #
  #     # Assumptions
  #     Customer.new(customer_data[:customer]).wont_be :valid?, "Customer data wasn't invalid. Please come fix this test"
  #
  #     # Act
  #     expect {
  #       post customers_path, params: customer_data
  #     }.wont_change('Customer.count')
  #
  #     # Assert
  #     must_respond_with :bad_request
  #   end
  # end
  ###############################
  # describe "show" do
  #
  #    it "should respond with success for showing an existing customer" do
  #      # Arrange
  #      existing_customer = customers(:poodr)
  #
  #      # Act
  #      get customer_path(existing_customer.id)
  #
  #      # Assert
  #      must_respond_with :success
  #    end
  #
  #    it "should respond with not found for showing a non-existing customer" do
  #      # Arrange
  #      customer = customers(:poodr)
  #      id = customer.id
  #
  #      get customer_path(id)
  #      must_respond_with :success
  #
  #      customer.destroy
  #
  #      # Act
  #      get customer_path(id)
  #
  #      # Assert
  #      must_respond_with :missing
  #    end
  #
  #  end
  ######################################
  # describe "destroy" do
  #   it "can destroy an existing customer" do
  #     # Arrange
  #     customer = customers(:poodr)
  #     # before_customer_count = Customer.count
  #
  #     # Act
  #     expect {
  #       delete customer_path(customer)
  #     }.must_change('Book.count', -1)
  #
  #     # Assert
  #     must_respond_with :redirect
  #     must_redirect_to customers_path
  #
  #     # expect(Customer.count).must_equal(
  #     #   before_customer_count - 1,
  #     #   "customer count did not decrease"
  #     # )
  #   end
  # end
end
