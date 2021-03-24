require 'csv'

namespace :users do
  desc 'verify appstore receipt'
  task verify_ios_receipt: :environment do
    config = CandyCheck::AppStore::Config.new(environment: :production)
    verifier = CandyCheck::AppStore::Verifier.new(config)
    user = User.find(223)
    receipt_verification = user.receipt_verification
    #puts(receipt_verification)
    secret = Rails.application.credentials.appstore[:secret]
    puts(secret)
    #product_ids = ['mobile_annual']
    receipt = verifier.verify_subscription(
      user.receipt_verification, secret
    )
    if receipt.class == CandyCheck::AppStore::Receipt
      #check_appstore_receipt(receipt) # A method to deal with data received from AppStore
      #render json: current_user.reload, status: :ok
    elsif receipt.class == CandyCheck::AppStore::VerificationFailure
      puts("#{receipt.code} #{receipt.message}")
    end
  end

  desc 'verify playstore reciept'
  task verify_android_receipt: :environment do
    service_path = Rails.root.join('qw-service.json')
    authorization = CandyCheck::PlayStore.authorization(service_path)
    verifier = CandyCheck::PlayStore::Verifier.new(authorization: authorization)
    token = 'feipajjkjjpmpaclcpfcipmb.AO-J1OxMGe-earhF_S6XzzZEFq1sUjKAU57uWpN-nnJW9faqvSB7qQsLmAljpOaVID0396lost8yJV7qm66AAmfPGeOoTcHK6VTN9zQCsdWm7D-_zjaK6qs'
    receipt = verifier.verify_subscription_purchase(
      package_name: "com.quantwrestling.mobile",
      subscription_id: "qw_annual",
      token: token
    )
    if receipt.class == CandyCheck::AppStore::Receipt
      #check_appstore_receipt(receipt) # A method to deal with data received from AppStore
      #render json: current_user.reload, status: :ok
    elsif receipt.class == CandyCheck::PlayStore::VerificationFailure
      puts("#{receipt.code} #{receipt.message}")
    end
  end

  desc 'generate user export'
  task generate_export: :environment do
    attr = User.column_names
    CSV.open(File.join(Rails.root, 'exports', 'users.csv'), "wb") do |csv|
      csv << attr
      User.all.each do |user|
        csv << attr.map { |a| user.send(a) }
      end
    end
  end
end
