class ChargesController < ApplicationController

  def create

      # Creates a Stripe Customer object, for associating
      # with the charge
      customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
      )

      # Where the real magic happens
      charge = Stripe::Charge.create(
        customer: customer.id, # Note -- this is NOT the user_id in your app
        amount: 1500, #Amount.default,
        description: "Premium Membership - #{current_user.email}",
        currency: 'usd'
      )

      flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
      current_user.premium!
      redirect_to root_path # or wherever


      # Stripe will send back CardErrors, with friendly messages
      # when something goes wrong.
      # This `rescue block` catches and displays those errors.
      rescue Stripe::CardError => e
        flash[:alert] = e.message
        redirect_to new_charge_path


  end

  def downgrade(id)
    @wikis = Wiki.where(user_id: id)
    @wikis.update_all(private: false)
  end



  def new

    if current_user.premium?
        flash[:notice] = "The account: #{current_user.email} has been downgraded to a standard account. NO REFUNDS!"
        current_user.standard!
        downgrade(current_user.id)
        redirect_to root_path

    else


      @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "Premium Membership upgrade - #{current_user.email}",
        amount: 1500#Amount.default
      }
    end
  end
end
